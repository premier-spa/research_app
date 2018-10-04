class LabUser < ApplicationRecord
  belongs_to :user
  belongs_to :lab
end

class LabUser < ActiveRecord::Base
  enum type: {student: 0, professor: 1, company: 2}
end