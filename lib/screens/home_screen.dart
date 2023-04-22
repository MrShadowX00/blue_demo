import 'package:bluetooth_device/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static List<Widget> bluetoothList = [];
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Bluetooth demo',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              onPressed: () {
                homeController.scanBluetooth();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (homeController.isActiveBlue.value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: HomeScreen.bluetoothList,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      }),
    );
  }
}
