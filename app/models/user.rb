class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lab_users
  has_many :labs, through: :lab_users

  # set status of User
  enum user_type: {student: 0, professor: 1, company: 2}
  validates :user_type, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 256}

  # user が研究室に所属しているか
  def has_labs?
    if self.labs
        return true
    end
    return false
  end

end