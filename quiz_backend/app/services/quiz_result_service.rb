class QuizResultService

    DEFAULT_SCORE =  0

    def initialize(quiz, answers)
        @quiz = quiz
        @answers = answers
    end

    def call

        result = @quiz.results.create!(
            answers: @answers,
            scrore: DEFAULT_SCORE
        )

        total_questions = @quiz.questions.count
        correct_count = 0
        per_question_results =[]

        @quiz.questions.each do |q|
            submitted_answer =  @answers[q.id.to_s] || @answers[q.id]
            is_correct = grade_question(q, submitted_answer)
            correct_count += 1 if is_correct == true

            per_question_results << {
                question_id: q.id,
                prompt: q.prompt,
                kind: q.kind,
                submitted_answer: submitted_answer,
                correct_answer: q.correct,
                correct: is_correct
            }
        end

        score = (correct_count.to_f / total_questions) * 100
        result.update!(score: score)
        {
            result_id: result.id,
            score: score,
            questions: per_question_results
        }

    end

    private 

    def grade_question(questions, submitted_answer)
        case question.kind
        when "mcq", "true_false"
            correct = Array(questions.correct).map(&:to_s).sort
            submitted = Array(submitted_answer).map(&:to_s).sort
            correct == submitted
        when "text"
            nil
        else
            nil
        end    
            


    end


end