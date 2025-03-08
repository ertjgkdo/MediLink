import 'exporter.dart';

abstract class Repository<T> {
  final Client? localClient;
  final String baseUrl = "http://localhost:3002/";
  final String endpoint = "api";
  //constructor
  Repository({this.localClient});

//converting raw json to object
  T fromRawJson(String json);
//converting map to object
  T fromJson(Map<String, dynamic> map);
  List<T> fromJsonList(String json) {
    final List<dynamic> decodedList = jsonDecode(json);
    return decodedList.map((item) => fromJson(item)).toList();
  }

//generic POST method
  Future<T> postRequest(
      {Client? client, String path = '/', String? body}) async {
    final response = await ((client ?? localClient) ?? Client())
        .post(Uri.parse('$baseUrl$endpoint$path'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: body);
    try {
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        return fromRawJson(response.body);

        // Success status code for get request is 200
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? "Unknown error occurred");
      }
    } catch (e, stacktrace) {
      throw Exception("Failed: $e, $stacktrace");
    }
  }

  Future<T> getById(
      {Client? client, required String path, required String id}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    try {
      if (response.statusCode == 200) {
        return fromRawJson(response.body);
      } else {
        throw "${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getListById(
      {Client? client, required String path, required String id}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    try {
      if (response.statusCode == 200) {
        return fromJsonList(response.body);
      } else {
        throw "${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getAll({Client? client, required String path}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print("API Response: ${response.body}");

    try {
      if (response.statusCode == 200) {
        return fromJsonList(response.body);
      } else {
        throw "${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }
}
