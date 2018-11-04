require 'elasticsearch/model'

class Lab < ApplicationRecord
    # associations
    has_many :news, dependent: :destroy
    has_many :works, dependent: :destroy
    has_one_attached :image
    has_many :lab_users, dependent: :delete_all
    has_many :users, through: :lab_users

    # user が研究室に入っているか
    def is_lab_user?(user)
        return self.users.include? user
    end

    # works の name をカンマ区切りで返す
    def work_names
        names = self.works.map {|work| work.name }
        names.join(',')
    end

    # elasticsearch
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks # レコード更新時に自動で反映される

    # マッピング情報
    settings do
        mappings dynamic: 'false' do # 動的にマッピングを生成しない
            indexes :name, analyzer: 'kuromoji', type: 'text'
            indexes :about_us,  analyzer: 'kuromoji', type: 'text'
            indexes :purpose, analyzer: 'kuromoji', type: 'text'
            indexes :message, analyzer: 'kuromoji', type: 'text'
            indexes :facility, analyzer: 'kuromoji', type: 'text'
            indexes :works, type: 'nested', include_in_root: true do
                indexes :name, analyzer: 'kuromoji', type: 'text'
                indexes :description, analyzer: 'kuromoji', type: 'text'
            end
            indexes :image, type: 'nested', include_in_root: true
        end
    end

    # インデックスするデータを生成
    def as_indexed_json(options = {})
        as_json(
            only: [:name, :about_us, :purpose, :message, :facility],
            includes: {
                works: { only: [:name, :description] },
            })
    end
end
