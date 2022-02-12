import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:super15/models/demo_quiz_model.dart';

class Database {
  Query<Map<String, dynamic>> questionData =
      FirebaseFirestore.instance.collection('demo_questions');
  List<DemoQuiz> getquestionData(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return DemoQuiz(
          correctAns: (doc.data()["correct_ans"]),          
          options: List.from((doc.data()["options"])),
          question: (doc.data()["question"]));
    }).toList();
  }

  Stream<List<DemoQuiz>> get questions {
    return questionData.snapshots().map(getquestionData);
  }
}
