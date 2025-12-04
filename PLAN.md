# Quiz Management System

## Objective

Build a small production ready Quiz management system with: 

- Admin panel to create and manage the quizzes
- Public Page to take a quiz without authentication and display the results
- Tech Stack:
    - Backend: Ruby on Rails
    - Frontend: React JS
    - Database: PostgresSql
---

## Todos

- Create the Admin panel to add the quizes
- Create API all the required API for the quizes for frontend
- Create frontend pages for the quizes using React

---

## Assumptions

- Each quiz can have multiple questions of different types of MCQ, True/ False, text, etc.
    - MCQ - may have multiple correct answer
    - True/False - have single correct answer
    - Text - Free form
- User can take the quiz without authentication
- Once the User submit quiz- result should be shown as score or correct answers

---

## Apporach

### Backend

- install all the required gems
- generate rails models Quiz, Question and Result and Active Admin
- Created the DB for those models
- Implement Rails API and service class 


### Frontend

- Implement User flow
- Created Components UserForm, QuizList, QuizPlayer, ResultPage
- Adding Routing

---


## Good to have features

- Need to add Pagination for list API
- Add Rack attack middle file to prevent IP spoofing
- improve the UI/UX using Material UI or Tawilwind CSS
- Add the progress indicatiors and timers for user player page
- Add analytics 
- Need to add Rspec and unit test case
