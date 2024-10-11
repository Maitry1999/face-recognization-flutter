import 'package:attandence_system/infrastructure/core/network/interceptor/dio_connectivity_request_retrier.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  AppInterceptors({required this.requestRetrier});
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // switch (err.type) {
    //   case DioExceptionType.connectionError:
    //     var res = await requestRetrier.scheduleRequestRetry(err.requestOptions);

    //     return handler.resolve(res);
    //   //return res;

    //   default:
    // }
    return handler.next(err);
  }
}
