import 'package:dio/dio.dart';

import '../../cache/cache_helper.dart';
import '../../paths/ApiEndpoints.dart';
import '../../services/service_locator.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKeys.authorization] =
        'Bearer ${getIt<CacheHelper>().getData(key: ApiKeys.token)}';


    super.onRequest(options, handler);
  }
}
