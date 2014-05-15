class Issue < ActiveRecord::Base
  validates :number, :presence => true
  validates :cover, :presence => true

  has_many :pages
  belongs_to :title
end
