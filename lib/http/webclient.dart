import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

const String baseUrl = 'http://192.168.56.1:8080/transactions';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [
    LoggingInterceptor(),
  ],
   requestTimeout: Duration(seconds: 5),
);
