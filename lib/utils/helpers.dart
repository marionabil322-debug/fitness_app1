class Helpers {
  static String formatDate(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  static String emoji(String category) {
    switch (category.toLowerCase()) {
      case 'strength':
        return '💪';
      case 'cardio':
        return '🏃';
      case 'hiit':
        return '⚡';
      case 'yoga':
        return '🧘';
      default:
        return '🏋️';
    }
  }
}
