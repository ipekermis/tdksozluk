class SearchHistoryItem {
  final String word;
  final String? type;

  SearchHistoryItem({required this.word, this.type});

  Map<String, dynamic> toJson() => {
    'word': word,
    'type': type,
  };

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) {
    return SearchHistoryItem(
      word: json['word'],
      type: json['type'],
    );
  }
}