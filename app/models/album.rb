class Album < ApplicationRecord
	has_many_attached :images

  def get_last_year
    self.order(:updated_at).last
  end
  def get_album_period(period)
  end
end
