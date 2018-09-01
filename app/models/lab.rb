class Lab < ApplicationRecord
    has_many :news, dependent: :destroy
end
