class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lab_users
  has_many :labs, through: :lab_users

  # for ActiveStorage
  has_one_attached :image

  # set status of User
  enum type: {student: 0, professor: 1, company: 2}
  validates :type, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 256}

  # user が研究室に所属しているか
  def has_labs?
    if self.labs
        return true
    end
    return false
  end

  def get_prime_lab
    # if条件にはhas_labs?が修正されたらそれを使う？
    if self.labs[0]
      return self.labs[0]
    end
  end

end