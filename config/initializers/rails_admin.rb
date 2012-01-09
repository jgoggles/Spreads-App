#         ooooooooo.              o8o  oooo                 .o.             .o8                     o8o              
#         `888   `Y88.            `"'  `888                .888.           "888                     `"'              
#          888   .d88'  .oooo.   oooo   888   .oooo.o     .8"888.      .oooo888  ooo. .oo.  .oo.   oooo  ooo. .oo.   
#          888ooo88P'  `P  )88b  `888   888  d88(  "8    .8' `888.    d88' `888  `888P"Y88bP"Y88b  `888  `888P"Y88b  
#          888`88b.     .oP"888   888   888  `"Y88b.    .88ooo8888.   888   888   888   888   888   888   888   888  
#          888  `88b.  d8(  888   888   888  o.  )88b  .8'     `888.  888   888   888   888   888   888   888   888  
#         o888o  o888o `Y888""8o o888o o888o 8""888P' o88o     o8888o `Y8bod88P" o888o o888o o888o o888o o888o o888o 

# RailsAdmin config file. Generated on October 03, 2011 21:49
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.current_user_method { current_user } # auto-generated

  config.main_app_name { ['Spreads', 'Admin'] } # auto-generated

  config.audit_with :history, User

  #  ==> Authentication (before_filter)
  # This is run inside the controller instance so you can setup any authentication you need to.
  # By default, the authentication will run via warden if available.
  # and will run on the default user scope.
  # If you use devise, this will authenticate the same as authenticate_user!
  # Example Devise admin
  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     authenticate_admin!
  #   end
  # end
  # Example Custom Warden
  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     warden.authenticate! :scope => :paranoid
  #   end
  # end

  #  ==> Authorization
  # Use cancan https://github.com/ryanb/cancan for authorization:
  config.authorize_with :cancan

  # Or use simple custom authorization rule:
  # config.authorize_with do
  #   redirect_to root_path unless warden.user.is_admin?
  # end

  # Use a specific role for ActiveModel's :attr_acessible :attr_protected
  # Default is :default
  # current_user is accessible in the block if you want to make it user specific.
  # config.attr_accessible_role { :default }

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 50

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models << [Authentication, Badge, Conference, Division, EarnedBadge, Game, GameDetail, League, Message, Pick, PickSet, Pool, PoolType, PoolUser, Role, Standing, Team, Topic, User, Week]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models << [Authentication, Badge, Conference, Division, EarnedBadge, Game, GameDetail, League, Message, Pick, PickSet, Pool, PoolType, PoolUser, Role, Standing, Team, Topic, User, Week]

  # Application wide tried label methods for models' instances
  # config.label_methods << [:description] # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #   
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #     
  #     fields :name, :other_name do
  #       # Configuration here will affect all fields named [:name, :other_name], in the list section, for all included models
  #     end
  #     
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional. 
  # RailsAdmin will try his best to provide the best defaults for each section, for each field! 
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead. 
  # Less code is better code!
  # config.model MyModel do
  #   # Here goes your cross-section field configuration for ModelName.
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  #   show do
  #     # Here goes the fields configuration for the show view
  #   end
  #   export do
  #     # Here goes the fields configuration for the export view (CSV, yaml, XML)
  #   end
  #   edit do
  #     # Here goes the fields configuration for the edit view (for create and update view)
  #   end
  #   create do
  #     # Here goes the fields configuration for the create view, overriding edit section settings
  #   end
  #   update do
  #     # Here goes the fields configuration for the update view, overriding edit section settings
  #   end
  # end

  # fields configuration is described in the Readme, if you have other question, ask us on the mailing-list! 

  #  ==> Your models configuration, to help you get started!

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Authentication do
  #   # Found associations: 
  #   field :user, :belongs_to_association
  #   # Found columns:
  #   field :id, :integer
  #   field :user_id, :integer        # Hidden
  #   field :provider, :string
  #   field :uid, :string
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Badge do
  #   # Found associations: 
  #   field :earned_badges, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :desc, :text
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :image, :string
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Conference do
  #   # Found associations: 
  #   field :league, :belongs_to_association
  #   field :teams, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :league_id, :integer        # Hidden
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Division do
  #   # Found associations: 
  #   field :teams, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model EarnedBadge do
  #   # Found associations: 
  #   field :badge, :belongs_to_association
  #   field :user, :belongs_to_association
  #   field :pool, :belongs_to_association
  #   field :week, :belongs_to_association
  #   field :pick_set, :belongs_to_association
  #   field :pick, :belongs_to_association
  #   # Found columns:
  #   field :id, :integer
  #   field :badge_id, :integer        # Hidden
  #   field :user_id, :integer        # Hidden
  #   field :pool_id, :integer        # Hidden
  #   field :week_id, :integer        # Hidden
  #   field :pick_set_id, :integer        # Hidden
  #   field :pick_id, :integer        # Hidden
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Game do
  #   # Found associations: 
  #   field :week, :belongs_to_association
  #   field :game_details, :has_many_association
  #   field :teams, :has_many_association
  #   field :picks, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :date, :datetime
  #   field :week_id, :integer        # Hidden
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model GameDetail do
  #   # Found associations: 
  #   field :game, :belongs_to_association
  #   field :team, :belongs_to_association
  #   # Found columns:
  #   field :id, :integer
  #   field :game_id, :integer        # Hidden
  #   field :team_id, :integer        # Hidden
  #   field :is_home, :boolean
  #   field :score, :integer
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model League do
  #   # Found associations: 
  #   field :conferences, :has_many_association
  #   field :teams, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :sport, :string
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Message do
  #   # Found associations: 
  #   field :topic, :belongs_to_association
  #   field :user, :belongs_to_association
  #   # Found columns:
  #   field :id, :integer
  #   field :user_id, :integer        # Hidden
  #   field :topic_id, :integer        # Hidden
  #   field :body, :text
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Pick do
  #   # Found associations: 
  #   field :pick_set, :belongs_to_association
  #   field :game, :belongs_to_association
  #   field :team, :belongs_to_association
  #   field :earned_badges, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :spread, :float
  #   field :result, :integer
  #   field :game_id, :integer        # Hidden
  #   field :pick_set_id, :integer        # Hidden
  #   field :team_id, :integer        # Hidden
  #   field :over_under, :float
  #   field :is_over, :boolean
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :over_under_result, :integer
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model PickSet do
  #   # Found associations: 
  #   field :pool, :belongs_to_association
  #   field :user, :belongs_to_association
  #   field :week, :belongs_to_association
  #   field :standing, :has_one_association
  #   field :picks, :has_many_association
  #   field :earned_badges, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :user_id, :integer        # Hidden
  #   field :pool_id, :integer        # Hidden
  #   field :week_id, :integer        # Hidden
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :hashed_id, :string
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Pool do
  #   # Found associations: 
  #   field :pool_type, :belongs_to_association
  #   field :pick_sets, :has_many_association
  #   field :picks, :has_many_association
  #   field :pool_users, :has_many_association
  #   field :users, :has_many_association
  #   field :standings, :has_many_association
  #   field :topics, :has_many_association
  #   field :earned_badges, :has_many_association
  #   field :leagues, :has_and_belongs_to_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :pool_type_id, :integer        # Hidden
  #   field :name, :string
  #   field :free, :boolean
  #   field :cost, :integer
  #   field :first_place_payout, :integer
  #   field :second_place_payout, :integer
  #   field :third_place_payout, :integer
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :hashed_id, :string
  #   field :private, :boolean
  #   field :password, :password
  #   field :max_players, :integer
  #   field :min_players, :integer
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model PoolType do
  #   # Found associations: 
  #   field :pools, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :max_picks, :integer
  #   field :min_picks, :integer
  #   field :spreads, :boolean
  #   field :over_under, :boolean
  #   field :is_tiebreaker, :boolean
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model PoolUser do
  #   # Found associations: 
  #   field :pool, :belongs_to_association
  #   field :user, :belongs_to_association
  #   # Found columns:
  #   field :id, :integer
  #   field :pool_id, :integer        # Hidden
  #   field :user_id, :integer        # Hidden
  #   field :pool_admin, :boolean
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :paid, :boolean
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Role do
  #   # Found associations: 
  #   field :users, :has_and_belongs_to_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Standing do
  #   # Found associations: 
  #   field :user, :belongs_to_association
  #   field :pool, :belongs_to_association
  #   field :week, :belongs_to_association
  #   field :pick_set, :belongs_to_association
  #   # Found columns:
  #   field :id, :integer
  #   field :user_id, :integer        # Hidden
  #   field :pool_id, :integer        # Hidden
  #   field :week_id, :integer        # Hidden
  #   field :wins, :integer
  #   field :losses, :integer
  #   field :pushes, :integer
  #   field :points, :integer
  #   field :over_under_points, :integer
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :pick_set_id, :integer        # Hidden
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  config.model Team do
    object_label_method :nickname     # Name of the method called for pretty printing an *instance* of ModelName
    #   # Found associations: 
    #   field :league, :belongs_to_association
    #   field :conference, :belongs_to_association
    #   field :division, :belongs_to_association
    #   field :game_details, :has_many_association
    #   field :games, :has_many_association
    #   field :picks, :has_many_association
    #   # Found columns:
    #   field :id, :integer
    #   field :city, :string
    #   field :nickname, :string
    #   field :league_id, :integer        # Hidden
    #   field :conference_id, :integer        # Hidden
    #   field :division_id, :integer        # Hidden
    #   field :created_at, :datetime
    #   field :updated_at, :datetime
    #   # Sections: 
    #   list do; end
    #   export do; end
    #   show do; end
    #   edit do; end
    #   create do; end
    #   update do; end
  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Topic do
  #   # Found associations: 
  #   field :pool, :belongs_to_association
  #   field :user, :belongs_to_association
  #   field :messages, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :pool_id, :integer        # Hidden
  #   field :user_id, :integer        # Hidden
  #   field :title, :string
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  config.model User do
    object_label_method :email     # Name of the method called for pretty printing an *instance* of ModelName
  #   # Found associations: 
  #   field :roles, :has_and_belongs_to_many_association
  #   field :authentications, :has_many_association
  #   field :pool_users, :has_many_association
  #   field :pools, :has_many_association
  #   field :pick_sets, :has_many_association
  #   field :standings, :has_many_association
  #   field :topics, :has_many_association
  #   field :messages, :has_many_association
  #   field :earned_badges, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :email, :string
  #   field :password, :password
  #   field :password_confirmation, :password
  #   field :reset_password_token, :string        # Hidden
  #   field :reset_password_sent_at, :datetime
  #   field :remember_created_at, :datetime
  #   field :sign_in_count, :integer
  #   field :current_sign_in_at, :datetime
  #   field :last_sign_in_at, :datetime
  #   field :current_sign_in_ip, :string
  #   field :last_sign_in_ip, :string
  #   field :hashed_id, :string
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   field :first_name, :string
  #   field :last_name, :string
  #   field :favorite_nfl_team_id, :integer
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
   end

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user

  # config.model Week do
  #   # Found associations: 
  #   field :games, :has_many_association
  #   field :pick_sets, :has_many_association
  #   field :standings, :has_many_association
  #   field :earned_badges, :has_many_association
  #   # Found columns:
  #   field :id, :integer
  #   field :name, :string
  #   field :start_date, :datetime
  #   field :end_date, :datetime
  #   field :created_at, :datetime
  #   field :updated_at, :datetime
  #   # Sections: 
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  #  end

end

# You made it this far? You're looking for something that doesn't exist! Add it to RailsAdmin and send us a Pull Request!
