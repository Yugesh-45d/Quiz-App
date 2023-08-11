// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_appwrite/quiz_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int score = 0;
  int currentQuestion = 0;
  List<Quiz> quizes = [];
  // bool isLoading = false;

  Future getQuestions() async {
    http.Response response = await http.get(
        Uri.parse(
          "https://cloud.appwrite.io/v1/databases/64bcd648a75f0f5988d5/collections/64bcd65c3f4089519ddc/documents",
        ),
        headers: {
          'Content-Type': 'application/json',
          'X-Appwrite-Project': '64bcd61aae23d6f6adee',
        });

    if (response.statusCode == 200) {
      setState(() {
        for (var item in jsonDecode(response.body)['documents']) {
          quizes.add(Quiz(item['title'], item['option1'], item['option2'],
              item['option3'], item['option4'], item['correctoption']));
        }
      });
    }
  }

  reset() {
    setState(() {
      currentQuestion = 0;
      score = 0;
    });
  }

  checkAnswer(int userchoice) {
    setState(() {
      if (quizes[currentQuestion].correctoption == userchoice) {
        score++;
      }
      if (currentQuestion == quizes.length - 1) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Result"),
            content: Text("Your score is $score out of ${quizes.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reset();
                },
                child: Text("Play again"),
              ),
            ],
          ),
        );
        return;
      }
      currentQuestion++;
    });
  }

  @override
  void initState() {
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quiz Game"),
          centerTitle: true,
        ),
        body: quizes.isNotEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.green.shade200,
                        ),
                        alignment: Alignment.center,
                        height: 80.h,
                        width: double.maxFinite.w,
                        child: Text(
                          quizes[currentQuestion].title,
                          style: TextStyle(fontSize: 32.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                      child: SizedBox(
                        height: 48.h,
                        width: double.maxFinite.w,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              checkAnswer(1);
                            });
                          },
                          child: Text(
                            quizes[currentQuestion].option1,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                      child: SizedBox(
                        height: 48.h,
                        width: double.maxFinite.w,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              checkAnswer(2);
                            });
                          },
                          child: Text(
                            quizes[currentQuestion].option2,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                      child: SizedBox(
                        height: 48.h,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              checkAnswer(3);
                            });
                          },
                          child: Text(
                            quizes[currentQuestion].option3,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                      child: SizedBox(
                        height: 48.h,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              checkAnswer(4);
                            });
                          },
                          child: Text(
                            quizes[currentQuestion].option4,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            reset();
          },
          child: Icon(
            Icons.refresh,
          ),
        ),
      ),
    );
  }
}
