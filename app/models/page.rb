class Page < ActiveRecord::Base
  validates :image, :presence => true

  belongs_to :issue
end
