import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'theme_services.dart';

class NotificationController {
  static Future<void> ntfInitialized() async {
    await AwesomeNotifications().initialize('resource://drawable/appicon', [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      )
    ], channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ]);
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static createScheduledNotification(int year, int month, int day, int hour,
      int minute, String title, String note) async {
    ThemeService().switchTheme();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'basic_channel',
          title: title,
          body: note,
          notificationLayout: NotificationLayout.Default,
          bigPicture: 'asset://assets/images/melted-clock.png',
          category: NotificationCategory.Reminder,
        ),
        schedule: NotificationCalendar(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            allowWhileIdle: true));
  }

  createShowNotification() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 0,
      channelKey: 'basic_channel',
      title: "mb",
      body: "Fjhgj",
      // largeIcon:
      //     "https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/174C605829DEB3C79C2F6993EFA97B2ECBF21D6A152E6BB0CA00DDA987E94BAC/scale?width=1200&aspectRatio=1.78&format=jpeg"
    ));
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}
}
