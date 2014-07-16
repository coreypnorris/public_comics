class Genre < ActiveRecord::Base
  validates :name, :presence => true

  has_many :titles

  def to_param
    name
  end
end
