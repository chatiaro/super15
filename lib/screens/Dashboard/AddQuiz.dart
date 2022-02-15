import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Login/widgets/action_button.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/values/UiColors.dart';
import 'package:table_calendar/table_calendar.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({Key? key}) : super(key: key);

  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> with TickerProviderStateMixin {
  int quesNo = 1;
  var date = "null";
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 7.h,
            elevation: 0.0,
            flexibleSpace: _header(),
          ),
          body: backContainer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _body()
            ],
          )),
        ),
        date == "null"
            ? _calendar()
            : Container(),
      ],
    ));
  }

  Widget _header() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios_new)),
          SizedBox(
            width: 30,
          ),
          Text(
            "Question " + quesNo.toString(),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
          Spacer(),
          Icon(Icons.more_vert)
        ],
      ),
    );
  }

  Widget _calendar(){
    return Center(
                child: ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(
                            color: Colors.black.withOpacity(0.2),
                            child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    margin:
                                        EdgeInsets.fromLTRB(20, 20.h, 20, 18.h),
                                    width: 85.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Material(
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Text("Select Quiz Date",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                    )),
                                              ),
                                              SizedBox(height: 20),
                                              SizedBox(height: 4),
                                              TableCalendar(
                                                selectedDayPredicate: (day) =>
                                                    isSameDay(
                                                        day, _selectedDay),
                                                calendarBuilders:
                                                    CalendarBuilders(
                                                  todayBuilder:
                                                      (context, date, _) {
                                                    return FadeTransition(
                                                      opacity: Tween(
                                                              begin: 0.0,
                                                              end: 1.0)
                                                          .animate(
                                                              _animationController),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .all(1.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 16.0,
                                                                left: 14.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        width: 50,
                                                        height: 50,
                                                        child: Text(
                                                          '${date.day}',
                                                          style: TextStyle()
                                                              .copyWith(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  selectedBuilder:
                                                      (context, date, _) {
                                                    return Container(
                                                        margin: const EdgeInsets
                                                            .all(4.0),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: UiColors
                                                                .primary,
                                                            border: Border.all(
                                                                color: UiColors
                                                                    .primary),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: Text(
                                                          date.day.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ));
                                                  },
                                                ),
                                                headerStyle: HeaderStyle(
                                                    formatButtonShowsNext: true,
                                                    titleCentered: true,
                                                    formatButtonVisible: false,
                                                    titleTextStyle:
                                                        new TextStyle(
                                                            color: Color(
                                                                0xFF000000),
                                                            fontSize: 20)),
                                                onDaySelected:
                                                    (selectedDay, focusedDay) {
                                                  focusedDay = selectedDay;
                                                  print(
                                                      "_focusedDay"); // update `_focusedDay` here as well

                                                  setState(() {
                                                    _selectedDay = selectedDay;
                                                    _focusedDay = focusedDay;
                                                    print(
                                                        "_focusedDay"); // update `_focusedDay` here as well
                                                    print(
                                                        _focusedDay); // update `_focusedDay` here as well
                                                  });
                                                },
                                                firstDay: DateTime.now(),
                                                lastDay: DateTime(2023, 03, 31),
                                                focusedDay: _focusedDay,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              actionButton(
                                                  text: "Next",
                                                  onClick: () {
                                                    setState(() {
                                                      date = DateFormat(
                                                              "dd-MM-yy")
                                                          .format(
                                                              _selectedDay!);
                                                    });
                                                  })
                                            ]),
                                      ),
                                    )))))));
  }

  Widget _body() {
    return Container(
          width: 100.w,
          height: 85.h,                    
          child: PageView.builder(itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                        children: [
                          _output(
                            "Quiz Date",
                            DateFormat("dd-MM-yy").format(_selectedDay!),
                          ),
                          Spacer(),
                          _output("Question No.", quesNo.toString()),
                        ],
                      ),
                
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Add Question",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, fontSize: 13.sp),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 120.sp,
                    width: 89.w,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black.withOpacity(0.3))),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: new InputDecoration.collapsed(
                          hintText: "Add Question Here",
                          hintStyle: TextStyle(color: Colors.black26)),
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter options and choose correct \nanswer",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, fontSize: 13.sp),
                  ),
                  _optionContainer(1),
                  _optionContainer(2),
                  _optionContainer(3),
                  _optionContainer(4),
                  ],
              ),
            );
          }),
    );
  }

  Widget _output(title, text, {controller, half = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
        ),
        Text(
          title,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(text,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, fontSize: 10.sp)),
        )
      ],
    );
  }

  int _radioValue = 0;
  int where = 0;

  Widget _optionContainer(int index) {
    return Container(
      width: 90.w,
      height: 60,
      child: GestureDetector(
        onTap: () {
          _handleRadioValueChange(0);
        },
        child: Container(
          width: 90.w,
          height: 60,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              border: Border.all(color: UiColors.primary)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 70.w,
                      height: 100.h,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Option ' + index.toString() ,
                        ),
                      ))),
              Spacer(),
              new Radio(
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;

      switch (_radioValue) {
        case 0:
          setState(() {
            where = 0;
          });
          break;

        case 1:
          setState(() {
            where = 1;
          });
          break;
      }
    });
  }
}
