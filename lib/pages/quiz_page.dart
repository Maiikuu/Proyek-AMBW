import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/data/data_quiz.dart';
import 'package:project/model/quiz_answer_model.dart';
import 'package:project/model/quiz_questions.dart';
import 'package:project/pages/quiz_result.dart';

class QuizPage extends StatefulWidget {
  final String namaQuiz;
  final List<QuizQuestion> questions;

  const QuizPage({super.key, required this.questions, required this.namaQuiz});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  //quiz control
  var totalScore = 0;
  var questionIndex = 0;
  var score = 10;
  final List<QuizAnswerModel> answers = [];
  final List<int> randomizeOptions = [0, 1, 2];
  int questionNumber = 1;
  bool answered = false;
  bool canGoNext = false;
  bool correct = false;
  //pakai questionOrder untuk urutan pertanyaan
  late final List<int> questionOrder;


  IconData icon = Icons.abc;
  Color button1Color = Color.fromARGB(255, 25, 185, 221);
  Color button2Color = Color.fromARGB(255, 25, 185, 221);
  Color button3Color = Color.fromARGB(255, 25, 185, 221);

  /**
   * returns the order of the questions in the quiz randomized
   */
  List<int> randomizeQuestions() {
    List<int> questionNumbers = [];
    for (int i = 0; i < widget.questions.length; i++) {
      questionNumbers.add(i);
    }
    questionNumbers.shuffle();
    return questionNumbers;
  }

  @override
  void initState() {
    super.initState();
    questionOrder = randomizeQuestions();
    randomizeOptions.shuffle();
  }



  @override
  Widget build(BuildContext context) {

    final currentQuestion = widget.questions[questionOrder[questionIndex]];
    return Stack(
      children: [
        background(),
        scaffold(currentQuestion, context),
      ],
    );
  }



  Scaffold scaffold(QuizQuestion currentQuestion, BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: screenWidth * 0.08,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Center(
            child: Container(
              height: screenHeight * 0.7,
              width: screenWidth * 0.95,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column( //buttons
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.03),
                        Text("Quiz " + questionNumber.toString(), style: TextStyle(fontSize: screenHeight * 0.05, color: Colors.orange, fontWeight: FontWeight.bold)),
                        Text("+" + score.toString() + " poin", style: TextStyle(fontSize: screenHeight * 0.03, color: Colors.orange, fontWeight: FontWeight.bold)),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(currentQuestion.question, style: const TextStyle(fontSize: 18, color: Colors.black), textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  //tombol jawaban

                  SizedBox(height: screenHeight * 0.03),

                  questionButton(currentQuestion, 0, button1Color, screenWidth, screenHeight, context),

                  SizedBox(height: screenHeight * 0.05),

                  questionButton(currentQuestion, 1, button2Color, screenWidth, screenHeight, context),

                  SizedBox(height: screenHeight * 0.05),

                  questionButton(currentQuestion, 2, button3Color, screenWidth, screenHeight, context),


                ],
              ),
            ),
          ),

          //tombol Reset
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: (answered && !canGoNext && !correct),
                  child: ElevatedButton(
                      style: FilledButton.styleFrom(fixedSize: Size(screenWidth * 0.44, screenHeight * 0.065), backgroundColor: Colors.deepOrange),
                      onPressed: () {
                        resetButtons();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.loop, color: Colors.black, size: screenWidth * 0.07),
                          Text("Coba lagi", style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.055),),
                        ],
                      )
                  )
              )
            ],
          ),

          SizedBox(height: screenHeight * 0.035),

          //tombol home dan next
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //tombol home
              Align(
                  alignment: Alignment.centerLeft,
                  child:Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.035),
                    child: ElevatedButton(
                        style: FilledButton.styleFrom(fixedSize: Size(screenWidth * 0.36, screenHeight * 0.065), backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.home, color: Colors.black, size: screenWidth * 0.07),
                            Text("Home", style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.055),),
                          ],
                        )
                    ),
                  )
              ),

              //tombol next
              Visibility(
                  visible: canGoNext,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.035),
                      child: ElevatedButton(
                          style: FilledButton.styleFrom(fixedSize: Size(screenWidth * 0.35, screenHeight * 0.065), backgroundColor: Colors.yellow),
                          onPressed: () {
                            setState(() {
                              nextQuestion();
                              resetButtons();
                            });
                          },
                          child: Row(
                            children: [
                              Text("Quiz" + (questionNumber + 1).toString(), style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.07),),
                              Icon(Icons.keyboard_arrow_right, color: Colors.black, size: screenWidth * 0.055),
                            ],
                          )
                      ),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
  /**
   * Option button
   * current question = data pertanyaan
   * option = index dari option
   */
  ElevatedButton questionButton(QuizQuestion currentQuestion, int option, Color color, var screenWidth, var screenHeight, BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            fixedSize: Size(screenWidth * 0.75, screenHeight * 0.08),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          setState(() {
            if (!answered) {
              if (currentQuestion.options[randomizeOptions[option]] == currentQuestion.correctAnswer) {
                totalScore += score;
                switch (option) {
                  case 0:
                    button1Color = Colors.green;
                    button2Color = Colors.grey;
                    button3Color = Colors.grey;
                    break;
                  case 1:
                    button2Color = Colors.green;
                    button1Color = Colors.grey;
                    button3Color = Colors.grey;
                    break;
                  case 2:
                    button3Color = Colors.green;
                    button1Color = Colors.grey;
                    button2Color = Colors.grey;
                    break;
                }
                correct = true;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar (
                      backgroundColor: Colors.green,
                      duration:Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.88),
                      content: Row(
                        children: [
                          Icon(Icons.check, color: Colors.white, size: screenWidth * 0.07),
                          Text("Jawaban Benar"),
                        ],
                      ),
                    )
                );
                if (questionNumber != widget.questions.length) {
                  canGoNext = true;
                }

                Future.delayed(Duration(seconds: 1), () {
                  if (questionNumber == widget.questions.length) {
                    // Navigator.pushNamed(context, "/home");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizResultPage(score: totalScore, namaQuiz: widget.namaQuiz,),
                      ),
                    );
                  }
                });
              } else {
                switch (option) {
                  case 0:
                    button1Color = Colors.red;
                    button2Color = Colors.grey;
                    button3Color = Colors.grey;
                    break;
                  case 1:
                    button2Color = Colors.red;
                    button1Color = Colors.grey;
                    button3Color = Colors.grey;
                    break;
                  case 2:
                    button3Color = Colors.red;
                    button1Color = Colors.grey;
                    button2Color = Colors.grey;
                    break;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar (
                      backgroundColor: Colors.red,
                      duration:Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.88),
                      content: Row(
                        children: [
                          Icon(Icons.close, color: Colors.white, size: screenWidth * 0.07),
                          Text("Jawaban Salah"),
                        ],
                      ),
                    )
                );
              }
              answered = true;
            }
          });
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text((
              option == 0 ? "A. " : option == 1 ? "B. " : "C. ") + currentQuestion.options[randomizeOptions[option]],
            style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        )
    );
  }

  /**
   * background image
   */
  Positioned background() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_backgroundQuiz),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void nextQuestion () {
    questionIndex++;
    questionNumber++;
  }

  void resetButtons() {
    setState(() {
      button1Color = Color.fromARGB(255, 25, 185, 221);
      button2Color = Color.fromARGB(255, 25, 185, 221);
      button3Color = Color.fromARGB(255, 25, 185, 221);
      if (!canGoNext) {
        if (score > 0) {
          score -= 2;
        } else {
          score = 0;
        }
      } else {
        score = 10;
      }
      answered = false;
      canGoNext = false;
      correct = false;
      randomizeOptions.shuffle();
    });
  }
}