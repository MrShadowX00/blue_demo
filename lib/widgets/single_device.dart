import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class SingleDevice extends StatefulWidget {
  final BluetoothDevice bluetoothDevice;

  const SingleDevice({Key? key, required this.bluetoothDevice})
      : super(key: key);

  @override
  State<SingleDevice> createState() => _SingleDeviceState();
}

class _SingleDeviceState extends State<SingleDevice> {
  bool isConnected = false;
  List<BluetoothService> bluetoothServices = [];
  List<BluetoothDevice> bluetoothDevices = [];
  getInfo()async{
    bluetoothServices = await widget.bluetoothDevice.discoverServices();
    bluetoothServices.forEach((service) async {
      print('========== service$service===================');

    });

  }

  checkDevice()async{
    bluetoothDevices = await  FlutterBluePlus.instance.connectedDevices;
    bluetoothDevices.forEach((device) {
      if(widget.bluetoothDevice == device){
        isConnected = true;
      }
    });
  }


  @override
  void initState() {
    checkDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.blue),
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.bluetoothDevice.name,
                style:const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 10,),
            GestureDetector(
              onTap: ()async {
                if(isConnected){
                  widget.bluetoothDevice.disconnect();
                  setState((){
                    isConnected = !isConnected;
                  });
                }else {

                     await widget.bluetoothDevice.connect();
                    getInfo();

                  // // Iterate through the services and get the UUID of each service
                  // services.forEach((service) {
                  //   print('Service UUID: ${service.uuid}');
                  //
                  //   // Iterate through the characteristics of each service and get their UUIDs
                  //   service.characteristics.forEach((characteristic) {
                  //     print('Characteristic UUID: ${characteristic.uuid}');
                  //   });
                  // });
                   // bluetoothServices = await widget.bluetoothDevice.discoverServices();
                   // print(bluetoothServices[0].uuid);
                  setState(() {
                    isConnected = !isConnected;
                    // showBottomSheet(context: context, builder: (context)=>Container(
                    //   height: 100,
                    //   width: Get.width,
                    // ));
                  });
                }
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child:  Center(
                  child: (isConnected)?const Text('Disconnect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),):const Text('Connect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
