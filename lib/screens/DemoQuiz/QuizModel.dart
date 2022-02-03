import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/models/demo_quiz_model.dart';
import 'package:super15/screens/Dashboard/Dashboard.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/services/Database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:super15/services/User.dart';

class QuizModel extends StatefulWidget {
  const QuizModel({Key? key, this.quizData}) : super(key: key);
  final quizData;

  @override
  _QuizModelState createState() => _QuizModelState();
}

class _QuizModelState extends State<QuizModel> {
  List<String> isCompleted = List.empty(growable: true);
  int normalQuizLength = 15;
  @override
  void initState() {
    for (int i = 0; i < normalQuizLength + 1; i++) {
      isCompleted.add(i == 0 ? "progress" : "pending");
    }
    super.initState();
  }

  PageController _controller = new PageController();
  @override
  Widget build(BuildContext context) {
    final quizData = Provider.of<List<DemoQuiz>>(context);
    final userData = Provider.of<List<UserData>>(context);

    return SafeArea(
        child: Scaffold(
            body: backContainer(
                isPadding: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < quizData.length; i++) ...[
                          Container(
                            height: 10.sp,
                            width: 10.sp,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: isCompleted[i] == "progress"
                                    ? Colors.amber
                                    : isCompleted[i] == "pending"
                                        ? wrong
                                        : right),
                          )
                        ]
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "SUPER 100",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500, fontSize: 18.sp),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView.builder(
                          onPageChanged: (page) {
                            setState(() {
                              isCompleted[page -  1] = "completed";
                            });
                          },
                          controller: _controller,
                          itemCount: quizData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: 120.sp,
                                    color: Colors.black12,
                                    child: Center(
                                        child: Text(
                                      quizData[index].question,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                      ),
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: Text(
                                    "Choose your answer and submit",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                    ),
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 2,
                                    color: Colors.black12,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    _optionContainer(quizData[index].options[0],
                                        quizData[0].correctAns, 1),
                                    Spacer(),
                                    _optionContainer(quizData[index].options[1],
                                        quizData[0].correctAns, 2)
                                  ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    _optionContainer(quizData[index].options[2],
                                        quizData[0].correctAns, 3),
                                    Spacer(),
                                    _optionContainer(quizData[index].options[3],
                                        quizData[0].correctAns, 4)
                                  ])
                                ],
                              ),
                            );
                          }),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                "Leaderboard",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                ),
                              )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 40, right: 40, bottom: 10),
                                height: 2,
                                color: Colors.black38,
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: userData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            margin: EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32),
                                                    child: userData[index]
                                                                .profilePhoto ==
                                                            "none"
                                                        ? Image.asset(
                                                            "assets/images/profile_pic.png",
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            userData[index]
                                                                .profilePhoto
                                                                .toString(),
                                                            fit: BoxFit.fill,
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  userData[index].name,
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  userData[index]
                                                      .points
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13.sp,
                                                      color: Colors.black54),
                                                )
                                              ],
                                            ));
                                      }))
                            ],
                          ),
                        )),
                  ],
                ))));
  }

  List<Color> bgColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];
  Color wrong = Color(0XFFFF6967);
  Color right = Color(0XFF16FF72);
  Widget _optionContainer(text, correct, key) {
    return GestureDetector(
      onTap: () async {
        if (correct == key) {
          setState(() {
            bgColors[key - 1] = Color(0XFF16FF72);
          });
        } else {
          setState(() {
            bgColors[key - 1] = Color(0XFFFF6967);
          });
        }
        await Future.delayed(Duration(milliseconds: 500));
        bgColors = [
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent
        ];

        _controller.animateToPage(_controller.page!.toInt() + 1,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        width: 43.w,
        decoration: BoxDecoration(
            color: bgColors[key - 1],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: bgColors[key - 1] == wrong || bgColors[key - 1] == right
                    ? Colors.transparent
                    : Color(0XFF21BDCA))),
        child: Center(
          child: AutoSizeText(
            (text),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
