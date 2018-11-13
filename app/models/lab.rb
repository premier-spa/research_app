class Lab < ApplicationRecord
    has_many :news, dependent: :destroy
    has_many :works, dependent: :destroy
    has_one_attached :image
    has_many :lab_users, dependent: :delete_all
    has_many :users, through: :lab_users
    has_many :students, through: :lab_users
    has_many :professors, through: :lab_users
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
        return self.users.include? user
    end

    # works の name をカンマ区切りで返す
    def work_names
        names = self.works.map {|work| work.name }
        names.join(',')
    end
end
