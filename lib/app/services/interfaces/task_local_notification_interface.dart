abstract class TaskLocalNotificationsInterface {
  Future<bool> init();
  Future selectNotification(String payload);
  Future showNotification({
    String channelID,
    String channelName,
    String channelDescription,
    int id,
    String title,
    String body,
    String payload,
  });
  Future scheduleNotification({
    int? id,
    String? title,
    String? body,
    DateTime? scheduledDate,
    String? channelID,
    String? channelName,
    String? channelDescription,
  });
  Future cancelNotification(int id);
}
