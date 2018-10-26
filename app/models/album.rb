class Album < ApplicationRecord
	has_many_attached :images

  def self.get_last_year
    order(:created_at).last.created_at.strftime('%Y')
  end

  def self.get_first_year
    order(:created_at).first.created_at.strftime('%Y')
  end

  def get_album_period(period)
  end
end
