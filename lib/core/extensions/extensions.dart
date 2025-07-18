extension DateTimeHumanizeExtension on DateTime {
  String toHumanized() {
    final now = DateTime.now();
    final date = DateTime(year, month, day);
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final yesterday = today.subtract(Duration(days: 1));
    if (date == today) {
      return 'Today';
    } else if (date == tomorrow) {
      return 'Tomorrow';
    } else if (date == yesterday) {
      return 'Yesterday';
    }
    final difference = now.difference(date);
    if (difference.inDays < 0) {
      // Future dates
      if (date.difference(today).inDays == 1) {
        return 'Tomorrow';
      } else if (date.difference(today).inDays < 7) {
        return 'In ${date.difference(today).inDays} days';
      } else if (date.difference(today).inDays < 30) {
        return 'In ${(date.difference(today).inDays / 7).floor()} weeks';
      } else if (date.difference(today).inDays < 365) {
        return 'In ${(date.difference(today).inDays / 30).floor()} months';
      } else {
        return 'In ${(date.difference(today).inDays / 365).floor()} years';
      }
    }
    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else {
      return '${(difference.inDays / 365).floor()}y ago';
    }
  }
}
