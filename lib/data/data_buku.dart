import 'package:project/data/data_quiz.dart';
import 'package:project/model/quiz_questions.dart';

const String judul = "MUSA";
const String subJudul = "DAN UMAT TUHAN";

const String URL_SplashScreen = "assets/images/background/splash-screen-musa.png";
const String URL_backgroundLogin = "assets/images/background/background-login-daftar-musa.png";
const String URL_backgroundHome = "assets/images/background/background-home-musa.png";
const String URL_backgroundPengaturan = "assets/images/background/background-pengaturan-akun-musa.png";
const String URL_backgroundQuiz = "assets/images/background/background-quiz-musa.png";
const String URL_placeholder = "assets/images/placeholder.jpg";
const String URL_BackgroundCerita1 = "assets/images/cerita/cerita1/background-cerita-1-musa.png";
const String URL_BackgroundCerita2 = "assets/images/cerita/cerita2/background-cerita-2-musa.png";
const String URL_BackgroundDaftarCerita = "assets/images/background/background-daftar-cerita-musa.png";

const String URL_Cerita1Item1 = "assets/images/cerita/cerita1/cerita-1-malaikat-musa.png";
const String URL_Cerita2Item1 = "assets/images/cerita/cerita2/cerita-2-penasehat-musa.png";

//Format: [Judul halaman, URL gambar, index]
const List<List<String>> HALAMAN = [
  ["Perbudakan Di Mesir", URL_BackgroundCerita1],
  ["Perintah Raja", URL_BackgroundCerita2],
  ["Musa Lahir", URL_placeholder],                                    
  ["Diselamatkan Putri Raja", URL_placeholder],                       
  ["Musa Membela Budak Ibrani", URL_placeholder],                     
  ["Yitro Menyambut Musa", URL_placeholder],                          
  ["Semak yang Menyala", URL_placeholder],                            
  ["Musa Membuat Mukjizat", URL_placeholder],                         
  ["Harun dan Musa", URL_placeholder],                                
  ["Biarkanlah Umat-Ku Pergi", URL_placeholder],                      
  ["Darah dan Katak", URL_placeholder],                              
  ["Nyamuk dan Lalat", URL_placeholder],                              
  ["Penyakit dan Bisul", URL_placeholder],                            
  ["Hujan Es dan Belalang", URL_placeholder],                         // index 14
  ["Kegelapan dan Kematian", URL_placeholder],                        // index 15
  ["Tuhan Menepati Janji-Nya", URL_placeholder],                      // index 16
  ["Orang Israel Keluar dari Mesir", URL_placeholder],                // index 17
  ["Dikejar Tentara Mesir", URL_placeholder],                         // index 18
  ["Laut Merah Dibelah", URL_placeholder],                            // index 19
  ["Air bagi yang Haus", URL_placeholder],                            // index 20
  ["Makanan bagi yang Lapar", URL_placeholder],                       // index 21
  ["Umat Meragukan Tuhan", URL_placeholder],                          // index 22
  ["Di Kaki Gunung Sinai", URL_placeholder],                          // index 23
  ["Sepuluh Firman", URL_placeholder],                                // index 24
  ["Janji Tuhan bagi Israel", URL_placeholder],                       // index 25
  ["Umat Mau Menaati Tuhan", URL_placeholder],                        // index 26
  ["Lembu Emas", URL_placeholder],                                    // index 27
  ["Musa Menghancurkan Berhala", URL_placeholder],                    // index 28
  ["Tuhan Berbelas Kasih", URL_placeholder]
];

/// Format:
/// [Bab]
/// [List Item]
/// [Judul Item, Deskripsi Item, Gambar Item, Audio Item]
const List<List<List<String>>> DETAIL_ITEM = [
  [
    [
      "Budak",
      "Seseorang yang dijadikan hamba oleh orang lain. Mereka biasanya tidak memiliki kebebasan dan dipaksa bekerja tanpa upah.", 
      URL_Cerita1Item1,
      "audio/cerita1/item_malaikat.mp3"
    ]
  ],
  [
    [
      "Penasehat Raja", 
      "Penasehat raja adalah orang yang memberikan saran, masukan, atau bimbingan kepada seorang raja dalam menjalankan pemerintahan.", 
      URL_Cerita2Item1,
      "audio/cerita1/item_malaikat.mp3"
    ]
    // [
    //   "Maria", 
    //   "Seorang perawan yang mengandung Yesus melalui mukjizat Roh Kudus. Dia bertunangan dengan Yusuf, seorang tukang kayu dari Nazaret.", 
    //   URL_Cerita2Item2,
    //   "audio/cerita2/item_maria.mp3"
    // ]
  ],
  

  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
  [
  ],
];

//Format: [(Ayat), Isi Ayat]
const List<List<String>> AYAT = [
  ["(Keluaran 1:6-4)", "Lalu orang Mesir menekan orang Israel dan menjadikan mereka budak-budak. Mereka dipaksa membangun kota Pitom dan Raamses untuk raja Mesir."],
  ["(Lukas 1:26-38)", "Lalu malaikat itu  berkata kepadanya, “Jangan  takut, Maria. Allah senang  kepadamu. Engkau akan  melahirkan seorang anak laki-laki  dan kau harus menamakan-Nya  Yesus."],
  ["(Lukas 1:39-45)", "placeholder"],
  ["(Matius 1:18-24)", "placeholder"],
  ["(Lukas 2:1-7)", "placeholder"],
  ["(Lukas 2:8-20)", "placeholder"],
  ["(Matius 2:1-6)", "placeholder"],
  ["(Matius 2:7-12)", "placeholder"],
  ["(Matius 2:12-23)", "placeholder"],
  ["(Lukas 2:41-52)", "placeholder"],
  ["(Yohanes 1:19-28)", "placeholder"],
  ["(Yohanes 1:29-34)", "placeholder"],
  ["(Matius 3:1-17)", "placeholder"],
  ["(Lukas 4:1-15)", "placeholder"],
  ["(Yohanes 1:35-51)", "placeholder"],
  ["(Yohanes 1:43-51)", "placeholder"],
  ["(Lukas 5:1-11)", "placeholder"],
  ["(Yohanes 2:1-11)", "placeholder"],
  ["(Yohanes 2:13-22)", "placeholder"],
  ["(Yohanes 3:1-6; 16-21)", "placeholder"],
  ["(Yohanes 4:4-26)", "placeholder"],
  ["(Yohanes 4:27-42)", "placeholder"],
  ["(Yohanes 4:43-54)", "placeholder"],
  ["(Yohanes 5:19-30)", "placeholder"],
  ["(Yohanes 5:31-47)", "placeholder"],
  ["(Lukas 5:17-26)", "placeholder"],
  ["(Yohanes 7:32-36)", "placeholder"],
  ["(Yohanes 7:42-52)", "placeholder"],
  ["(Markus 2:13-17)", "placeholder"]
];

// Format: URL audio untuk tiap bab (disesuaikan dengan index HALAMAN)
const List<String> AUDIO_CERITA = [
  "assets/audio/cerita1/narasi_cerita1.mp3",
  "assets/audio/cerita2/narasi_cerita2.mp3",
  
  
];

