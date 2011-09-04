class PickObserver < ActiveRecord::Observer

  def after_save(pick)
    Resque.enqueue(Badging, :pick, pick.id)
  end

end
