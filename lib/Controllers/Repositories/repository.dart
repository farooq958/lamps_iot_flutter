import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Repository {
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
  static int songId = 0;
  static Duration duration = const Duration();
  static Duration position = const Duration();

  //store songs title in list
  static List<SongModel>? songsList = [];
  static List fetchedSongList = [];

  static RecorderController waveformController = RecorderController();

  //play song method
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
      audioPlayer.play();
      // debugPrint('recording ${waveformController.record()}');
      // StreamSubscription<void> wavesValue =  waveformController.record().asStream().listen((data) {
      //   if(data != null){
      //
      //   }
      //   debugPrint('recording stream ${data}');
      // });
      waveformController.record();
      debugPrint('valueeeeee ${waveformController.record}');

      // debugPrint('1 ${audioPlayer.currentIndexStream}');
      // // isPlaying == true;
      // audioPlayer.currentIndexStream.listen((value) {
      //   print('Value from stream: $value');
      // });
      //
      StreamSubscription<double?> streamSubscription =
          audioPlayer.pitchStream.listen((value) {
        print('Value from controller 02: $value');
      });
      // debugPrint('pitch value $streamSubscription');
    } on Exception {
      debugPrint('error while parsing song');
    }
  }

  //19-Dec-2022

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
}
