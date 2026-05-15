import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/complaint.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<Complaint>> getComplaints() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/complaints'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> complaintsJson = data['data'];
        return complaintsJson.map((json) => Complaint.fromJson(json)).toList();
      } else {
        throw Exception('فشل في تحميل الشكاوى');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بالخادم: $e');
    }
  }

  static Future<Complaint> addComplaint({
    required String citizenName,
    required String description,
    // double? latitude,
    // double? longitude,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/complaints'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'citizen_name': citizenName,
          'description': description,
          // 'latitude': latitude,
          // 'longitude': longitude,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Complaint.fromJson(data['data']);
      } else {
        throw Exception('فشل في إرسال الشكوى: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بالخادم: $e');
    }
  }
}
