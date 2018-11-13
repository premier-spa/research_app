class LabUser < ApplicationRecord
  belongs_to :user
  belongs_to :professor, foreign_key: 'user_id'
  belongs_to :student, foreign_key: 'user_id'
  belongs_to :lab
end