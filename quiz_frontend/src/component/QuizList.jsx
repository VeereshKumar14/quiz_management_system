import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

const QuizList = ({ userName }) => {
  const [quizzes, setQuizzes] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    if (!userName) navigate("/");
    axios.get("http://localhost:3000//api/v1/quizzes/")
      .then((res) => setQuizzes(res.data))
      .catch((err) => console.error(err));
  }, [userName, navigate]);

  return (
    <div>
      <h2>Welcome, {userName}</h2>
      <h3>Select a Quiz</h3>
      <ul>
        {quizzes.map((quiz) => (
          <li key={quiz.id}>
            <button onClick={() => navigate(`/quizzes/${quiz.id}`)}>
              {quiz.title}
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default QuizList;
