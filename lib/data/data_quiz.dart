import 'package:project/model/quiz_questions.dart';

//FORMAT [nama detail item, list QuizQuestion]
const List<List<dynamic>> LIST_QUIZ = [
  ["Budak", quiz1,],
  ["Maria", quiz2]
];

//FORMAT QuizQuestion (pertanyaan, [pilihan1, pilihan2, pilihan3], jawabanBenar)
const List<QuizQuestion> quiz1 = [
  QuizQuestion("Seseorang yang dijadikan hamba oleh orang lan. Mereka biasanya tidak memiliki kebebeasan dan dipaksa bekerja tanpa upah disebut dengan ........", ["RAJA MESIR", "BUDAK", "DAUN"], "BUDAK"),
];

const List<QuizQuestion> quiz2 = [
  QuizQuestion("Tumbuhan besar yang memiliki batang keras, akar kuat, cabang, dan daun, serta bisa tumbuh tinggi dan hidup lama disebut dengan ..........", ["TUMBUHAN", "POHON", "DAUN"], "POHON"),
  QuizQuestion("Hewan laut terbesar yang bernapas dengan paru-paru, hidup di lautan, dan termasuk dalam kelompok mamalia seperti lumba-lumba disebut dengan ..........", ["LUMBA-LUMBA", "PAUS", "CACING"], "PAUS")
];