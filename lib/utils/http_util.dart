import 'package:dio/dio.dart';
import 'package:big_frontend/config.dart';

class HttpUtil {
  static String token;
  static Config _config = Config();
  static Dio _dio;

  /// http request methods
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String PATCH = 'PATCH';
  static const String DELETE = 'DELETE';

  /// 创建 dio 实例对象
  static Future<Dio> createInstance() async {
    if (_dio == null) {
      // 初始化 Options
      BaseOptions _options = BaseOptions(
          baseUrl: _config.baseUrl,
          connectTimeout: _config.connectTimeout,
          receiveTimeout: _config.receiveTimeout,
          headers: {});

      _dio = Dio(_options);
    }

    /// 拦截器
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print(options);
      return options;

      /// 请求拦截处理
    }, onResponse: (Response response) {
      /// 响应数据之前做一些预处理
      return response;
    }, onError: (DioError e) {
      /// 当请求失败时做一些预处理
      return e;
    }));

    return _dio;
  }

  static Future request(String url,
      {Map data, Map<String, dynamic> queryParameters, String method}) async {
    data = data ?? {};
    queryParameters = queryParameters ?? {};
    method = method ?? 'GET';

    /// restful 请求处理
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    Dio dio = await createInstance();
    var result;
    Response response;
    try {
      response = await dio.request(url,
          data: data,
          queryParameters: queryParameters,
          options: Options(method: method));

      result = response.data;
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }

    return result;
  }
}
