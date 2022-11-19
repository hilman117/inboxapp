import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String remainingDateTime(BuildContext context, DateTime dateTime) {
  final app = AppLocalizations.of(context);
  int differentDays = DateTime.now().difference(dateTime).inDays;
  int differentHour = DateTime.now().difference(dateTime).inHours;
  int differentMinute = DateTime.now().difference(dateTime).inMinutes;
  int differentSecond = DateTime.now().difference(dateTime).inSeconds;

  if (differentDays >= 30) {
    return dateTime.toString();
  }
  if (differentDays >= 21 && differentDays < 30) {
    return '3 ${app!.weeks}';
  }
  if (differentDays >= 14 && differentDays < 21) {
    return '2 ${app!.weeks}';
  }
  if (differentDays >= 7 && differentDays < 14) {
    return '${app!.week}';
  }
  if (differentDays == 1) {
    return '$differentDays ${app!.oneDayAgo}';
  }
  if (differentDays > 1) {
    return '$differentDays ${app!.daysAgo}';
  }
  if (differentHour == 1) {
    return '$differentHour ${app!.oneHourAgo}';
  }
  if (differentHour > 1) {
    return '$differentHour ${app!.hours}';
  }
  if (differentMinute == 1) {
    return '$differentMinute ${app!.minuteAgo}';
  }
  if (differentMinute > 1) {
    return '$differentMinute ${app!.minutesAgo}';
  }
  if (differentSecond < 60) {
    return '${app!.justNow}';
  }
  return '$differentDays ${app!.daysAgo}';
}
