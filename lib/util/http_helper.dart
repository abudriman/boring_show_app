import 'package:http/http.dart' as http;

class HttpController {
  static Future getUrl(String url, [Map<String, String>? headers]) async {
    var uri = Uri.parse(url);
    return await http.get(uri, headers: headers);
  }
}
