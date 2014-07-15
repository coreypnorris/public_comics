class Page < ActiveRecord::Base
  validates :image, :presence => true
  validates :number, :presence => true

  belongs_to :issue

  def to_param
    number.to_s
  end
end
