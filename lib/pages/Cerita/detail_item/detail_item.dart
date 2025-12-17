import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/data/data_quiz.dart';
import 'package:project/pages/quiz_page.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailItem extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final List<List<String>> item;
  final String url_gambar;
  final int index;
  final int bab;

  const DetailItem({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.item,
    required this.url_gambar,
    required this.index,
    required this.bab,
  });

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    final String audioPath = widget.item[widget.index].length > 3
        ? widget.item[widget.index][3]
        : 'audio/default.mp3'; // fallback

    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      try {
        await _audioPlayer.play(AssetSource(audioPath));
        setState(() => _isPlaying = true);
      } catch (e) {
        print("❌ Error saat memutar audio: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 255, 180),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: screenHeight * 0.48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.07),
                // Tombol Audio
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: _toggleAudio,
                    child: Row(
                      children: [
                        Icon(
                          _isPlaying ? Icons.stop : Icons.volume_up,
                          color: Colors.white,
                          size: screenWidth * 0.06,
                        ),
                        SizedBox(width: 6),
                        Text(
                          _isPlaying ? "Stop" : "Audio",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.judul,
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.deskripsi,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/cerita',
                            arguments: widget.bab,
                          );
                        },
                        icon: Icon(Icons.list, size: screenWidth * 0.06),
                      ),
                      Text(
                        "List",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.3),
                      IconButton(
                        onPressed: widget.index == 0
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailItem(
                                      judul: DETAIL_ITEM[widget.bab][widget.index - 1][0],
                                      deskripsi: DETAIL_ITEM[widget.bab][widget.index - 1][1],
                                      item: DETAIL_ITEM[widget.bab],
                                      url_gambar: DETAIL_ITEM[widget.bab][widget.index - 1][2],
                                      index: widget.index - 1,
                                      bab: widget.bab,
                                    ),
                                  ),
                                );
                              },
                        icon: Icon(Icons.arrow_back_ios_new_sharp,
                            size: screenWidth * 0.06),
                      ),
                      Text(
                        "${widget.index + 1} of ${widget.item.length}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.index == widget.item.length - 1
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailItem(
                                      judul: DETAIL_ITEM[widget.bab][widget.index + 1][0],
                                      deskripsi: DETAIL_ITEM[widget.bab][widget.index + 1][1],
                                      item: DETAIL_ITEM[widget.bab],
                                      url_gambar: DETAIL_ITEM[widget.bab][widget.index + 1][2],
                                      index: widget.index + 1,
                                      bab: widget.bab,
                                    ),
                                  ),
                                );
                              },
                        icon: Icon(Icons.arrow_forward_ios_sharp,
                            size: screenWidth * 0.06),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize: Size(screenWidth * 0.25, screenHeight * 0.055),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      int quizIndex = LIST_QUIZ.indexWhere(
                        (quiz) => quiz[0] == widget.judul,
                      );
                      if (quizIndex != -1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(questions: LIST_QUIZ[quizIndex][1], namaQuiz: LIST_QUIZ[quizIndex][0],),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Quiz",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight * 0.4675,
              width: screenWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.url_gambar),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(220, 255, 255, 255),
                          fixedSize: Size(screenWidth * 0.46, screenHeight * 0.055),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/daftar_cerita');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back,
                                color: Colors.black,
                                size: screenWidth * 0.06),
                            SizedBox(width: 5),
                            Text(
                              "Daftar Cerita",
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(220, 255, 255, 255),
                          fixedSize: Size(screenWidth * 0.37, screenHeight * 0.055),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.home,
                                color: Colors.black,
                                size: screenWidth * 0.06),
                            SizedBox(width: 8),
                            Text(
                              "Home",
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
