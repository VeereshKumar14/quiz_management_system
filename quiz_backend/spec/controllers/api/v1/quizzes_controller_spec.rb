require 'rails_helper'

RSpec.describe Api::V1::QuizzesController, type: :controller do
  let!(:quiz) { Quiz.create!(title: "Ruby Quiz") }
  let!(:question1) do
    quiz.questions.create!(
      kind: "mcq",
      prompt: "2 + 2?",
      options: ["3","4","5"],
      correct: ["4"],
    )
  end
  let!(:question2) do
    quiz.questions.create!(
      kind: "true_false",
      prompt: "Ruby is dynamically typed?",
      options: ["true","false"],
      correct: ["true"],
    )
  end

  describe "GET #index" do
    it "returns all published quizzes" do
      get :index
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data.first["title"]).to eq("Ruby Quiz")
    end
  end

  describe "GET #show" do
    it "returns quiz details without correct answers" do
      get :show, params: { id: quiz.id }
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data["questions"].length).to eq(2)
      expect(data["questions"].first).to have_key("options")
      expect(data["questions"].first).not_to have_key("correct")
    end
  end

  describe "POST #submit" do
    it "creates a result and calculates score" do
      post :submit, params: {
        id: quiz.id,
        taker_name: "John",
        answers: {
          question1.id.to_s => ["4"],
          question2.id.to_s => ["true"]
        }
      }
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data["score"]).to eq(100.0)
      expect(data["questions"].first["correct"]).to eq(true)
    end

    it "returns error if quiz not found" do
      post :submit, params: { id: 999, taker_name: "John", answers: {} }
      expect(response).to have_http_status(:not_found)
    end
  end
end
