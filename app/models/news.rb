class News < ApplicationRecord
    belongs_to :lab
    belongs_to :category
end
