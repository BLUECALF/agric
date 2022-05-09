import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
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
              SizedBox(width: 20,),
              a.GradientElevatedButton.icon(
                gradient: appController.g3,
                icon: Icon(Icons.search),
                onPressed: () async{
                  await appController.scan_devices();
                },
                label:Text("Scan"),
              )
            ],
          ),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
                future: appController.scan_devices(),
                builder: (c,snapshot)
            {

              if(snapshot.hasData && !snapshot.hasError)
                {
                  _devices = snapshot.data as List<BlueDevice>;
                }
              if(listEquals([], _devices))
                {
                  print("there are no devices");
                  return Text("There are  no devices ");
                }

              return ListView.builder(
                itemCount: appController.devices.length,
                itemBuilder: (c,i)
                {
                  return a.GradientCard(
                    gradient: appController.g1,
                    child: ListTile(
                      leading: Icon(Icons.print),
                      title: Text(_devices[i].name.toString()),
                      subtitle: Text(_devices[i].address.toString()),
                      trailing: _conn_check(_devices[i]),
                      onTap: () async
                      {
                        await appController.bluePrintPos.disconnect();
                        // take device  and connect then print.
                        ConnectionStatus conn = await appController.bluePrintPos.connect(_devices[i]);
                        if(conn == ConnectionStatus.connected)
                        {
                         Get.defaultDialog(title:"Connected to ${_devices[i].name}",
                             textConfirm: "ok",content: Text(""),
                           onConfirm: (){Get.back();}
                         );
                         appController.prompt.value = "disconnect";
                        }
                        else if(conn == ConnectionStatus.disconnect)
                        {
                          Get.defaultDialog(title:"NOT connected to ${_devices[i].name}",
                              textConfirm: "ok",content: Text(""),
                              onConfirm: (){Get.back();});
                          appController.prompt.value = "";
                        }
                        else if(conn == ConnectionStatus.timeout)
                        {
                          Get.defaultDialog(title:"Connection Failed Due to Timeout !!"
                          , textConfirm: "ok",content: Text(""),
                              onConfirm: (){Get.back();}
                          );
                          appController.prompt.value = "";
                        }
                      },

                    ),
                  );
                },

              );

            }
            )

    );
  }

  Widget _conn_check(BlueDevice d)
  {
    print("DEVICES R");
    print(appController.bluePrintPos.selectedDevice?.name);
    print(d.name);

    if(appController.bluePrintPos.selectedDevice?.name == d.name)
     {
       print(appController.bluePrintPos.selectedDevice?.name);
       print(d.name);
       return a.GradientElevatedButton(
         gradient: appController.g3,
         onPressed: (){appController.bluePrintPos.disconnect();},
         child: Obx(()=> Text("${appController.prompt}"),),
       );
     }
    else{return Text("");}

  }



}
