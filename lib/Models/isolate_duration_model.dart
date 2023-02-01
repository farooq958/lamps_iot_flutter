import 'dart:io';

class IsolateDuratinModel{

    String filePath="";
   int duration=0;
   String? wifiGatewayIp="unknown";
 late  Socket sc;
  IsolateDuratinModel({

   required this.filePath,
   required this.duration,
    required this.wifiGatewayIp,
    required this.sc
});


}