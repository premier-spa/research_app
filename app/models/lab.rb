class Lab < ApplicationRecord
    has_many :news, dependent: :destroy
    has_many :works, dependent: :destroy
    has_one_attached :image
    has_many :lab_users, dependent: :delete_all
    has_many :users, through: :lab_users

    # 検索ページ用のクラスメソッド
    def self.search(search)
        if search
          where(['name LIKE ?', "%#{search}%"])
        else
          all
        end
    end

    # user が研究室に入っているか
    def is_lab_user?(user)
        if self.users.include? user
            true
        else
            false
        end
    end

    # labがidを持っているかどうか
    def present_lab?
        if self.nil?
            return false
        else
            return true
        end
    end

    # labがidを持っているかどうか
    def has_lab_id?
        if self.id.nil?
            return false
        else
            return true
        end
    end

    # works の name をカンマ区切りで返す
    def work_names
        names = self.works.map {|work| work.name }
        names.join(',')
    end
end
