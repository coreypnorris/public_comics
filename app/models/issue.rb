class Issue < ActiveRecord::Base
  acts_as_commentable

  validates :number, :presence => true
  validates :cover, :presence => true

  has_many :pages
  has_many :comments, :as => :commentable
  belongs_to :title

  def title_name
    title.try(:name)
  end

  def title_name=(name)
    self.title = Title.find_by_name(name) if name.present?
  end
end
