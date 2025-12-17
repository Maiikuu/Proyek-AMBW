import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import 'package:project/pages/Cerita/detail_item/detail_item.dart';
import 'package:audioplayers/audioplayers.dart';

class Cerita extends StatefulWidget {
  final String judul_halaman;
  final String ayat;
  final String isi_ayat;
  final String url_gambar;
  final int index;

  const Cerita({
    super.key,
    required this.judul_halaman,
    required this.ayat,
    required this.isi_ayat,
    required this.url_gambar,
    required this.index,
  });

  @override
  State<Cerita> createState() => _CeritaState();
}

class _CeritaState extends State<Cerita> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<void> _playPauseAudio() async {
    String audioPath = AUDIO_CERITA[widget.index];
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
        AssetSource(audioPath.replaceFirst("assets/", "")),
      );
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 255, 180),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.07),
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
              onPressed: _playPauseAudio,
              child: Row(
                children: [
                  Icon(
                    isPlaying ? Icons.pause : Icons.volume_up,
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: 5),
                  Text(
                    isPlaying ? "Pause" : "Audio",
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
              widget.judul_halaman,
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.ayat,
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.isi_ayat,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Lihat:",
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: screenHeight * 0.058,
              child: Row(
                children: [
                  for (int i = 0; i < DETAIL_ITEM[widget.index].length; i++)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        fixedSize: Size(
                          screenWidth * 0.375,
                          screenHeight * 0.055,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailItem(
                                  judul: DETAIL_ITEM[widget.index][i][0],
                                  deskripsi: DETAIL_ITEM[widget.index][i][1],
                                  item: DETAIL_ITEM[widget.index],
                                  url_gambar: DETAIL_ITEM[widget.index][i][2],
                                  index: i,
                                  bab: widget.index,
                                ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            DETAIL_ITEM[widget.index][i][0],
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.play_circle,
                            color: Colors.white,
                            size: screenWidth * 0.06,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
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
                        fixedSize: Size(
                          screenWidth * 0.46,
                          screenHeight * 0.055,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/daftar_cerita');
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: screenWidth * 0.06,
                          ),
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
                        fixedSize: Size(
                          screenWidth * 0.37,
                          screenHeight * 0.055,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.black,
                            size: screenWidth * 0.06,
                          ),
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
        ],
      ),
    );
  }
}
