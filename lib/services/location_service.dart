import 'package:permission_handler/permission_handler.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  // طلب إذن الموقع
  static Future<bool> requestPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  // الحصول على الموقع الحالي (محاكاة للمحاكي)
  static Future<LatLng> getCurrentLocation() async {
    // للمحاكي: نرجع موقع افتراضي (دمشق مثلاً)
    // في التطبيق الحقيقي، ستستخدم موقع الجهاز الفعلي
    
    // هذه إحداثيات افتراضية (يمكنك تغييرها)
    return const LatLng(33.5138, 36.2765); // دمشق، سوريا
  }
}