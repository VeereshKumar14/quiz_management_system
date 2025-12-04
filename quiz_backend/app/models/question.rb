class Question < ApplicationRecord
  belongs_to :quiz
  
  QUESTION_KINDS = %w[mcq true_false text].freeze

  validates :kind, inclusion: { in: QUESTION_KINDS }
  validates :prompt, presence: true
  validates :options, presence: true, if: -> { kind == 'mcq' }
  validates :correct, presence: true, if: -> { kind != 'text' }

   def self.ransackable_attributes(auth_object = nil)
    ["correct", "created_at", "id", "kind", "options", "prompt", "quiz_id", "updated_at"]
  end
end
