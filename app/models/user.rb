class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true
  has_many :comments

  acts_as_voter

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
