class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category;
  final String image;
  final int pages;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.image,
    required this.pages,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // Google Books API mapping
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>? ?? {};
    final authors = volumeInfo['authors'] as List<dynamic>? ?? [];
    final categories = volumeInfo['categories'] as List<dynamic>? ?? [];
    final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>? ?? {};

    return Book(
      id: json['id']?.toString() ?? '',
      title: volumeInfo['title'] ?? 'Không có tiêu đề',
      author: authors.isNotEmpty ? authors.join(', ') : 'Ẩn danh',
      description: volumeInfo['description'] ?? 'Không có mô tả.',
      category: categories.isNotEmpty ? categories[0] : 'Chung',
      image: imageLinks['thumbnail'] ?? 'https://via.placeholder.com/150',
      pages: volumeInfo['pageCount'] ?? 0,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map, String docId) {
    return Book(
      id: docId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      pages: map['pages'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'author': author,
    'description': description,
    'category': category,
    'image': image,
    'pages': pages,
  };
}
