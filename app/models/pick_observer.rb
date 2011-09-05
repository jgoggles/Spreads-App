class PickObserver < ActiveRecord::Observer

  def after_save(pick)
    unless pick.is_non_pick?
      Delayed::Job.enqueue Badging.new(:pick, pick.id)
    end
  end

end
