# repurposed from http://www.miguelsanmiguel.com/2011/04/03/hideous-obfuscated-ids
module Obfuscatable
  extend ActiveSupport::Concern
  include ActiveRecord::Callbacks

  MAXID         = 2147483647 # (2**31 - 1)
  PRIME         = 350470937  # a very big prime number of your choice (like 9 digits big)
  PRIME_INVERSE = 622127401 # another big integer number so that (PRIME * PRIME_INVERSE) & MAXID == 1
  RNDXOR        = 1195573013 # some random big integer number, just not bigger than MAXID

  module InstanceMethods
    # obfuscate the original id
    def hide_id
      self.hashed_id = (((self.id * PRIME) & MAXID) ^ RNDXOR).to_s(16)
      self.save
    end

    # obfuscated id back to original, in case you dont feel like calling id on the object :)
    def reveal_id
      ((self.hashed_id.to_i(16) ^ RNDXOR) * PRIME_INVERSE) & MAXID
    end

    # override to_param so we can retrieve the record using the hashed_id in the url
    # see http://api.rubyonrails.org/classes/ActiveRecord/Base.html#method-i-to_param
    def to_param
      hashed_id
    end

  end

  module ClassMethods
    def find(id)
      record = self.find_by_hashed_id(id.to_s)
      record.nil? ? super : record
    end
  end

  included do
    after_create :hide_id
  end

end
