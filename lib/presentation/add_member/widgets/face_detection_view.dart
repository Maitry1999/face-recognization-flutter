// import 'dart:io';

// import 'package:attandence_system/application/add_new_member/add_new_member_bloc.dart';
// import 'package:attandence_system/injection.dart';
// import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
// import 'package:attandence_system/presentation/painter/face_painter.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:math' as math;

// @RoutePage(name: 'FaceDetectionView')
// class FaceDetectionView extends StatelessWidget {
//   const FaceDetectionView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double mirror = math.pi;
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return BlocProvider(
//       create: (context) =>
//           getIt<AddNewMemberBloc>()..add(AddNewMemberEvent.start()),
//       child: BlocBuilder<AddNewMemberBloc, AddNewMemberState>(
//         builder: (context, state) => Scaffold(
//           appBar: CustomAppBar(title: 'Detect Face'),
//           body: state.initializing ||
//                   state.cameraService.cameraController == null
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : (!state.initializing && state.pictureTaken)
//                   ? SizedBox(
//                       width: width,
//                       height: height,
//                       child: Transform(
//                           alignment: Alignment.center,
//                           transform: Matrix4.rotationY(mirror),
//                           child: FittedBox(
//                             fit: BoxFit.cover,
//                             child: Image.file(File(state.imagePath)),
//                           )),
//                     )
//                   : (!state.initializing && !state.pictureTaken)
//                       ? Transform.scale(
//                           scale: 1.0,
//                           child: AspectRatio(
//                             aspectRatio:
//                                 MediaQuery.of(context).size.aspectRatio,
//                             child: OverflowBox(
//                               alignment: Alignment.center,
//                               child: FittedBox(
//                                 fit: BoxFit.fitHeight,
//                                 child: SizedBox(
//                                   width: width,
//                                   height: width *
//                                       (state.cameraService.cameraController!
//                                           .value.aspectRatio),
//                                   child: Stack(
//                                     fit: StackFit.expand,
//                                     children: <Widget>[
//                                       CameraPreview(state
//                                           .cameraService.cameraController!),
//                                       CustomPaint(
//                                         painter: FacePainter(
//                                           face: state.faceDetected,
//                                           imageSize:
//                                               state.imageSize ?? Size(50, 50),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//         ),
//       ),
//     );
//   }
// }

// class CameraHeader extends StatelessWidget {
//   const CameraHeader(this.title, {super.key, this.onBackPressed});
//   final String title;
//   final void Function()? onBackPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 150,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: <Color>[Colors.black, Colors.transparent],
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkWell(
//             onTap: onBackPressed,
//             child: Container(
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 50,
//               width: 50,
//               child: Center(child: Icon(Icons.arrow_back)),
//             ),
//           ),
//           Text(
//             title,
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(
//             width: 90,
//           )
//         ],
//       ),
//     );
//   }
// }
