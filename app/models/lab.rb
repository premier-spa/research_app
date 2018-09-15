class Lab < ApplicationRecord
    has_many :news, dependent: :destroy
    has_one_attached :image
    has_many :lab_users, dependent: :delete_all
    has_many :users, through: :lab_users
end
