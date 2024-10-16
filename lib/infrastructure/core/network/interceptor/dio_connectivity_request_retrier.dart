// import 'dart:async';

// import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';

// class DioConnectivityRequestRetrier {
//   final Dio dio;
//   final Connectivity connectivity;

//   DioConnectivityRequestRetrier({
//     required this.dio,
//     required this.connectivity,
//   });

//   Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
//     StreamSubscription? streamSubscription;
//     final responseCompleter = Completer<Response>();

//     streamSubscription = connectivity.onConnectivityChanged.listen(
//       (connectivityResult) async {
//         if (!connectivityResult.contains(ConnectivityResult.none)) {
//           streamSubscription?.cancel();
//           // Complete the completer instead of returning
//           responseCompleter.complete(
//             await dio.request(
//               requestOptions.path.toString(),
//               cancelToken: requestOptions.cancelToken,
//               data: requestOptions.data,
//               onReceiveProgress: requestOptions.onReceiveProgress,
//               onSendProgress: requestOptions.onSendProgress,
//               queryParameters: requestOptions.queryParameters,
//               options: Options(
//                 method: requestOptions.method,
//                 extra: requestOptions.extra,
//                 contentType: requestOptions.contentType,
//                 headers: requestOptions.headers,
//                 validateStatus: requestOptions.validateStatus,
//                 responseType: requestOptions.responseType,
//               ),
//             ),
//           );
//         } else {
//           showError(message: 'Please check your internet connectivity.');
//         }
//       },
//     );

//     return responseCompleter.future;
//   }
// }
