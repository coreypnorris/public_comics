class Page < ActiveRecord::Base
  validates :image, :presence => true
  validates :number, :presence => true

  belongs_to :issue
end
