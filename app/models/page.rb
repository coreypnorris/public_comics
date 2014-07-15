class Page < ActiveRecord::Base
  validates :image, :presence => true
  validates :number, :presence => true

  belongs_to :issue


  def next
    issue.pages.where("id > ?", id).order("id ASC").first
  end

  def prev
    issue.pages.where("id < ?", id).order("id DESC").first
  end

  def to_param
    number.to_s
  end
end
