class Issue < ActiveRecord::Base
  acts_as_commentable

  validates :number, :presence => true
  validates :title_id, :presence => true
  validates :approved, :presence => true

  has_many :pages, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :title
  belongs_to :user

  scope :approved, -> { where(approved: 1) }
  scope :unapproved, -> { where(approved: 0) }

  def search
    title.try(:name)
  end

  def search=(name)
    self.title = Title.find_by_name(name) if name.present?
  end

  def title_name
    title.try(:name)
  end

  def title_name=(name)
    self.title = Title.find_or_create_by_name(name) if name.present?
  end

  def title_genre_name
    title.genre.try(:name)
  end

  def title_genre_name=(name)
    self.title.genre = Genre.find_or_create_by_name(name) if name.present?
  end
end
