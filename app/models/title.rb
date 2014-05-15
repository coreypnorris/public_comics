class Title < ActiveRecord::Base
  validates :name, :presence => true

  has_many :issues
  belongs_to :genre
end
