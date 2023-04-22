import 'package:bluetooth_device/screens/home_screen.dart';
import 'package:bluetooth_device/widgets/single_device.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxBool isActiveBlue = false.obs;
  final FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;


  scanBluetooth()async{
    isActiveBlue.value = false;
    HomeScreen.bluetoothList.clear();
    flutterBluePlus.startScan(timeout: Duration(seconds: 4));
    var subscription =  flutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if(r.device.name.isNotEmpty){
          HomeScreen.bluetoothList.add(SingleDevice(bluetoothDevice: r.device));
        }
        print('result for device ${r.device}');
      }
    });
      flutterBluePlus.stopScan();
      isActiveBlue.value = true;
  }


  @override
  void onInit() {
    super.onInit();
    scanBluetooth();
  }





}