import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';

const String dailyTask = "daily_reminder_task";

class BackgroundService {
  @pragma('vm:entry-point')
  static void callbackDispatcher() {

    Workmanager().executeTask((task, inputData) async {

      if (task == dailyTask) {

        await NotificationService.init(); 

        await NotificationService.showNotification();

      }

      return Future.value(true);
    });
  }
}