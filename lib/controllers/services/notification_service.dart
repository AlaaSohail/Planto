import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'plant_care_channel',
    'Plant Care Notifications',
    description: 'Plant care reminders and alerts',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    // طلب صلاحية الإشعارات
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(settings: initializationSettings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    // لما التطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;

      if (notification == null) return;

      await _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'plant_care_channel',
            'Plant Care Notifications',
            channelDescription: 'Plant care reminders and alerts',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    });

    // لما المستخدم يضغط على الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened: ${message.data}');
    });

    final token = await _messaging.getToken();

    print('FCM TOKEN: $token');

    // مهم لأن FCM token ممكن يتغير
    _messaging.onTokenRefresh.listen((newToken) {
      print('NEW FCM TOKEN: $newToken');
    });
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}
