require 'elasticsearch/model'

class Lab < ApplicationRecord
    # associations
    #has_many :news, dependent: :destroy
    has_many :works, dependent: :destroy
    has_one_attached :image
    has_many :lab_users, dependent: :delete_all
    has_many :users, through: :lab_users
    has_many :students, through: :lab_users
    has_many :professors, through: :lab_users

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
            indexes :works do
                indexes :name, type: 'text'
                indexes :description, analyzer: 'kuromoji', type: 'text'
            end
        end
    end

    # インデックスするデータを生成
    def as_indexed_json(options = {})
        as_json(
            only: [:name, :about_us, :purpose, :message, :facility],
            include: {
                works: { only: [:name, :description] },
            })
    end

    def self.search(keyword)
        search_definition = Elasticsearch::DSL::Search.search {
          query {
            if keyword.present?
              multi_match {
                query keyword
                fields %w{ name about_us purpose message facility works.name works.description }
              }
            else
              match_all
            end
          }
        }
        # 検索クエリをなげて結果を表示
        __elasticsearch__.search(search_definition)
      end

end
