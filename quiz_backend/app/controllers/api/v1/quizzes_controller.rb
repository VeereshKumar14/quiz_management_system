module Api
    module V1
        class QuizzesController < ApplicationController
              skip_before_action :verify_authenticity_token

            #GET /api/v1/quizzes
            # desc: It will return all quizzes
            def index
                quizzes = Quiz.all
                render json: quizzes.as_json(only: [:id, :title, :description])
            end

            #GET /api/v1/quizzes/:id
            # desc: It will return quiz with questions

            def show
                quiz = Quiz.includes(:questions).find(params[:id])

                render json: {
                    id: quiz.id,
                    title: quiz.title,
                    description: quiz.description,
                    questions: quiz.questions.map do |q|
                        {
                        id: q.id,
                        prompt: q.prompt,
                        kind: q.kind.to_s.downcase,
                        options: begin
                                q.options.is_a?(String) ? JSON.parse(q.options) : q.options
                            rescue
                                []
                            end
                        }
                    end
                }
            end


            # POST /api/v1/quizzes/:id/submit

            def submit
                quiz = Quiz.find(params[:id])
                answers = params.require(:answers)

                result = QuizResultService.new(quiz, answers).call

                render json: result
                rescue ActiveRecord::RecordNotFound
                    render json: { error: "Quiz not found" }, status: :not_found
                rescue ActionController::ParameterMissing => e
                    render json: { error: e.message }, status: :unprocessable_entity
            end
        end
    end
end