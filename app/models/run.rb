class Run < ApplicationRecord
  validates :title, presence: true
  validates :duration, presence: true
  validates :distance, presence: true
end
