import 'package:quiz/model/question.dart';

class Quiz {
  List<Question> questionsPartA = [
    Question(question: 'What course is this?', correctAnswer: 0, answers: [
      'UCCD3223 Mobile Applications Development',
      'UCCD3223 Mobile Application Implementation',
      'UCCD2332 Mobile Applications Development',
      'UCCD1234 Facebook Application Development'
    ]),
    Question(question: 'What faculty is this?', correctAnswer: 1, answers: [
      'Faculty of Arts and Social Science',
      'Faculty of Information and Communications Technology',
      'Faculty of Science',
      'Faculty of Computer Science'
    ]),
    Question(
        question: 'Who is the lecturer of this course?',
        correctAnswer: 3,
        answers: [
          'JJ Lin',
          'Ts Saw Seow Hui',
          'Prof Ewe Hong Tat',
          'Mr Tou Jing Yi'
        ]),
    Question(
        question: 'What platform do we teach in the practicals?',
        correctAnswer: 0,
        answers: ['Android', 'iOS', 'Ubuntu', 'Windows Mobile']),
    Question(
        question: 'What do we learn in this course?',
        correctAnswer: 2,
        answers: [
          'How to play mobile games',
          'How to take a nice picture',
          'How to develop mobile applications',
          'How to send a photo using Whatsapp'
        ]),
  ];

  List<Question> questionsPartB = [
    Question(
        question: 'Which of the following best describes High Level UI?',
        correctAnswer: 1,
        answers: [
          'UI elements that appears on the upper half of the screen',
          'Usage of predefined UI elements for UI design',
          'Design of UI that is usable in high rise buildings',
          'UI design that is more beautiful than lower level ones',
        ]),
    Question(
        question: 'Which of the following is the best colour combination?',
        correctAnswer: 0,
        answers: [
          'Dark blue words on light beige background',
          'Dark grey words on back background',
          'Yellow words on white background',
          'Orange words on red background',
        ]),
    Question(
        question:
            'Which of the following is NOT one of the five pillars of interactivity?',
        correctAnswer: 3,
        answers: [
          'Affordance and Signifiers',
          'Feedback and Response Time',
          'Goal-driven Design',
          'Speed of Touch',
        ]),
    Question(
        question: 'When do you need to use Low Level UI?',
        correctAnswer: 0,
        answers: [
          'When you needed a highly customized UI component',
          'When the application needs to be useful in underground basements',
          'When you need UI elements in the lower half of the screen',
          'When the UI needs to be used when you lie flat on the bed',
        ]),
    Question(
        question:
            'Which of the following is NOT done using tween animation in Android?',
        correctAnswer: 2,
        answers: [
          'Rotate',
          'Enlarge',
          'Warp',
          'Shrink',
        ]),
  ];
}
