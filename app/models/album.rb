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
      order(:created_at).last.created_at.strftime('%Y')
    end

    def self.get_first_year
      order(:created_at).first.created_at.strftime('%Y')
    end
end
