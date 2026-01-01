import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class QuizResultPage extends StatefulWidget {
  final int score;
  final String namaQuiz;
  const QuizResultPage({super.key, required this.score, required this.namaQuiz});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {

  final fb.FirebaseAuth auth = fb.FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    uploadQuizResult();
  }

  Future<void> uploadQuizResult() async {
    final fb.User? user = fb.FirebaseAuth.instance.currentUser;

    if (user == null) {
      debugPrint('Belum Login');
      return;
    }

    String app = judul;
    final String userId = user.uid;
    final supabase = Supabase.instance.client;
    final dynamic raw = await supabase
        .from('quiz')
        .select('id, score')
        .eq('userId', userId)
        .eq('namaItem', widget.namaQuiz)
        .limit(1);

    List<dynamic> rows = [];
    if (raw is List) {
      rows = raw;
    } else if (raw is Map && raw['data'] != null) {
      rows = List<dynamic>.from(raw['data'] as List);
    }

    Map<String, dynamic>? existing = rows.isNotEmpty ? Map<String, dynamic>.from(rows.first as Map) : null;

    if (existing != null) {
      final docId = existing['id'];
      final highScore = ((existing['score'] ?? 0) as num).toInt();
      if (widget.score > highScore) {
        await supabase.from('quiz').update({
          'score': widget.score,
          'app': app,
          'userId': userId,
          'namaItem': widget.namaQuiz,
        }).eq('id', docId);
      }
    } else {
      await supabase.from('quiz').insert({
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