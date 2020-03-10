import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:quiz/model/question.dart';
import 'package:quiz/model/student.dart';
import 'package:quiz/resource/quiz.dart';

class QuizFinishedPage extends StatelessWidget {
  final List<Question> questions;
  final Student student;
  final List<int> correct;

  QuizFinishedPage(
      {Key key,
      @required this.correct,
      @required this.student,
      @required this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Result page text theme
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 17.0,
        fontWeight: FontWeight.bold);

    final Quiz quiz = Quiz();
    final int totalcorrect = correct[0] + correct[1];

    // quiz part A widget width
    final listWidth = correct[0] < 3 ? 0.95 : 0.9;

    // Message of score
    String message;
    if (totalcorrect >= 10)
      message = 'Wow! You are a god!';
    else if (totalcorrect >= 8)
      message = 'You are good!';
    else if (totalcorrect >= 6)
      message = 'Not bad';
    else if (totalcorrect >= 3)
      message = 'You can work harder';
    else
      message = 'You need to work harder';

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Result'),
          elevation: 0,
        ),
        body: Stack(children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              height: 200,
            ),
          ),
          ListView(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 16,
              bottom: 20,
            ),
            children: <Widget>[
              // Display student id and name
              Center(
                  child: Text(
                "ID: ${student.id}\nName: ${student.name}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              )),
              SizedBox(height: 20.0),
              Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    // Total mark of quiz part A + part B or Part A only if score less than 3
                    Text("Total Marks", style: titleStyle),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: 10, left: 16.0, right: 16.0),
                      title: Text("Total Questions", style: titleStyle),
                      trailing:
                          Text("${questions.length}", style: trailingStyle),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16.0, right: 16.0),
                      title: Text("Score", style: titleStyle),
                      trailing: Text(
                          "${totalcorrect / questions.length * 100}%",
                          style: trailingStyle),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16.0, right: 16.0),
                      title: Text("Correct Answers", style: titleStyle),
                      trailing: Text("$totalcorrect/${questions.length}",
                          style: trailingStyle),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 10),
                      title: Text("Comment", style: titleStyle),
                      trailing: Text(message, style: trailingStyle),
                    ),
                  ])),
              SizedBox(height: 10.0),
              Container(
                  height: 230,
                  width: double.infinity,
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        // display quiz part A result
                        Container(
                            width:
                                MediaQuery.of(context).size.width * listWidth,
                            child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(children: <Widget>[
                                  SizedBox(height: 20.0),
                                  Text("Quiz Part A", style: titleStyle),
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        top: 10, left: 16.0, right: 16.0),
                                    title: Text("Total Questions",
                                        style: titleStyle),
                                    trailing: Text(
                                        "${quiz.questionsPartA.length}",
                                        style: trailingStyle),
                                  ),
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    title: Text("Score", style: titleStyle),
                                    trailing: Text(
                                        "${correct[0] / quiz.questionsPartA.length * 100}%",
                                        style: trailingStyle),
                                  ),
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    title: Text("Correct Answers",
                                        style: titleStyle),
                                    trailing: Text(
                                        "${correct[0]}/${quiz.questionsPartA.length}",
                                        style: trailingStyle),
                                  ),
                                ]))),
                        // Display quiz part B result, only show if correct answer of part A more than 2
                        correct[0] < 3
                            ? SizedBox()
                            : Container(
                                width: MediaQuery.of(context).size.width *
                                    listWidth,
                                child: Card(
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Column(children: <Widget>[
                                      SizedBox(height: 20.0),
                                      Text("Quiz Part B", style: titleStyle),
                                      ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            top: 10, left: 16.0, right: 16.0),
                                        title: Text("Total Questions",
                                            style: titleStyle),
                                        trailing: Text(
                                            "${quiz.questionsPartB.length}",
                                            style: trailingStyle),
                                      ),
                                      ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        title: Text("Score", style: titleStyle),
                                        trailing: Text(
                                            "${correct[1] / quiz.questionsPartB.length * 100}%",
                                            style: trailingStyle),
                                      ),
                                      ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        title: Text("Correct Answers",
                                            style: titleStyle),
                                        trailing: Text(
                                            "${correct[1]}/${quiz.questionsPartB.length}",
                                            style: trailingStyle),
                                      ),
                                    ]))),
                      ])),
              SizedBox(height: 10.0),
              // Back to home page button
              RaisedButton(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blue,
                child: Text("Goto Home"),
                onPressed: () =>
                    Navigator.popUntil(context, ModalRoute.withName('/')),
              ),
            ],
          ),
        ]));
  }
}
