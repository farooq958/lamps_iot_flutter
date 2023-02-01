import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:keptua/Models/isolate_duration_model.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Repository {
  //nEXTINDEX
static int indexe=0;
  static int nextIndex=0;
  //wifi gateway initial value
  static String? wifiGateWayIP = 'Unknown'; //192.168.4.1

  //introduction screens controller
  static PageController onBoardingSelectedPage = PageController(
    initialPage: 0,
  );

  //audio player search TextField controller
  static TextEditingController audioPlayerSearchTextFieldController =
      TextEditingController();

  //fetching audios initializer
  static final OnAudioQuery audioQuery = OnAudioQuery();

  //play audio properties
  static final AudioPlayer audioPlayer = AudioPlayer();
late Socket socket;
  static int songId = 0;
  static Duration duration = const Duration();
  static Duration position = const Duration();
static double pitch = 0;
  //store songs title in list
  static List<SongModel>? songsList = [];
  static List fetchedSongList = [];
static int durr=0;
//   static RecorderController waveformController = RecorderController();
// static PlayerController playerController= PlayerController();
  //play song method
  // static void  _initialiseController() {
  //   playerController = PlayerController();
  // }
  static playSong({
    required String? songUri,
    //required Function setState,
  }) async {
    try {
     audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(songUri!),
        ),
      );

   // Future<int?> sec= duur.then((value) => value?.inSeconds);
    //print("checkc");
 // print(   sec.toString());
await Future.delayed(Duration(seconds: 2));
      audioPlayer.play();

    //  var int=  audioPlayer.duration?.inSeconds;
 //print(duration.inSeconds.toDouble());

      // audioPlayer.playerStateStream.listen((event)
      //
      // {
      //   wavedata.clear();
      //   if(event.playing==true){ wavedata.add(audioPlayer.pitch.toInt());}  });
      // debugPrint('recording ${waveformController.record()}');
      // audioPlayer.pitchStream.listen((event) {
      //  // StreamAudioResponse(sourceLength: 10, contentLength: 10, offset: 10, stream: audioint, contentType: 'audio/opus');
      //   wavedata.add(event.toInt());
      //
      // });
      // StreamSubscription<void> wavesValue =  waveformController.record().asStream().listen((data) {
      //   if(data != null){
      //
      //   }
      //   debugPrint('recording stream ${data}');
      // });

//       audioPlayer.pitchStream.listen((event) {
//         //wavedata.add(event.toInt());
// print("pitchpitch"+event.toString());
//
//       });



   //   waveformController.record();
      // playerController.startPlayer();

      //debugPrint('valueeeeee ${waveformController.record}');


      // debugPrint('1 ${audioPlayer.currentIndexStream}');
      // // isPlaying == true;
      // audioPlayer.currentIndexStream.listen((value) {
      //   print('Value from stream: $value');
      // });
      //
      // audioPlayer.pitchStream.listen((value) {
      //   print('Value from controller 02: $value');
      // });
      //StreamSubscription<double?> streamSubscription =

      // debugPrint('pitch value $streamSubscription');
    } on Exception {
      debugPrint('error while parsing song');
    }
  }



  //app exit conformation method
  static appExit({required BuildContext context, required bool theme}) async {
    DateTime? lastTimeButtonPressed;
    final now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    final isWarning = lastTimeButtonPressed == null ||
        now.difference(lastTimeButtonPressed) > maxDuration;

    if (isWarning) {
      lastTimeButtonPressed = DateTime.now();
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme ? AppColors.yellow : AppColors.themeBlack,
        content: Text(
          'Double tap to exit the application',
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            color: AppColors.white,
          ),
        ),
        duration: maxDuration,
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
      return false;
    } else {
      return true;
    }
  }

  //power
  static void power({
    required bool status,
    required String? gatewayIP,
  }) async {
    debugPrint('status = $status');
    debugPrint('gatewayIP = $gatewayIP');

    //'http://'+ip +'/action1?value='+'r'+r+'g'+g+'b'+b+'&':'http://'+ip+'/action1?value='+'r'+'0'+'g'+'0'+'b' +'0' +'&';

    String apiUrl = status
        ? 'http://${gatewayIP!}/action1?value=r255g255b255&'
        : 'http://${gatewayIP!}/action1?value=r0g0b0&';

    try {
      debugPrint('requested url = $apiUrl');
      final res = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'text/html',
        },
      );
      debugPrint('requested Url on off ==> $res');
      if (res.statusCode == 200) {
        debugPrint('status code is 200');
      }
      // else if (res.statusCode != 200) {
      //   // snackBarMessage(context, "Device Error setting color");
      //   // Utils.showSnackBar(context, 'Device Error setting color');
      //   debugPrint('status code is not 200');
      // }
      else if (res.statusCode == 403) {
        debugPrint('status code is 403');
      } else {
        debugPrint('status code at on off ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('catch error at on off  => $e');
    }
  }

  //set color method
  static void setColor({
    required BuildContext context,
    required String? gatewayIP,
    required String? red,
    required String? green,
    required String? blue,
  }) async {
    String apiUrl =
        'http://${gatewayIP!}/action1?value=r${red!}g${green!}b${blue!}';
    debugPrint('requested Url ==> $apiUrl');

    try {
      final res = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'text/html',
      });
      debugPrint('requested Url ==> $res');
      debugPrint('returned status code ==> ${res.statusCode}');
      if (res.statusCode == 200) {
        debugPrint('status code is 200');
        // SharedPrefs.setOpacity(opacity: SharedPrefs.getColor()!);
      }
      // else if (res.statusCode != 200) {
      //   // snackBarMessage(context, "Device Error setting color");
      //   // Utils.showSnackBar(context, 'Device Error setting color');
      //   debugPrint('status code is not 200');
      // }
      else if (res.statusCode == 403) {
        debugPrint('status code is 403');
      } else {
        debugPrint('status code ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('catch error  => $e');
    }
    // finally {
    //   SharedPrefs.setOpacity(opacity: SharedPrefs.getColor());
    //   debugPrint('Saved now ${Color(SharedPrefs.getOpacity()!).alpha}');
    // }
  }
static Future<int?> setAudio({
  required String? audioValue
  ,
  required String? gatewayIP
})async{

  String apiUrl =
      'http://${gatewayIP!}/action2?value=a$audioValue';
  debugPrint('requested Url ==> $apiUrl');

  try {
    final res = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'text/html',
    });
    debugPrint('requested Url ==> $res');
    debugPrint('returned status code ==> ${res.statusCode}');
    if (res.statusCode == 200) {
      debugPrint('status code is 200');
      // SharedPrefs.setOpacity(opacity: SharedPrefs.getColor()!);
    }
    // else if (res.statusCode != 200) {
    //   // snackBarMessage(context, "Device Error setting color");
    //   // Utils.showSnackBar(context, 'Device Error setting color');
    //   debugPrint('status code is not 200');
    // }
    else if (res.statusCode == 403) {
      debugPrint('status code is 403');

    } else {
      debugPrint('status code ${res.statusCode}');
    }
    return res.statusCode;
  } catch (e) {
    debugPrint('catch error  => $e');
  }
  return null;


}
  //set color method
  static void setOpacity({
    required BuildContext context,
    required String? gatewayIP,
    required String? opacity,
  }) async {
    String apiUrl = 'http://${gatewayIP!}/delay?value=$opacity';
    debugPrint('requested Url ==> $apiUrl');

    try {
      final res = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'text/html',
      });
      debugPrint('requested Url ==> $res');
      debugPrint('returned status code ==> ${res.statusCode}');
      if (res.statusCode == 200) {
        debugPrint('status code is 200');
        // SharedPrefs.setOpacity(opacity: SharedPrefs.getColor()!);
      }
      // else if (res.statusCode != 200) {
      //   // snackBarMessage(context, "Device Error setting color");
      //   // Utils.showSnackBar(context, 'Device Error setting color');
      //   debugPrint('status code is not 200');
      // }
      else if (res.statusCode == 403) {
        debugPrint('status code is 403');
      } else {
        debugPrint('status code ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('catch error  => $e');
    }
    // finally {
    //   SharedPrefs.setOpacity(opacity: SharedPrefs.getColor());
    //   debugPrint('Saved now ${Color(SharedPrefs.getOpacity()!).alpha}');
    // }
  }

  //operations
  static void operation({
    //Color color,
    required BuildContext context,
    required String? gatewayIP,
    required String? operation,
  }) async {
    debugPrint('perform operation');
    debugPrint('operation $operation');
    String apiUrl = 'http://${gatewayIP!}/${operation!.toLowerCase()}';
    debugPrint('requested Url ==> $apiUrl');

    try {
      final res = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'text/html',
      });
      debugPrint('requested Url ==> $res');
      debugPrint('returned status code ==> ${res.statusCode}');
      if (res.statusCode == 200) {
        debugPrint('status code is 200');
        // SharedPrefs.setOpacity(opacity: SharedPrefs.getColor()!);
      }
      // else if (res.statusCode != 200) {
      //   // snackBarMessage(context, "Device Error setting color");
      //   // Utils.showSnackBar(context, 'Device Error setting color');
      //   debugPrint('status code is not 200');
      // }
      else if (res.statusCode == 403) {
        debugPrint('status code is 403');
      } else {
        debugPrint('status code ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('catch error  => $e');
    }
    // finally {
    //   SharedPrefs.setOpacity(opacity: SharedPrefs.getColor());
    //   debugPrint('Saved now ${Color(SharedPrefs.getOpacity()!).alpha}');
    // }
  }
  late  Directory directory;
  static Future<void> preparePlayer(String path,int dur, Socket sc ) async
  {
  //  print("object");
//print(duration.inSeconds.toDouble());
    durr=dur;
   // Repository().directory = await getApplicationDocumentsDirectory();
   //
//     print("starttt");
//     print("nnn  "+path);
//  // File Temp =  File.fromRawPath(convertStringToUint8List(path));
//   File temp = File(path);
//   //temp.writeAsBytes(bytes);
// List shorttersamples=[];
//     var dataOffset = 256; // parse the WAV header or determine from a hex dump
//     var bytes = await temp.readAsBytes();
//   var shorts = bytes.buffer.asUint8List(dataOffset);
  //compute<IsolateDuratinModel,void>(heavyTask,IsolateDuratinModel(filePath: path,duration: durr,wifiGatewayIp: wifiGateWayIP));
heavyTask(IsolateDuratinModel(filePath: path,duration: durr,wifiGatewayIp: wifiGateWayIP, sc: sc));
    // Stream<String> lines = temp.openRead()
    //     .transform(utf8.decoder)       // Decode bytes to UTF-8.
    //     .transform(const LineSplitter());    // Convert stream to individual lines.
    //
    //   await for (var line in lines) {
    //     print('$line: ${line.length} characters');
    //   }
    //   print('File is now closed.');
    //
    // lines.listen((event) {
    //
    //   print("${event} daata");
    //
    // });
    //lines.listen((event) {});
   // var shortsend;
   // for(var i=0;i<shorts.length;i++)
   //   {
   //     shortsend.add(shorts[i]);
   //
   //   }

//     var lenth= shorts.length;
//     var positionch= position.inSeconds;
//     //var totalduration=duration.inSeconds;
//     print(Repository.duration.inSeconds);
//     var persecondsample= lenth~/Repository.duration.inSeconds*10;
//     final subscription =Repository.audioPlayer.positionStream.listen(null);
//    subscription.onData((event) async {
//       print("positionn"+event.inSeconds.toString());
//       while(event.inSeconds != Repository.duration.inSeconds)
//         {
//           for(var i = nextIndex;i<=lenth;i+=persecondsample+1)
//             {
//               var check=await  setAudio(audioValue: shorts[i].toString(), gatewayIP: wifiGateWayIP);
// print("fromloop"+shorts[i].toString());
//               if( check !=200)
//   {
//     subscription.cancel();
//     break;
//
//
//   }
//             }
//           if(event.inSeconds== Repository.duration.inSeconds)
//             {
//               break;
//             }
//
//         }
//
//     });


//Repository.nextIndex=0;
//    Repository.audioPlayer.playerStateStream.listen((event) async {
//      if(event.playing)
//        {
//          print("nextIndex"+nextIndex.toString());
// // Timer.periodic(const Duration(seconds: 2), (timer) async {
// // //i=0,i=10
// //
// //
// // });
// //          for (int i = nextIndex; i <= lenth; i+=1000) {
// //            //print(nextIndex);
// //            //Future.delayed(const Duration(milliseconds: 1));
// // //print(shorttersamples);
// // // Timer.periodic(const Duration(seconds: 11), (timer) async {
// // //   while(timer.tick<10)
// // //   {
// // //     //shorttersamples.add(shorts[i]);
// //            var check=  setAudio(audioValue: shorts[i].toString(), gatewayIP: wifiGateWayIP);
// //            print("dataa"+shorts[i].toString());
// //            // print("valuess"+shorts[i].toString());
// //            if(await check != 200  )
// //            {
// //              break;
// //            }
// //            //nextIndex=i;
// // //   }
// // //   if(timer.tick>10) {
// // //     timer.cancel();
// // //   }
// // // });
// //
// //
// //
// //
// //          }
//
//
//
//
//        }
//
//
//
//    });
   // print("psss"+Repository.position.inSeconds.toString());
//Repository.audioPlayer.positionStream.listen((event) { });
//     while(Repository.position.inSeconds <= Repository.duration.inSeconds)
//     {
//       for(var i = nextIndex;i<=lenth;i+=persecondsample)
//       {
//         var check=await  setAudio(audioValue: shorts[i].toString(), gatewayIP: wifiGateWayIP);
//         print("fromloop"+shorts[i].toString());
//         if( check !=200)
//         {
//          // subscription.cancel();
//           break;
//
//
//         }
//       }
//
//
//     }

    // print( shorts); // the first sample of audio
    // print("shortss"+ shorts.length.toString());
   // path = "${Repository().directory.path}/$path";
//     var externalpath = await Repository().getPath_1();
//     String pathskip="content:/";
//     path=path.replaceRange(0, 9, "");
//   print(externalpath[0]+path);
//     // Repository()._requestExternalStorageDirectories(Temp.parent );
//  //File fileaudio= AudioSource.uri(Uri.parse(path));
// // /storage/emulated/0content://media/external/audio/media/1000008064
//     //This is output have to trim or replace content:/ because of error
// print("tempp"+temp.uri.path);
//     playerController.preparePlayer(temp.uri.path);


  }
 static Future<void> heavyTask(IsolateDuratinModel iss)
  async {
    // File Temp =  File.fromRawPath(convertStringToUint8List(path));
    File temp = File(iss.filePath);
 //  var audiooo=AudioPlayer();
    print('heavytask');
    print(  iss.sc.address);
 print(iss.duration);
    //temp.writeAsBytes(bytes);
   // List shorttersamples=[];
    var dataOffset = 256; // parse the WAV header or determine from a hex dump
    var bytes = await temp.readAsBytes();
    var shorts = bytes.buffer.asUint8List(dataOffset);
    int lenth= shorts.length;
    double dataRate= (lenth/iss.duration);

    double sample=dataRate/10;

int dataRate2= dataRate.toInt();
int sample2=sample.toInt();
    print("dataRate"+dataRate2.toString());
    print("sample"+sample2.toString());
      print("object"+iss.duration.toString());
     int index=0;
    //   Timer.periodic(Duration(seconds: iss.duration), (timer) {
    //
    //
    //
    //
    //
    //
    //
    //
    // });
      List<int> toAddAndSend=[0,0,0,0,0];
    //  print("durationfuture"+await audioPlayer.durationFuture.toString());
//       audioPlayer.durationStream.listen((event) {
//
// print("durationn"+iss.duration.toString());
//
//             print("positionss"+event.toString());
//
//           iss.duration--;
//
//       });
   //
   // bool playerPlayingState=false;



  // audioPlayer.playerStateStream.listen((event) async {
  //
  //   //playerPlayingState = event.playing;
  //
  // //       while(iss.duration!=1){
  // //         if(event.playing==false)
  // //         {
  // //           break;
  // //
  // //         }
  // //         await Future.delayed(const Duration(seconds: 2));
  // //         toAddAndSend.clear();
  // //         print("nextIndexx$index");
  // //         for( var i=0;i<dataRate2;i+=sample2)
  // //         {
  // //           toAddAndSend.add(shorts[index].toInt());
  // //
  // //           print(shorts[index].toInt());
  // //
  // //           index+=1;
  // //
  // //         }
  // //         print(toAddAndSend.toString());
  // //
  // //         await  setAudio(audioValue: toAddAndSend.toString(), gatewayIP: iss.wifiGatewayIp);
  // //   iss.duration--;
  // // }
  //
  //
  //   //print( "processing state${event.playing}");
  //
  // });
    print(shorts);
int duplicatePositionCheck=999999;
audioPlayer.positionStream.listen((event) async {
  //duplicatePositionCheck=event.inSeconds;
  print("Positionn"+event.inSeconds.toString());
  //await Future.delayed(const Duration(seconds: 2));
  if(event.inSeconds!=duplicatePositionCheck) {
    if(event.inSeconds!=iss.duration){


    toAddAndSend.clear();
    print("nextIndexx$index");
    for( var i=0;i<dataRate2;i+=sample2)
    {
      // if(nextIndex>5)
      //   {break;}
      // formatAudioValues(shorts[index].toInt());
      toAddAndSend.add(formatAudioValues(shorts[index].toInt()));

      print(shorts[index].toInt());

      index+=1;

    }
    print(toAddAndSend.toString());

    await  setAudio(audioValue: toAddAndSend.toString(), gatewayIP: iss.wifiGatewayIp);
     // iss.sc.write("a$toAddAndSend");
 // iss.duration--;
}

 duplicatePositionCheck=event.inSeconds;
  }



});
  }

//   Future<List<String>> getPath_1() async {
//     var path = await ExternalPath.getExternalStorageDirectories();
//     // [/storage/emulated/0, /storage/B3AE-4D28]
// return path;
//     // please note: B3AE-4D28 is external storage (SD card) folder name it can be any.
//   }
 //  Future<List<Directory>?>? _externalStorageDirectories;
 //  void _requestExternalStorageDirectories(StorageDirectory type) {
 //
 //      _externalStorageDirectories = getExternalStorageDirectories(type: type);
 //
 //  }
 //
 //  static  String convertUint8ListToString(Uint8List uint8list) {
 //    return String.fromCharCodes(uint8list);
 //  }
 // static Uint8List convertStringToUint8List(String str) {
 //    final List<int> codeUnits = str.codeUnits;
 //    final Uint8List unit8List = Uint8List.fromList(codeUnits);
 //
 //    return unit8List;
 //  }
 // static Future<void> init(var progressStream ) async {
 //    final audioFile =
 //    File(p.join((await getTemporaryDirectory()).path, 'audio_waveform.mp3'));
 //    try {
 //      await audioFile.writeAsBytes(
 //          (await rootBundle.load('assets/audio/audio_waveform.mp3')).buffer.asUint8List());
 //      final waveFile =
 //      File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
 //      JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
 //          .listen(progressStream.add, onError: progressStream.addError);
 //    } catch (e) {
 //      progressStream.addError(e);
 //    }
 //  }

  static int formatAudioValues(int audioValue) {
    ///logic to be made
    if(audioValue <= 20)
      {
        return 0;
      }
    else if (audioValue <=50)
      {
        return 50;
      }
    else if (audioValue <=75)
    {
      return 75;
    }
    else if (audioValue <=100)
      {
        return 100;
      }
    else if (audioValue <=125)
    {
      return 125;
    }

    else if(audioValue <=150){
      return 150;

    }
    else if (audioValue <=175)
    {
      return 175;
    }
    else if(audioValue <=200){
      return 200;

    }
    else if (audioValue <=225)
    {
      return 225;
    }
    else {
      return 250;

    }


  }



}
