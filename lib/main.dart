
import 'dart:async';
import 'dart:math';

import 'package:bluetooth_device/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

void main() {
  runApp(const FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      color: Colors.lightBlue,
      home: HomeScreen()
    );
  }
}

