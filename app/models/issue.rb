class Issue < ActiveRecord::Base
  acts_as_commentable

  validates :number, :presence => true

  has_many :pages
  has_many :comments, :as => :commentable
  belongs_to :title
  belongs_to :user

  has_attached_file :cover

  validates_attachment_presence :cover
  validates_attachment_size :cover, :less_than => 5.megabytes
  validates_attachment_content_type :cover, :content_type => ['image/jpeg', 'image/png']

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
