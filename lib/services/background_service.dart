import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';

const String dailyTask = "daily_reminder_task";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == dailyTask) {
      await NotificationService.init();
      await NotificationService.showNotification();
    }
    return Future.value(true);
  });
}
