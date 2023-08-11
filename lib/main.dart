// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_appwrite/quiz_screen.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(430, 932),
        minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => 
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Quiz app",
        home: HomePage(),
      ),
    ),
  );
}
