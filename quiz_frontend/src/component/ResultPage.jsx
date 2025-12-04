import React from "react";
import { useLocation, useNavigate } from "react-router-dom";

const ResultPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const result = location.state?.result;

  if (!result) {
    return (
      <div>
        <p>No result found. Go back to quizzes.</p>
        <button onClick={() => navigate("/quizzes")}>Back</button>
      </div>
    );
  }

  return (
    <div>
      <h2>Quiz Result</h2>
      <p>
        <strong>{result.score.toFixed(2)}%</strong>
      </p>

      <ul>
        {result.questions.map((q) => (
          <li key={q.question_id}>
            <p><strong>{q.prompt}</strong></p>
            <p>
              Your answer:{" "}
              {Array.isArray(q.submitted_answer)
                ? q.submitted_answer.join(", ")
                : q.submitted_answer || "No answer"}
            </p>
            <p>
              Correct answer:{" "}
              {Array.isArray(q.correct_answer)
                ? q.correct_answer.join(", ")
                : q.correct_answer || "N/A"}
            </p>
            {q.correct === true && <p style={{ color: "green" }}>✔ Correct</p>}
            {q.correct === false && <p style={{ color: "red" }}>✖ Incorrect</p>}
            {q.correct === null && <p style={{ color: "gray" }}>Not graded</p>}
          </li>
        ))}
      </ul>

      <button onClick={() => navigate("/quizzes")}>Back to Quizzes</button>
    </div>
  );
};

export default ResultPage;
