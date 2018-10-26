class Album < ApplicationRecord
	has_many_attached :images

  # アルバムの最古年度から最新年度の範囲演算子を取得
  def self.get_album_period
    self.get_first_year..self.get_last_year
  end
  # 指定年のアルバムを取得
  def self.get_album_during_year(start_year)
    self.where(created_at: Time.new(start_year)..Time.new(start_year.to_i+1))
  end

  private
    def self.get_last_year
      order(:created_at).last.created_at.strftime('%Y')
    end

    def self.get_first_year
      order(:created_at).first.created_at.strftime('%Y')
    end
end
