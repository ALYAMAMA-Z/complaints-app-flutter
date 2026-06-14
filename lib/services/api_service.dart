import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/complaint.dart';
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // جلب جميع الشكاوى (مع token)
  static Future<List<Complaint>> getComplaints() async {
    try {
      final token = await AuthService.getToken();
      print('🔑 Token retrieved: $token');

      final Map<String, String> headers = {'Accept': 'application/json'};

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(
        Uri.parse('$baseUrl/complaints'),
        headers: headers,
      );

      print('📥 Get response status: ${response.statusCode}');

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

  // إرسال شكوى جديدة (بدون صورة)
  static Future<Complaint> addComplaint({
    required String citizenName,
    required String description,
    double? latitude,
    double? longitude,
  }) async {
    try {
      final token = await AuthService.getToken();
      print('📤 Sending token: $token');

      final response = await http.post(
        Uri.parse('$baseUrl/complaints'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'citizen_name': citizenName,
          'description': description,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

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

  // إرسال شكوى جديدة مع صورة (اختياري، يمكن تعليقه مؤقتاً)
  // static Future<Complaint> addComplaintWithImage({ ... }) { ... }
}
