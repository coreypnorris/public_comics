class Title < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :issues
  belongs_to :genre

  def self.search(search)
    if search
      Title.where('name LIKE ?', "%#{search}%")
    else
      Title.all
    end
  end
end
