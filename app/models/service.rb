class Service < ActiveRecord::Base
  has_many :items, :through => :menus
  belongs_to :hotel
  belongs_to :guest
  belongs_to :menu

  after_create :schedule_post_create_job!

  private

  def schedule_post_create_job!
    PostCreateServiceWorker.perform_async(id)
  end
end
