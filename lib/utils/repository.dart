import 'exporter.dart';

abstract class Repository<T> {
  final Client? localClient;
  final String baseUrl = "http://localhost:3002/";
  // "http://100.64.193.82:3002/";
  //
  //  "http://192.168.1.18:3002/";
  //college:;

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

  //generic getrequest
  Future<T> getRequest(
      {Client? client, required String path, String? authToken}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path'),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'x-auth-token': authToken,
      },
    );
    // print("API Response: ${response.body}");

    try {
      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      } else {
        throw "${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
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
        // print(response.body);
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

//generic put request
  Future<T> putRequest({
    Client? client,
    required String path,
    required String id,
    required Map<String, dynamic> body,
    String? authToken,
  }) async {
    final response = await ((client ?? localClient) ?? Client()).put(
      Uri.parse('$baseUrl$endpoint$path/$id'),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'x-auth-token': authToken,
      },
      body: jsonEncode(body),
    );

    try {
      if (response.statusCode == 200) {
        return fromRawJson(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ??
            "${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<T> getById(
      {Client? client,
      required String path,
      required String id,
      String? authToken}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path/$id'),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'x-auth-token': authToken,
      },
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
      {Client? client,
      required String path,
      required String id,
      String? authtoken}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path/$id'),
      headers: {
        'Content-Type': 'application/json',
        if (authtoken != null) 'x-auth-token': authtoken,
      },
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

  Future<List<T>> getAll(
      {Client? client, required String path, String? authToken}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
      Uri.parse('$baseUrl$endpoint$path'),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'x-auth-token': authToken,
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

  Future<List<T>> getByQuery(
      {Client? client, String? path, String? queries}) async {
    final response = await ((client ?? localClient) ?? Client()).get(
        Uri.parse(
            '$baseUrl$endpoint${path == null ? "" : "/$path"}?name=${queries == null ? "" : queries}'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        // print(response.body);
        return fromJsonList(response.body);

        // Success status code for get request is 200
      } else {
        throw "${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> postList({
    Client? client,
    required String path,
    required Map<String, dynamic> body,
  }) async {
    final response = await ((client ?? localClient) ?? Client()).post(
      Uri.parse('$baseUrl$endpoint$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    try {
      if (response.statusCode == 200) {
        return fromJsonList(
            response.body); // ⬅️ important: expecting a list now
      } else {
        throw "${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }
}
