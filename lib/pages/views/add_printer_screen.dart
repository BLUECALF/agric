
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../AppController/app_controller.dart';

class AddPrinter extends GetView{
  late AppController appController = Get.find<AppController>();
  late final List<Map<String, dynamic>> data;
  List<BlueDevice> _devices = [];

  final f = NumberFormat("\$###,###.00","en_US");

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Select Printer"),
              ElevatedButton(
                onPressed: () async{
                  await appController.scann_devices();
                },
                child:Text("Scan Devices"),
              )
            ],
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: FutureBuilder(
                future: appController.scann_devices(),
                builder: (c,snapshot)
            {
              if(snapshot.hasData && !snapshot.hasError)
                {
                  _devices = snapshot.data as List<BlueDevice>;
                }

              return ListView.builder(
                itemCount: appController.devices.length,
                itemBuilder: (c,i)
                {
                  return ListTile(
                    leading: Icon(Icons.print),
                    title: Text(_devices[i].name.toString()),
                    subtitle: Text(_devices[i].address.toString()),
                    trailing: TextButton(
                      onPressed: (){appController.bluePrintPos.disconnect();},
                      child: Obx(()=> Text("${appController.prompt}"),),
                    ),
                    onTap: () async
                    {
                      await appController.bluePrintPos.disconnect();
                      // take device  and connect then print.
                      ConnectionStatus conn = await appController.bluePrintPos.connect(_devices[i]);
                      if(conn == ConnectionStatus.connected)
                      {
                       Get.defaultDialog(title:"Connected to ${_devices[i].name}");
                       appController.prompt.value = "disconnect";
                      }
                      else if(conn == ConnectionStatus.disconnect)
                      {
                        Get.defaultDialog(title:"NOT connected to ${_devices[i].name}");
                        appController.prompt.value = "";
                      }
                      else if(conn == ConnectionStatus.timeout)
                      {
                        Get.defaultDialog(title:"Connection Failed Due to Timeout !!");
                        appController.prompt.value = "";
                      }
                    },

                  );
                },

              );

            }
            )

    );
  }



}
