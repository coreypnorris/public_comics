class Title < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :issues
  has_and_belongs_to_many :genres, join_table: :genres_titles

  def self.search(search)
    if search
      Title.where('name LIKE ?', "%#{search}%")
    else
      Title.all
    end
  end

  def self.approved_titles
    approved_titles = []

    Title.all.each do |title|
      title.issues.each do |issue|
        if issue.approved == 1
          approved_titles << issue.title
        end
      end
    end
    approved_titles = approved_titles.uniq
    return approved_titles
  end

end
