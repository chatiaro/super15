class DemoQuiz {
  DemoQuiz(
      {required this.correctAns,
      required this.options,
      required this.question});
  int correctAns;

  List<String> options;
  String question;
}
