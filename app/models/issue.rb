class Issue < ActiveRecord::Base
  acts_as_commentable

  validates :number, :presence => true
  validates :cover, :presence => true

  has_many :pages
  has_many :comments, :as => :commentable
  belongs_to :title
end
