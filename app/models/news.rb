class News < ApplicationRecord
    belongs_to :lab
    belongs_to :category
    has_one_attached :image
end
