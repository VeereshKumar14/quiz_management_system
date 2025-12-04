import React, { useState } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import QuizList from "./component/QuizList";
import QuizPlayer from "./component/QuizPlayer";
import ResultPage from "./component/ResultPage";
import UserForm from "./component/UserForm";

function App() {
  const [userName, setUserName] = useState("");

  return (
    <Router>
      <Routes>
        <Route
          path="/"
          element={<UserForm setUserName={setUserName} />}
        />
        <Route
          path="/quizzes"
          element={<QuizList userName={userName} />}
        />
        <Route
          path="/quizzes/:id"
          element={<QuizPlayer userName={userName} />}
        />
        <Route path="/result/:id" element={<ResultPage />} />
      </Routes>
    </Router>
  );
}

export default App;
