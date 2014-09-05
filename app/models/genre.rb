class Genre < ActiveRecord::Base
  validates :name, :presence => true

  has_and_belongs_to_many :titles, join_table: :genres_titles

  def to_param
    name
  end
end
