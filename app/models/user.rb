class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association
  has_many :lab_users, dependent: :delete_all
  has_many :labs, through: :lab_users
  has_many :products, dependent: :destroy
  has_many :news, dependent: :destroy
  belongs_to :prefecture, optional: true
  belongs_to :major, optional: true
  belongs_to :industry, optional: true
  belongs_to :occupation, optional: true

  # for ActiveStorage
  has_one_attached :image

  # set status of User
  enum type: {Student: 0, Professor: 1, Company: 2}
  validates :type, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 256}

  # set status of job_hunting
  enum job_hunting_status: {on: 0, off: 1}

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