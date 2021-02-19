import 'dart:convert';
import 'package:http/http.dart' as http;

enum HTTP_METHOD { GET, POST, PUT, DELETE, HEAD, PATH }

mixin ApiConfig {
  String baseURL = 'https://api.coingecko.com/api/v3/';
}

class BaseNetworkAdapter with ApiConfig {
  Map<String, String> headers = {"Content-Type": "application/json"};
  Map<String, dynamic> parameters = Map();
  Map<String, String> paths = Map();
  Map<String, dynamic> body = Map();
  var method = HTTP_METHOD.GET;

  List<http.MultipartFile> listMultiPartFile = [];

  String url = '';
  String basePath = '';

  Future<Map<String, dynamic>> multipartRequest() async {
    preRequest();
    processUrl();
    var uri = Uri.parse(url);

    var method = 'POST';
    if (this.method == HTTP_METHOD.PUT) {
      method = 'PUT';
    }

    var request = http.MultipartRequest(method, uri);
    request.fields.addAll(body);
    request.files.addAll(listMultiPartFile);
    var response = await request.send();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Map<String, dynamic>();
    } else {
      throw Exception('Request fail');
    }
  }

  Future<dynamic> request() async {
    preRequest();
    processUrl();
    http.Response response;
    print('$url\n$method\n$body\n$headers');
    try {
      if (method == HTTP_METHOD.GET) {
        response = await http.get(url, headers: headers);
      } else if (method == HTTP_METHOD.POST) {
        response =
            await http.post(url, headers: headers, body: jsonEncode(body));
      } else if (method == HTTP_METHOD.DELETE) {
        response = await http.delete(url, headers: headers);
      } else if (method == HTTP_METHOD.PUT) {
        response =
            await http.put(url, headers: headers, body: jsonEncode(body));
      }

      print('${response.statusCode}\n${json.decode(response.body)}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        throw Exception('Request fail');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Request fail');
    }
  }

  void preRequest() {}

  void processUrl() {
    String path = processPaths();
    String parametersString = processParameters();
    var buffer = StringBuffer();
    buffer.write('$baseURL');
    if (basePath.isNotEmpty) {
      buffer.write('/$basePath');
    }
    if (path.isNotEmpty) {
      buffer.write('/$path');
    }
    if (parametersString.isNotEmpty) {
      buffer.write('?$parametersString');
    }
    url = buffer.toString();
  }

  String processPaths() {
    var buffer = StringBuffer();
    paths.forEach((key, value) {
      if (null != value) {
        buffer.write('$key/$value/');
      } else {
        buffer.write('$key/');
      }
    });
    return buffer.toString();
  }

  String processParameters() {
    var buffer = StringBuffer();
    parameters.forEach((key, value) {
      if (null != value) {
        buffer.write('$key=$value');
      }
    });
    return buffer.toString();
  }

  void addParameter(String key, String value) {
    parameters[key] = value;
  }

  void addPath(String key, String value) {
    paths[key] = value;
  }

  void addAPath(String key) {
    paths[key] = null;
  }

  void addHeader(String key, String value) {
    headers[key] = value;
  }

  void addAuthorizationHeader({String token}) {
    addHeader('Authorization', 'Bearer $token');
  }

  void addBody(String key, dynamic value) {
    body[key] = value;
  }

  void setBody(Map<String, dynamic> body) {
    this.body = body;
  }

  void setMethod(HTTP_METHOD method) {
    this.method = method;
  }

  // To know how to create a MultiPartFile, read this link: https://pub.dev/documentation/http/latest/http/MultipartFile-class.html
  void addAMultiPartFile(http.MultipartFile multipartFile) {
    listMultiPartFile.add(multipartFile);
  }

  void setBasePath(String path) {
    basePath = path;
  }
}
