import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:io';

import 'package:quiz/model/student.dart';
import 'package:quiz/resource/student.dart';
import 'package:quiz/ui/quizPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final textIDController = TextEditingController();

  StudentList student = StudentList();
  int studentInd = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              height: 100,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Enter your ID to start the quiz",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 120.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Student ID",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        autovalidate: false,
                        controller: textIDController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          icon: Icon(Icons.credit_card, color: Colors.grey),
                          hintText: "Student ID",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 16.0),
                        validator: (value) {
                          // if user input is empty
                          if (value.isEmpty) {
                            return 'Please enter your id';
                            // if user input is numeric and 5 digit
                          } else if (!RegExp(r'^\d{5}$')
                              .hasMatch(value.trim())) {
                            return 'Invalid ID';
                            // if user input student id is match list of student
                          } else {
                            bool found = false;
                            student.student.asMap().forEach((index, name) {
                              if (name.id == value.trim()) {
                                found = true;
                                studentInd = index;
                              }
                            });

                            if (found)
                              return null;
                            else
                              return 'ID Not Found';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ButtonTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minWidth: 130.0,
                              height: 40.0,
                              child: RaisedButton(
                                color: Colors.blueGrey[400],
                                textColor: Colors.white,
                                child: Text("Exit"),
                                onPressed: () => exit(0),
                              )),
                          ButtonTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minWidth: 130.0,
                              height: 40.0,
                              child: RaisedButton(
                                textColor: Colors.white,
                                child: Text("Start Quiz"),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => QuizPage(
                                                student: Student(
                                                    id: textIDController.text
                                                        .trim(),
                                                    name: student
                                                        .student[studentInd]
                                                        .name
                                                        .trim()))));
                                  }
                                },
                              ))
                        ])
                  ])),
        ],
      ),
    );
  }
}
