import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'questionnew.dart';

Questionnew form = Questionnew();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink.shade200,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

int lengthnum = form.lengthquestion();
int correctscore = 0;
List<Icon> scorekeeper = [];
void addscore(bool score) {
  if (form.getanswer() == score) {
    scorekeeper.add(Icon(
      Icons.check,
      color: Colors.green,
    ));
    correctscore++;
  } else {
    scorekeeper.add(Icon(
      Icons.close,
      color: Colors.red,
    ));
  }

  form.nextq();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                form.questionitem(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lime.shade200),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  if (form.isFinish() == true) {
                    Alert(
                      context: context,
                      title: 'Finished!',
                      desc: 'Your score is $correctscore /$lengthnum ',
                    ).show();
                    form.resetcount();
                    scorekeeper = [];
                    correctscore = 0;
                  } else {
                    addscore(true);
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red.shade800),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                //The user picked false.

                setState(() {
                  if (form.isFinish() == true) {
                    form.resetcount();
                    scorekeeper = [];
                    Alert(
                      context: context,
                      title: 'Finished!',
                      desc: 'Your score is $correctscore /$lengthnum ',
                    ).show();
                    form.resetcount();
                    scorekeeper = [];
                    correctscore = 0;
                  } else {
                    addscore(false);
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scorekeeper,
          ),
        ),
      ],
    );
  }
}
