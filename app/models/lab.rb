class Lab < ApplicationRecord
    has_many :news, dependent: :destroy
    has_one_attached :image
end
