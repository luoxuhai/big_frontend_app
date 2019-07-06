import 'package:big_frontend/utils/http_util.dart';

class Api {
  static getDocs(Map<String, dynamic> data) {
    return HttpUtil.request(
      '/v1/docs',
      queryParameters: data,
      method: HttpUtil.GET,
    );
  }

  static getArticles(Map<String, dynamic> data) {
    return HttpUtil.request(
      '/v1/articles',
      queryParameters: data,
      method: HttpUtil.GET,
    );
  }
}
