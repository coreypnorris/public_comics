class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true
  validates :username, :uniqueness => true
  has_many :comments, dependent: :destroy
  has_many :issues, dependent: :destroy

  acts_as_voter

  has_attached_file :avatar,
    styles: { comment: '85x85>', profile: '150x150#' },
    :default_url => "/assets/:style/missing.png"

  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  def to_param
    username
  end

  def up_vote_class(comment)
    if voted_up_on? comment
      return 'btn-success'
    else
      return 'btn-default'
    end
  end

  def down_vote_class(comment)
    if voted_down_on? comment
      return 'btn-danger'
    else
      return 'btn-default'
    end
  end

  def score
    points = 0
    comments.each do |comment|
      points += comment.get_upvotes.size
    end
    return points
  end
end
