import 'package:flutter/material.dart';

class Complaint {
  final int id;
  final String citizenName;
  final String description;
  final String? category;
  final String status;
  final String? image;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  Complaint({
    required this.id,
    required this.citizenName,
    required this.description,
    this.category,
    required this.status,
    this.image,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  // تحويل JSON إلى كائن Complaint
  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      citizenName: json['citizen_name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? 'pending',
      image: json['image'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // تحويل كائن Complaint إلى JSON (لإرسال شكوى جديدة)
  Map<String, dynamic> toJson() {
    return {
      'citizen_name': citizenName,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

// دالة مساعدة للحصول على النص العربي للحالة
String getStatusText(String status) {
  switch (status) {
    case 'pending':
      return '⏳ قيد الانتظار';
    case 'in_progress':
      return '🛠️ قيد المعالجة';
    case 'resolved':
      return '✅ تم الحل';
    default:
      return status;
  }
}

// دالة مساعدة للحصول على لون الحالة
Color getStatusColor(String status) {
  switch (status) {
    case 'pending':
      return Colors.orange;
    case 'in_progress':
      return Colors.blue;
    case 'resolved':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
