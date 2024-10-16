// import 'dart:io';

// import 'package:attandence_system/domain/core/api_constants.dart';
// import 'package:attandence_system/infrastructure/core/network/common_response.dart';
// import 'package:attandence_system/infrastructure/core/network/interceptor/api_error_interceptors.dart';
// import 'package:attandence_system/infrastructure/core/network/interceptor/dio_connectivity_request_retrier.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class ApiService {
//   CommonResponse commonResponse = CommonResponse();
//   static Dio dio = Dio();

//   static Dio initAPIService({bool isMultipart = false}) {
//     final interceptor = InterceptorsWrapper(
//       onRequest: (options, handler) {
//         String? userToken = '';
//         options.headers.addAll({
//           "Authorization": "Bearer $userToken",
//         });

//         return handler.next(options); //continue
//       },
//       onResponse: (response, handler) {
//         return handler.resolve(response); // continue
//       },
//       onError: (DioException e, handler) async {
//         return handler.next(e); //continue
//       },
//     );
//     var acceptHeader = Headers.jsonContentType;
//     var contentTypeHeader = isMultipart
//         ? Headers.multipartFormDataContentType
//         : Headers.jsonContentType;
//     var headers = {
//       HttpHeaders.acceptHeader: acceptHeader,
//       HttpHeaders.contentTypeHeader: contentTypeHeader,
//     };
//     final BaseOptions options = BaseOptions(
//       baseUrl: ApiConstants.baseUrl,
//       connectTimeout: const Duration(milliseconds: 5000), //5s
//       receiveTimeout: const Duration(milliseconds: 15000), //15s
//       headers: headers,
//       contentType: isMultipart
//           ? Headers.multipartFormDataContentType
//           : Headers.jsonContentType,
//     );

//     dio = Dio(options)
//       ..interceptors.addAll([
//         LogInterceptor(
//           requestBody: true,
//           responseBody: true,
//         ),
//         AppInterceptors(
//             requestRetrier: DioConnectivityRequestRetrier(
//           dio: dio,
//           connectivity: Connectivity(),
//         )),
//         interceptor,
//       ]);

//     return dio;
//   }

//   Future<CommonResponse> postMethod(String path, dynamic data,
//       {bool isMultipart = false,
//       FormData? formData,
//       Map<String, dynamic>? queryParameters}) async {
//     dio = initAPIService(isMultipart: isMultipart);

//     var response = await dio.post(
//       path,
//       data: isMultipart ? formData : data,
//       queryParameters: queryParameters,
//     );

//     return CommonResponse.fromJson(response.data);
//   }

//   Future<CommonResponse?> getMethod(String path,
//       {Map<String, dynamic>? queryParameters}) async {
//     dio = initAPIService();

//     var response = await dio.get(
//       path,
//       queryParameters: queryParameters,
//     );

//     return CommonResponse.fromJson(response.data);
//   }

//   Future<CommonResponse?> putMethod(String path,
//       {Map<String, dynamic>? queryParameters,
//       dynamic data,
//       bool isMultipart = false,
//       FormData? formData}) async {
//     dio = initAPIService(isMultipart: isMultipart);

//     var response = await dio.put(
//       path,
//       data: isMultipart ? formData : data,
//       queryParameters: queryParameters,
//     );

//     return CommonResponse.fromJson(response.data);
//   }

//   Future<CommonResponse?> deleteMethod(
//     String path, {
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     dio = initAPIService();

//     var response = await dio.delete(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//     );

//     return CommonResponse.fromJson(response.data);
//   }
// }
