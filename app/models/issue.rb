class Issue < ActiveRecord::Base
  acts_as_commentable

  validates :number, :presence => true

  has_many :pages
  has_many :comments, :as => :commentable
  belongs_to :title

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :cover

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

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
end
