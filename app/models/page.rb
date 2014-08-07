class Page < ActiveRecord::Base
  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :issue_id

  belongs_to :issue

  has_attached_file :image

  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png']

  def to_param
    number.to_s
  end
end
