class Album < ApplicationRecord
	has_many_attached :images

  # アルバムの最古年度から最新年度の範囲演算子を取得
  def self.get_album_period
    self.get_first_year..self.get_last_year
  end

  # 指定年のアルバムを取得
  def self.get_lab_albums(lab_id, year='')
    if year.empty?
      where(lab_id: lab_id)
    else
      where(lab_id: lab_id).where(created_at: Time.new(year)..Time.new(year,12,31,23,59,59))
    end
  end

  private
    def self.get_last_year
      last_year = self.order(:created_at).last
      if last_year.nil?
        Time.now.strftime('%Y')
      else
        last_year.created_at.strftime('%Y')
      end
    end

    def self.get_first_year
      first_year = self.order(:created_at).first
      if first_year.nil?
        Time.now.strftime('%Y')
      else
        first_year.created_at.strftime('%Y')
      end
    end
end
