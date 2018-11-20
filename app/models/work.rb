class Work < ApplicationRecord
    belongs_to :lab
    has_one_attached :image
end
