class BadgeObserver < ActiveRecord::Observer
  observe :pick

  def after_create(pick)
    Resque.enqueue(Badging, pick.id)
  end
end
