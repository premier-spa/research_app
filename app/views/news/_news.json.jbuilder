json.extract! news, :id, :title, :description, :release_date, :created_at, :updated_at
json.url news_url(news, format: :json)
