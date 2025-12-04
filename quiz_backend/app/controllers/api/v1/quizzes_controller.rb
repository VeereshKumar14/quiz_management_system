module Api
    module V1
        class QuizzesController < ApplicationController

            #GET /api/v1/quizzes
            # desc: It will return all quizzes
            def index
                quizzes = Quiz.all
                render json: quizzes.as_json(only: [:id, :title, :description])
            end

            #GET /api/v1/quizzes/:id
            # desc: It will return quiz with questions

            def show
                quiz = Quiz.find(params[:id])

                render json: {
                    id: quiz.id,
                    title: quiz.title,
                    description: quiz.description,
                    questions: quiz.questions.map do |question|
                        {
                            id: question.id,
                            prompt: question.prompt,
                            kind: question.kind,
                            options: question.options
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
            end
        end
    end
end