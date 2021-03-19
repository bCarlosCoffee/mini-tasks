import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'interfaces/task_local_notification_interface.dart';

class FlutterLocalNotificationsService
    implements TaskLocalNotificationsInterface {
  final FlutterLocalNotificationsPlugin _service;

  FlutterLocalNotificationsService(this._service);

  @override
  Future<bool> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    return await _service.initialize(
      const InitializationSettings(
        android: const AndroidInitializationSettings(
          'launcher_icon',
        ),
      ),
    );
  }

  @override
  Future selectNotification(String payload) {
    // TODO: implement selectNotification
    throw UnimplementedError();
  }

  @override
  Future showNotification({
    int? id,
    String? channelID,
    String? channelName,
    String? channelDescription,
    String? title,
    String? body,
    String? payload,
  }) async {
    await _service.show(
      0,
      'Teste',
      'Teste, Teste, Teste',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channelID',
          'channelName',
          'channelDescription',
          importance: Importance.max,
        ),
      ),
    );
  }

  @override
  Future scheduleNotification({
    int? id,
    String? title,
    String? body,
    DateTime? scheduledDate,
    String? channelID,
    String? channelName,
    String? channelDescription,
  }) async {
    await _service.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelID,
          channelName,
          channelDescription,
          importance: Importance.max,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Future cancelNotification(int id) async {
    await _service.cancel(id);
  }
}
