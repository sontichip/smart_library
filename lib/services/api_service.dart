import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class ApiService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<Book>> fetchBooks() async {
    try {
      // Đầu tiên hãy kiểm tra và seed dữ liệu nếu cần
      await seedInitialBooks();

      final snapshot = await _firestore.collection('books').limit(20).get();
      return snapshot.docs.map((doc) => Book.fromMap(doc.data(), doc.id)).toList();
    } on FirebaseException catch (e) {
      print('Lỗi Firebase: $e');
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        throw Exception('Không có kết nối internet. Vui lòng kiểm tra lại mạng.');
      }
      throw Exception('Lỗi Firebase: ${e.message}');
    } catch (e) {
      print('Lỗi khác: $e');
      if (e.toString().contains('SocketException') || e.toString().contains('network')) {
        throw Exception('Không có kết nối internet. Vui lòng kiểm tra lại mạng.');
      }
      throw Exception('Lỗi hệ thống: $e');
    }
  }

  // Tự động đẩy dữ liệu mẫu lên Firebase nếu chưa có gì
  static Future<void> seedInitialBooks() async {
    try {
      final query = await _firestore.collection('books').limit(1).get();
      if (query.docs.isNotEmpty) return; // Đã có dữ liệu, không làm gì cả

      print('Đang đẩy dữ liệu mẫu lên Firebase...');
      final mockBooks = getMockBooks();
      for (var book in mockBooks) {
        await _firestore.collection('books').add(book.toMap());
      }
    } catch (e) {
      print('Không thể seed dữ liệu: $e');
    }
  }

  static List<Book> getMockBooks() {
    return [
      Book(
        id: '1', title: 'Lập trình Flutter cơ bản', author: 'Google Developers',
        category: 'Lập trình', pages: 450,
        image: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400',
        description: 'Xây dựng ứng dụng đa nền tảng đẹp mắt và hiệu quả với Flutter.',
      ),
      Book(
        id: '2', title: 'Clean Code', author: 'Robert C. Martin',
        category: 'Công nghệ', pages: 464,
        image: 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=400',
        description: 'Mã sạch là cuốn sách kinh điển hướng dẫn viết code dễ đọc, dễ bảo trì.',
      ),
      Book(
        id: '3', title: 'Trí Tuệ Nhân Tạo', author: 'Stuart Russell',
        category: 'AI & Data', pages: 520,
        image: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400',
        description: 'Khám phá lý thuyết và ứng dụng tiên tiến của AI trong cuộc sống.',
      ),
      Book(
        id: '4', title: 'Big Data', author: 'Viktor Mayer',
        category: 'AI & Data', pages: 380,
        image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=400',
        description: 'Sức mạnh của dữ liệu quy mô lớn trong kỷ nguyên số hiện đại.',
      ),
      Book(
        id: '5', title: 'Design Patterns', author: 'Gang of Four',
        category: 'Lập trình', pages: 395,
        image: 'https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?w=400',
        description: 'Các mẫu thiết kế phần mềm quan trọng nhất dành cho lập trình viên.',
      ),
      Book(
        id: '6', title: 'Hacker Đạo Đức', author: 'Kevin Mitnick',
        category: 'Bảo mật', pages: 320,
        image: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400',
        description: 'Tìm hiểu về an ninh mạng và các kỹ thuật phòng thủ từ góc nhìn hacker.',
      ),
      Book(
        id: '7', title: 'Tương Lai Công Nghệ', author: 'Elon Musk (Mock)',
        category: 'Năng lượng', pages: 350,
        image: 'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=400',
        description: 'Khám phá những công nghệ đột phá định hình lại nhân loại.',
      ),
      Book(
        id: '8', title: 'Deep Learning', author: 'Ian Goodfellow',
        category: 'AI & Data', pages: 800,
        image: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=400',
        description: 'Tài liệu giáo khoa toán học và thuật toán chuyên sâu về Deep Learning.',
      ),
      Book(
        id: '9', title: 'Kotlin for Android', author: 'Antonio Leiva',
        category: 'Lập trình', pages: 310,
        image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400',
        description: 'Học cách phát triển ứng dụng Android chuyên nghiệp bằng ngôn ngữ Kotlin.',
      ),
      Book(
        id: '10', title: 'UI/UX Design', author: 'Steve Krug',
        category: 'Thiết kế', pages: 250,
        image: 'https://images.unsplash.com/photo-1586717791821-3f44a563eb4c?w=400',
        description: 'Đừng bắt người dùng phải suy nghĩ - Nguyên tắc trải nghiệm người dùng tuyệt vời.',
      ),
    ];
  }
}
