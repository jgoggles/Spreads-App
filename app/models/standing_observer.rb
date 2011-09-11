class StandingObserver < ActiveRecord::Observer

  def after_save(standing)
    Delayed::Job.enqueue Badging.new(:standing, standing.id)
  end

end
