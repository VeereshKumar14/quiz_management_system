class Result < ApplicationRecord
  belongs_to :quiz

  validates :answers, presence: true

   def self.ransackable_attributes(auth_object = nil)
    ["answers", "created_at", "id", "quiz_id", "score", "updated_at"]
  end
end
