class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true
  has_many :comments

  acts_as_voter

  # This method associates the attribute ":avatar" with a file attachment
    has_attached_file :avatar,
      styles: { comment: '85x85>', square: '200x200#' },
      :default_url => "/assets/:style/missing.png"

    # Validate the attached image is image/jpg, image/png, etc
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

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
end
