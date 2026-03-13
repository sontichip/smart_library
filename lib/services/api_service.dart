import '../models/book.dart';

class ApiService {
  static Future<List<Book>> fetchBooks() async {
    final list = [
      Book(id: 1, title: 'Lập trình Flutter cơ bản', author: 'Google Developers', description: 'Hướng dẫn toàn diện về xây dựng ứng dụng di động.', category: 'Lập trình', image: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400', pages: 450),
      Book(id: 2, title: 'Clean Code', author: 'Robert C. Martin', description: 'Quy tắc viết mã sạch và dễ bảo trì.', category: 'Lập trình', image: 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=400', pages: 464),
      Book(id: 3, title: 'Trí Tuệ Nhân Tạo (AI)', author: 'Stuart Russell', description: 'Tương lai của công nghệ thế giới.', category: 'AI & Data', image: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400', pages: 520),
      Book(id: 4, title: 'Dữ liệu lớn (Big Data)', author: 'Viktor Mayer', description: 'Cách dữ liệu lớn định hình cuộc sống.', category: 'AI & Data', image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=400', pages: 380),
      Book(id: 5, title: 'An toàn thông tin mạng', author: 'Kevin Mitnick', description: 'Nghệ thuật bảo vệ dữ liệu số.', category: 'Cybersecurity', image: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400', pages: 410),
      Book(id: 6, title: 'Python cho mọi người', author: 'Charles Severance', description: 'Học lập trình Python từ cơ bản.', category: 'Lập trình', image: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=400', pages: 350),
      Book(id: 7, title: 'Cấu trúc dữ liệu và giải thuật', author: 'Nguyễn Đức Nghĩa', description: 'Nền tảng cho kỹ sư phần mềm.', category: 'Lập trình', image: 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=400', pages: 512),
      Book(id: 8, title: 'Học máy với Python', author: 'Andreas C. Müller', description: 'Ứng dụng thực tế của học máy.', category: 'AI & Data', image: 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400', pages: 390),
      Book(id: 9, title: 'Kỹ thuật tấn công mạng', author: 'Georgia Weidman', description: 'Tìm hiểu lỗ hổng bảo mật.', category: 'Cybersecurity', image: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400', pages: 530),
      Book(id: 10, title: 'Kiến trúc máy tính', author: 'John L. Hennessy', description: 'Cách hệ thống máy tính vận hành.', category: 'Công nghệ', image: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400', pages: 480),
    ];
    await Future.delayed(const Duration(milliseconds: 800));
    return list;
  }
}
