String remainingDateTime(DateTime dateTime) {
    int differentDays = DateTime.now().difference(dateTime).inDays;
    int differentHour = DateTime.now().difference(dateTime).inHours;
    int differentMinute = DateTime.now().difference(dateTime).inMinutes;
    int differentSecond = DateTime.now().difference(dateTime).inSeconds;

    if (differentDays >= 30) {
      return dateTime.toString();
    }
    if (differentDays >= 21 && differentDays < 30) {
      return '3 weeks ago';
    }
    if (differentDays >= 14 && differentDays < 21) {
      return '2 weeks ago';
    }
    if (differentDays >= 7 && differentDays < 14) {
      return 'a week ago';
    }
    if (differentDays == 1) {
      return '$differentDays day ago';
    }
    if (differentDays > 1) {
      return '$differentDays days ago';
    }
    if (differentHour == 1) {
      return '$differentHour hr ago';
    }
    if (differentHour > 1) {
      return '$differentHour hrs ago';
    }
    if (differentMinute == 1) {
      return '$differentMinute min ago';
    }
    if (differentMinute > 1) {
      return '$differentMinute mins ago';
    }
    if (differentSecond < 60) {
      return 'Just Now';
    }
    return '$differentDays days ago';
  }