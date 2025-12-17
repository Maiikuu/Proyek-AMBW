import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/data/data_quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizResultPage extends StatefulWidget {
  final int score;
  final String namaQuiz;
  const QuizResultPage({super.key, required this.score, required this.namaQuiz});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    uploadQuizResult();
  }

  Future<void> uploadQuizResult() async {
    User? user = auth.currentUser;

    String app = judul;
    String? userId = user?.uid;

    final query = await firestore
        .collection('quiz')
        .where('userId', isEqualTo: userId)
        .where('namaItem', isEqualTo: widget.namaQuiz)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final docId = query.docs.first.id;
      final highScore = query.docs.first.data()['score'] ?? 0;
      if (widget.score > highScore) {
        await firestore.collection('quiz').doc(docId).update({
          'score': widget.score,
          'app': app,
          'userId': userId,
          'namaItem': widget.namaQuiz,
        });
      }
    } else {
      await firestore.collection('quiz').add({
        'app': app,
        'userId': userId,
        'namaItem': widget.namaQuiz,
        'score': widget.score,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
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

        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(URL_backgroundQuiz),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              children: [
                SizedBox(height: screenHeight * 0.15),
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Score Akhir", style: TextStyle(
                              fontSize: screenWidth * 0.12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            )),
                            Text("+${widget.score} Poin", style: TextStyle(
                              fontSize: screenWidth * 0.12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            )),
                          ],
                        ),
                      ),
                    )
                ),

                SizedBox(height: screenHeight * 0.05),

                Align(
                    alignment: Alignment.center,
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
                )
              ]
          ),
        )
    );
  }

}