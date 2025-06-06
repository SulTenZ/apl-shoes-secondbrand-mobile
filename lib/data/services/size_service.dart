// lib/data/services/size_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api_constant.dart';
import '../api/api_endpoint.dart';
import '../../utils/shared_preferences.dart';

class SizeService {
  Future<Map<String, dynamic>> getAllSizes({
    String? search,
    int? limit,
    int? page,
    String? productTypeId,
  }) async {
    final token = await SharedPrefs.getToken();

    final queryParams = {
      if (search != null) 'search': search,
      if (limit != null) 'limit': limit.toString(),
      if (page != null) 'page': page.toString(),
      if (productTypeId != null) 'productTypeId': productTypeId,
    };

    final uri = Uri.parse(ApiEndpoint.sizes).replace(queryParameters: queryParams);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        ...ApiConstant.header,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'data': data['data'],
        'meta': data['meta'],
      };
    } else {
      throw Exception('Gagal mengambil data ukuran');
    }
  }

  Future<void> createSize(String label, String productTypeId) async {
    final url = Uri.parse(ApiEndpoint.sizes);
    final token = await SharedPrefs.getToken();

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        ...ApiConstant.header,
      },
      body: jsonEncode({
        'label': label,
        'productTypeId': productTypeId,
      }),
    );

    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Gagal membuat ukuran');
    }
  }

  Future<void> updateSize(String id, String label, String productTypeId) async {
    final url = Uri.parse(ApiEndpoint.sizeById(id));
    final token = await SharedPrefs.getToken();

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        ...ApiConstant.header,
      },
      body: jsonEncode({
        'label': label,
        'productTypeId': productTypeId,
      }),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Gagal memperbarui ukuran');
    }
  }

  Future<void> deleteSize(String id) async {
    final url = Uri.parse(ApiEndpoint.sizeById(id));
    final token = await SharedPrefs.getToken();

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        ...ApiConstant.header,
      },
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Gagal menghapus ukuran');
    }
  }
}
