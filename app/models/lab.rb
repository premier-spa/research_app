class Lab < ApplicationRecord
    has_many :news, dependent: :destroy
    has_one_attached :image
    has_many :lab_users, dependent: :delete_all
    has_many :users, through: :lab_users

    # user が研究室に入っているか
    def is_lab_user?(user)
        if self.users.include? user
            true
        else
            false
        end
    end
end
