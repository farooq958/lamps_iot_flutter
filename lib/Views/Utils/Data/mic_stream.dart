// import 'dart:async';
// import 'dart:core';
// import 'dart:math';
//
// import 'package:flutter/animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mic_stream/mic_stream.dart';
//
// enum Command {
//   start,
//   stop,
//   change,
// }
//
// const AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;
//
// class MicStreamExampleApp extends StatefulWidget {
//   @override
//   _MicStreamExampleAppState createState() => _MicStreamExampleAppState();
// }
//
// class _MicStreamExampleAppState extends State<MicStreamExampleApp>
//     with SingleTickerProviderStateMixin, WidgetsBindingObserver {
//   Stream? stream;
//   late StreamSubscription listener;
//   List<int>? currentSamples = [];
//   List<int> visibleSamples = [];
//   int? localMax;
//   int? localMin;
//   final List listOfMaxValuesAtEachStream = [];
//   final List filteredList = [];
//
//   Random rng = new Random();
//
//   // Refreshes the Widget for every possible tick to force a rebuild of the sound wave
//   late AnimationController controller;
//
//   Color _iconColor = Colors.white;
//   bool isRecording = false;
//   bool memRecordingState = false;
//   late bool isActive;
//   DateTime? startTime;
//
//   int page = 0;
//   List state = ["SoundWavePage", "IntensityWavePage", "InformationPage"];
//
//   @override
//   void initState() {
//     print("Init application");
//     super.initState();
//     WidgetsBinding.instance!.addObserver(this);
//     setState(() {
//       initPlatformState();
//     });
//   }
//
//   void _controlPage(int index) => setState(() => page = index);
//
//   // Responsible for switching between recording / idle state
//   void controlMicStream({Command command = Command.change}) async {
//     debugPrint('switch method');
//     switch (command) {
//       case Command.change:
//         changeListening();
//         break;
//       case Command.start:
//         startListening();
//         break;
//       case Command.stop:
//         stopListening();
//         break;
//     }
//   }
//
//   Future<bool> changeListening() async =>
//       !isRecording ? await startListening() : stopListening();
//
//   late int bytesPerSample;
//   late int samplesPerSecond;
//
//   //first tab
//   Future<bool> startListening() async {
//     print("START LISTENING");
//     if (isRecording) return false;
//     // if this is the first time invoking the microphone()
//     // method to get the stream, we don't yet have access
//     // to the sampleRate and bitDepth properties
//     print("wait for stream");
//
//     // Default option. Set to false to disable request permission dialogue
//     MicStream.shouldRequestPermission(true);
//
//     stream = await MicStream.microphone(
//         audioSource: AudioSource.DEFAULT,
//         sampleRate: 1000 * (rng.nextInt(50) + 30),
//         channelConfig: ChannelConfig.CHANNEL_IN_MONO,
//         audioFormat: AUDIO_FORMAT);
//     // after invoking the method for the first time, though, these will be available;
//     // It is not necessary to setup a listener first, the stream only needs to be returned first
//
//     print(
//         "Start Listening to the microphone, sample rate is ${await MicStream.sampleRate}, bit depth is ${await MicStream.bitDepth}, bufferSize: ${await MicStream.bufferSize}");
//     bytesPerSample = (await MicStream.bitDepth)! ~/ 8;
//     samplesPerSecond = (await MicStream.sampleRate)!.toInt();
//     localMax = null;
//     localMin = null;
//
//     setState(() {
//       isRecording = true;
//       startTime = DateTime.now();
//     });
//     visibleSamples = [];
//
//     listener = stream!.listen(_calculateSamples);
//     return true;
//   }
//
//   // void map({
//   //   required int inputStart,
//   //   required int inputEnd,
//   //   required int outputStart,
//   //   required int outputEnd,
//   // }) {
//   //   int inputRange = inputEnd - inputStart;
//   //   int outputRange = outputEnd - outputStart;
//   //
//   //   int output =
//   //       (outputStart + (outputRange / inputRange) * (inputEnd - inputStart))
//   //           .toInt();
//   //   debugPrint('ratio value $output');
//   // }
//
//   void storeStream({required int sample}) {
//     listOfMaxValuesAtEachStream.add(sample);
//     debugPrint('added $listOfMaxValuesAtEachStream');
//   }
//
//   //second tab
//   void _calculateSamples(samples) {
//     debugPrint('calculate samples method');
//     if (page == 0)
//       _calculateWaveSamples(samples);
//     else if (page == 1) _calculateIntensitySamples(samples);
//   }
//
//   void _calculateWaveSamples(samples) {
//     bool first = true;
//     visibleSamples = [];
//     int tmp = 0;
//     for (int sample in samples) {
//       if (sample > 128) sample -= 255;
//       if (first) {
//         tmp = sample * 128;
//       } else {
//         tmp += sample;
//         visibleSamples.add(tmp);
//
//         localMax ??= visibleSamples.last.toInt();
//         localMin ??= visibleSamples.last.toInt();
//         localMax = max(localMax!, visibleSamples.last.toInt());
//         localMin = min(localMin!, visibleSamples.last.toInt());
//
//         tmp = 0;
//       }
//       first = !first;
//     }
//     //debugPrint('samples $visibleSamples');
//     //
//     // for (int i = 0; i <= 10; i++) {
//     //   int check = visibleSamples[i] + 16500;
//     //   print('sample $check');
//     // }
//
//     //isko uncomment karo
//     calculateRange(forwardedSamples: samples);
//   }
//
//   void _calculateIntensitySamples(samples) {
//     currentSamples ??= [];
//     int currentSample = 0;
//     eachWithIndex(samples, (i, int sample) {
//       currentSample += sample;
//       if ((i % bytesPerSample) == bytesPerSample - 1) {
//         // debugPrint('current sample ${currentSample}');
//         currentSamples!.add(currentSample);
//         currentSample = 0;
//       }
//     });
//
//     if (currentSamples!.length >= samplesPerSecond / 10) {
//       visibleSamples
//           .add(currentSamples!.map((i) => i).toList().reduce((a, b) => a + b));
//       localMax ??= visibleSamples.last.toInt();
//       localMin ??= visibleSamples.last.toInt();
//       localMax = max(localMax!, visibleSamples.last.toInt());
//       localMin = min(localMin!, visibleSamples.last.toInt());
//       currentSamples = [];
//       setState(() {});
//     }
//     storeStream(sample: localMax!);
//     debugPrint('samples $samples');
//     debugPrint('max $localMax');
//     debugPrint('min $localMin');
//     debugPrint('visible samples $visibleSamples');
//     debugPrint('intensity waves ${visibleSamples.last}');
//     // map(
//     //   inputStart: 0,
//     //   inputEnd: localMax!,
//     //   outputEnd: 255,
//     //   outputStart: 0,
//     // );
//   }
//
//   bool stopListening() {
//     if (!isRecording) return false;
//     print("Stop Listening to the microphone");
//     listener.cancel();
//
//     setState(() {
//       isRecording = false;
//       currentSamples = null;
//       startTime = null;
//     });
//     return true;
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     if (!mounted) return;
//     isActive = true;
//
//     controller =
//         AnimationController(duration: Duration(seconds: 1), vsync: this)
//           ..addListener(() {
//             if (isRecording) setState(() {});
//           })
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed)
//               controller.reverse();
//             else if (status == AnimationStatus.dismissed) controller.forward();
//           })
//           ..forward();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       isActive = true;
//       print("Resume app");
//
//       controlMicStream(
//           command: memRecordingState ? Command.start : Command.stop);
//     } else if (isActive) {
//       memRecordingState = isRecording;
//       controlMicStream(command: Command.stop);
//
//       print("Pause app");
//       isActive = false;
//     }
//   }
//
//   @override
//   void dispose() {
//     listener.cancel();
//     controller.dispose();
//     WidgetsBinding.instance!.removeObserver(this);
//     super.dispose();
//   }
//
// //////////////////////////////////////////////////
//   void calculateRange({required List forwardedSamples}) async {
//     debugPrint('here');
//     for (int i = 0; i <= 30; i++) {
//       //int check = forwardedSamples[i] + 16500;
//       int check = forwardedSamples[i];
//       debugPrint('check => $check');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox();
//   }
// }
//
// class WavePainter extends CustomPainter {
//   int? localMax;
//   int? localMin;
//   List<int>? samples;
//   late List<Offset> points;
//   Color? color;
//   BuildContext? context;
//   Size? size;
//
//   // Set max val possible in stream, depending on the config
//   // int absMax = 255*4; //(AUDIO_FORMAT == AudioFormat.ENCODING_PCM_8BIT) ? 127 : 32767;
//   // int absMin; //(AUDIO_FORMAT == AudioFormat.ENCODING_PCM_8BIT) ? 127 : 32767;
//
//   WavePainter(
//       {this.samples, this.color, this.context, this.localMax, this.localMin});
//
//   @override
//   void paint(Canvas canvas, Size? size) {
//     this.size = context!.size;
//     size = this.size;
//
//     Paint paint = Paint()
//       ..color = color!
//       ..strokeWidth = 3.0
//       ..style = PaintingStyle.stroke;
//
//     if (samples!.isEmpty) return;
//
//     points = toPoints(samples);
//
//     Path path = Path();
//     path.addPolygon(points, false);
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldPainting) => true;
//
//   // Maps a list of ints and their indices to a list of points on a cartesian grid
//   List<Offset> toPoints(List<int>? samples) {
//     List<Offset> points = [];
//     if (samples == null)
//       samples = List<int>.filled(size!.width.toInt(), (0.5).toInt());
//     double pixelsPerSample = size!.width / samples.length;
//     for (int i = 0; i < samples.length; i++) {
//       var point = Offset(
//           i * pixelsPerSample,
//           0.2 *
//               size!.height *
//               pow((samples[i] - localMin!) / (localMax! - localMin!), 5));
//       points.add(point);
//     }
//     return points;
//   }
//
//   double project(int val, int max, double height) {
//     double waveHeight =
//         (max == 0) ? val.toDouble() : (val / max) * 0.5 * height;
//     return waveHeight + 0.5 * height;
//   }
// }
//
// Iterable<T> eachWithIndex<E, T>(
//     Iterable<T> items, E Function(int index, T item) f) {
//   var index = 0;
//
//   for (final item in items) {
//     f(index, item);
//     index = index + 1;
//   }
//
//   return items;
// }
