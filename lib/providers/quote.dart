class Quote {
  final String id;
  final String quote;
  final String author;
  final String authorId;
  bool isFav;
  Quote({
    required this.id,
    required this.quote,
    required this.author,
    required this.authorId,
    this.isFav = false,
  });
}
