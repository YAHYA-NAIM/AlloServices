class HistoryItem {
  final String categoryName;
  final List<String> subCategories;
  final String date;

  HistoryItem({
    required this.categoryName,
    required this.subCategories,
    required this.date,
  });

  factory HistoryItem.fromMap(Map<String, dynamic> data) {
    return HistoryItem(
      categoryName: data['serviceName'] ?? '',
      subCategories: List<String>.from(data['subServices'] ?? []),
      date: (data['orderDate'] as String?) ?? '',
    );
  }
}
