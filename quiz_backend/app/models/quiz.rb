class Quiz < ApplicationRecord
  has_many :questions
  has_many :results

  validates :title, presence: true

  accepts_nested_attributes_for :questions, allow_destroy: true

  def self.ransackable_associations(auth_object = nil)
    ["questions", "results"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "title", "updated_at"]
  end
end
