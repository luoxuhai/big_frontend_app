import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

/*
 * 封装 restful 请求
 * 
 * GET、POST、DELETE、PUT、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class HttpUtil {
  /// global dio object
  static Dio dio;
  static var currentCounter;

  /// default options
  static const String BASE_URL = 'http://testapi.natapp1.cc/api/v1';
  static const int CONNECT_TIMEOUT = 60000;
  static const int RECEIVE_TIMEOUT = 60000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
  static const String DOWNLOAD = 'download';

  /// 创建 dio 实例对象
  static Future<Dio> createInstance() async {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = Dio(options);
    }

    return interceptors(dio);
  }

  static Dio interceptors(Dio dio) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      return options;
      // 在请求被发送之前做一些事情
    }, onResponse: (Response response) {
      /// 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) {
      /// 当请求失败时做一些预处理
      return e; //continue
    }));
    return dio;
  }

  /// request method
  static Future request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    /// restful 请求处理
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());

    Dio dio = await createInstance();

    var result;
    Response response;
    try {
      response =
          await dio.request(url, data: data, options: Options(method: method));

      result = response.data;
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }

    return result;
  }

  /// 上传文件
  static Future uplaod(String url, File path, Map data, String field) async {
    String _path = path.path;
    var name = _path.substring(_path.lastIndexOf("/") + 1, _path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    var params = {
      "$field": UploadFileInfo(File(_path), name,
          contentType: ContentType.parse("image/$suffix"))
    };

    data.map((key, val) {
      params[key] = val;
    });

    FormData formData = FormData.from(params);
    Dio dio = await createInstance();

    var result;
    Response response;
    try {
      response = await dio.post(url, data: formData);
      result = response.data;
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
      print(response);
      return response;
    }

    return json.decode(result);
  }

  /// 下载文件
  static Future download(url, savePath) async {
    Response response;
    try {
      response = await dio.download(url, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
    }
    return response.data;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
