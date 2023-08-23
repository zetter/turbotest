class Actor < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
end
