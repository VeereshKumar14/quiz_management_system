class QuizResultService
  DEFAULT_SCORE = 0

  def initialize(quiz, answers)
    @quiz = quiz
    @answers = answers
  end

  def call
    result = @quiz.results.create!(
      answers: @answers,
      score: DEFAULT_SCORE
    )

    total_questions = @quiz.questions.count
    correct_count = 0
    per_question_results = []

    @quiz.questions.each do |q|
      submitted_answer = extract_submitted_answer(q)
      is_correct = grade_question(q, submitted_answer)
      correct_count += 1 if is_correct

      per_question_results << {
        question_id: q.id,
        prompt: q.prompt,
        kind: q.kind,
        submitted_answer: submitted_answer,
        correct_answer: parse_correct_answer(q.correct),
        correct: is_correct
      }
    end

    score = ((correct_count.to_f / total_questions) * 100).round(2)
    result.update!(score: score)

    {
      result_id: result.id,
      score: score,
      questions: per_question_results
    }
  end

  private

  def extract_submitted_answer(question)
    @answers[question.id.to_s] || @answers[question.id]
  end

  def parse_correct_answer(correct_value)
    case correct_value
    when String
      begin
        parsed = JSON.parse(correct_value)
        parsed.is_a?(Array) ? parsed.map(&:to_s) : [parsed.to_s]
      rescue JSON::ParserError
        [correct_value.to_s]
      end
    when Array
      correct_value.map(&:to_s)
    else
      [correct_value.to_s]
    end
  end

  def grade_question(question, submitted_answer)
    correct_answers = parse_correct_answer(question.correct)

    case question.kind
    when "mcq", "true_false"
      submitted = Array(submitted_answer).map(&:to_s)
      correct_answers.sort == submitted.sort
    when "text"
      false 
    else
      false
    end
  end
end
