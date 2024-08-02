class Category {
  final int id;
  final String title;

  Category({required this.id, required this.title});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }
}
