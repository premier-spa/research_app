class LabUser < ApplicationRecord
  belongs_to :user
  belongs_to :lab
  belongs_to :student, foreign_key: 'user_id', optional: true
  belongs_to :professor, foreign_key: 'user_id', optional: true
end