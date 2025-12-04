import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";

const QuizPlayer = ({ userName }) => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [quiz, setQuiz] = useState(null);
  const [answers, setAnswers] = useState({});
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!userName) navigate("/");
    axios.get(`http://localhost:3000/api/v1/quizzes/${id}`)
      .then((res) => setQuiz(res.data))
      .catch((err) => console.error(err))
      .finally(() => setLoading(false));
  }, [id, navigate, userName]);

  const handleChange = (questionId, value, multi = false) => {
    setAnswers((prev) => {
      if (multi) {
        const prevAnswers = prev[questionId] || [];
        const updatedAnswers = prevAnswers.includes(value)
          ? prevAnswers.filter((v) => v !== value)
          : [...prevAnswers, value];
        return { ...prev, [questionId]: updatedAnswers };
      } else {
        return { ...prev, [questionId]: value };
      }
    });
  };

  const handleSubmit = async () => {
    setSubmitting(true);
    try {
      const res = await axios.post(`http://localhost:3000/api/v1/quizzes/${id}/submit`, {
        answers,
      });
      navigate(`/result/${res.data.result_id}`, { state: { result: res.data } });
    } catch (err) {
      console.error(err);
      alert("Failed to submit quiz");
    } finally {
      setSubmitting(false);
    }
  };
console.log("Quiz Data:", quiz);
console.log("Questions:", (quiz || {}).questions);

  if (loading) return <p>Loading quiz...</p>;
  if (!quiz) return <p>Quiz not found</p>;

  return (
    <div>
      <h2>{quiz.title}</h2>
      <p>{quiz.description}</p>

      <form onSubmit={(e) => { e.preventDefault(); handleSubmit(); }}>
        {quiz.questions.map((q) => (
          <div key={q.id} style={{ marginBottom: "20px" }}>
            <p><strong>{q.prompt}</strong></p>

            {q.kind === "mcq" && q.options.map((opt) => (
              <div key={opt}>
                <label>
                  <input
                    type="checkbox"
                    checked={(answers[q.id] || []).includes(opt)}
                    onChange={() => handleChange(q.id, opt, true)}
                  />
                  {opt}
                </label>
              </div>
            ))}

            {q.kind === "true_false" && q.options.map((opt) => (
              <div key={opt}>
                <label>
                  <input
                    type="radio"
                    name={`q_${q.id}`}
                    value={opt}
                    checked={answers[q.id] === opt}
                    onChange={() => handleChange(q.id, opt)}
                  />
                  {opt}
                </label>
              </div>
            ))}

            {q.kind === "text" && (
              <textarea
                value={answers[q.id] || ""}
                onChange={(e) => handleChange(q.id, e.target.value)}
                rows={3}
                style={{ width: "100%" }}
              />
            )}
          </div>
        ))}

        <button type="submit" disabled={submitting}>
          {submitting ? "Submitting..." : "Submit Quiz"}
        </button>
      </form>
    </div>
  );
};

export default QuizPlayer;
