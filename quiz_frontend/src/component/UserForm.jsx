import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

const UserForm = ({ setUserName }) => {
  const [name, setName] = useState("");
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!name.trim()) {
      alert("Please enter your name");
      return;
    }
    setUserName(name);
    navigate("/quizzes");
  };

  return (
    <div>
      <h2>Enter Your Name</h2>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Your name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
        <button type="submit">Continue</button>
      </form>
    </div>
  );
};

export default UserForm;
