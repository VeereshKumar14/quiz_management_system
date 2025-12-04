require 'rails_helper'

RSpec.describe QuizResultService, type: :service do
  let!(:quiz) { Quiz.create!(title: "Ruby Quiz") }
  let!(:question_mcq) do
    quiz.questions.create!(
      kind: "mcq",
      prompt: "2 + 2?",
      options: ["3","4","5"],
      correct: ["4"],
    )
  end
  let!(:question_tf) do
    quiz.questions.create!(
      kind: "true_false",
      prompt: "Ruby is dynamically typed?",
      options: ["true","false"],
      correct: ["true"],
    )
  end
  let!(:question_text) do
    quiz.questions.create!(
      kind: "text",
      prompt: "Explain polymorphism",
      options: [],
      correct: [],
    )
  end

  it "calculates score correctly" do
    answers = {
      question_mcq.id.to_s => ["4"],
      question_tf.id.to_s => ["true"],
      question_text.id.to_s => "Polymorphism allows objects to take many forms"
    }
    service = QuizResultService.new(quiz, answers)
    result = service.call
    expect(result[:score]).to eq((2.0 / 3 * 100).round(2))
    expect(result[:questions][0][:correct]).to eq(true)
    expect(result[:questions][1][:correct]).to eq(true)
    expect(result[:questions][2][:correct]).to eq(false)
  end
end
