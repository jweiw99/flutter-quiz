import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:quiz/model/question.dart';
import 'package:quiz/model/student.dart';
import 'package:quiz/resource/quiz.dart';
import 'package:quiz/ui/quizResults.dart';

class QuizPage extends StatefulWidget {
  final Student student;
  const QuizPage({Key key, @required this.student}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Question Text Theme
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);
  final TextStyle _answerStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey[700]);

  Quiz quiz = Quiz();

  // Quiz Part A = 0, Part B = 1
  int quizQuestionPart = 0;
  int _currentPartIndex = 0;

  // correct count of quiz part A and B
  List<int> correct = [0, 0];

  // Student answered question and list of question answer
  List<Question> answeredQuestion = [];
  final Map<int, dynamic> _answers = {};

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //if question is part A, will retrieve part A question, otherwise Part B
    Question question = quizQuestionPart == 0
        ? quiz.questionsPartA[_currentPartIndex]
        : quiz.questionsPartB[_currentPartIndex];
    // Total of quiz question length
    int quizQuestionTotalLen = quizQuestionPart == 0
        ? quiz.questionsPartA.length - 1
        : quiz.questionsPartB.length - 1;
    // Used to add total question answer after Part A, Part B + Part A
    int quizQuestionCurrentLen =
        quizQuestionPart == 0 ? 0 : quiz.questionsPartA.length;
    int _currentIndex = _currentPartIndex + quizQuestionCurrentLen;
    final List<dynamic> options = question.answers;
    // Used to check correct answer
    if (answeredQuestion.length == _currentIndex) {
      answeredQuestion.insert(_currentIndex, question);
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
        appBar: AppBar(
          // Display title
          centerTitle: true,
          title: Text("Quiz " + (quizQuestionPart == 0 ? "Part A" : "Part B")),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Display question number
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${_currentPartIndex + 1}"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        // Display question
                        child: Text(question.question,
                            softWrap: true, style: _questionStyle),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Display question answer
                        ...options.map((option) => RadioListTile(
                              title: Text("$option",
                                  softWrap: true, style: _answerStyle),
                              groupValue: _answers[_currentIndex],
                              value: options.indexOf(option),
                              onChanged: (value) {
                                setState(() {
                                  _answers[_currentIndex] = value;
                                });
                              },
                            )),
                      ],
                    ),
                  )),
                  SizedBox(height: 50),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // display prev, next or submit button
                        _currentPartIndex == 0
                            ? SizedBox()
                            : ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                minWidth: 130.0,
                                height: 40.0,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  child: Text("Previous"),
                                  onPressed: _prevSubmit,
                                )),
                        ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minWidth: 130.0,
                            height: 40.0,
                            child: RaisedButton(
                              textColor: Colors.white,
                              child: Text(
                                  _currentPartIndex == quizQuestionTotalLen
                                      ? "Submit"
                                      : "Next"),
                              onPressed: _currentPartIndex ==
                                      quizQuestionTotalLen
                                  ? () {
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            content: Text("Confirm to Submit?"),
                                            title: Text("Warning!"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                  _nextSubmit();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("No"),
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                              ),
                                            ],
                                          ));
                                    }
                                  : _nextSubmit,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // function of submit button pressed
  void _nextSubmit() {
    int _currentIndex = _currentPartIndex +
        (quizQuestionPart == 0 ? 0 : quiz.questionsPartA.length);

    // if student dint not answering the question
    if (_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }

    // if student answer question correctly, correct + 1
    if (answeredQuestion[_currentIndex].correctAnswer ==
        _answers[_currentIndex]) {
      correct[quizQuestionPart]++;
    }

    // condition of quiz part a score less than 3, navigate to result page
    if ((_currentPartIndex == (quiz.questionsPartA.length - 1) &&
            correct[0] < 3) ||
        _currentIndex ==
            (quiz.questionsPartA.length + quiz.questionsPartB.length) - 1) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QuizFinishedPage(
              correct: correct,
              student: widget.student,
              questions: answeredQuestion)));
    } else {
      setState(() {
        // proceed to quiz part B
        if (_currentPartIndex == quiz.questionsPartA.length - 1) {
          _currentPartIndex = 0;
          quizQuestionPart = 1;
        // proceed to next question
        } else {
          _currentPartIndex++;
        }
      });
    }
  }

  // When student press previous button, back to previous question
  void _prevSubmit() {
    setState(() {
      correct[quizQuestionPart]--;
      _currentPartIndex--;
    });
  }

  // When student press onbackbutton
  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}
