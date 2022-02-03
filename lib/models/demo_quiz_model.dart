class DemoQuiz {
  DemoQuiz(
      {required this.correctAns,
      required this.date,
      required this.options,
      required this.question});
  int correctAns;
  String date;
  List<String> options;
  String question;
}
