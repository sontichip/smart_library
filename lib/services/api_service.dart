import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static Future<List<Book>> fetchBooks() async {
    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'flutter',
      'maxResults': '20',
    });

    try {
      print('Đang gọi API: $url');
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        return items.map((item) => Book.fromJson(item)).toList();
      } else {
        print('Lỗi Server: ${response.statusCode} - ${response.body}');
        throw Exception('Lỗi máy chủ (${response.statusCode})');
      }
    } catch (e) {
      print('Lỗi thực tế: $e');
      if (e.toString().contains('SocketException') || e.toString().contains('HttpException')) {
        throw Exception('Không có kết nối internet. Vui lòng kiểm tra và thử lại.');
      }
      throw Exception('Lỗi hệ thống: $e');
    }
  }

  // Phương thức này giờ sẽ được gọi thủ công từ UI nếu cần
  static List<Book> getMockBooks() {
    return [
      Book(
        id: '1',
        title: 'Lập trình Flutter cơ bản',
        author: 'Google Developers',
        category: 'Lập trình',
        image: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400',
        description: 'Cuốn sách này hướng dẫn bạn xây dựng ứng dụng di động đa nền tảng đẹp mắt và hiệu quả với Flutter. Từ việc cài đặt môi trường đến việc làm chủ Widget, State Management và tích hợp API thực tế.',
        pages: 450,
      ),
      Book(
        id: '2',
        title: 'Clean Code',
        author: 'Robert C. Martin',
        category: 'Công nghệ',
        image: 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=400',
        description: 'Mã sạch là cuốn sách kinh điển dành cho lập trình viên muốn nâng tầm kỹ năng viết code. Tác giả Robert C. Martin trình bày các nguyên tắc và triết lý để tạo ra phần mềm dễ đọc, dễ bảo trì và mở rộng.',
        pages: 464,
      ),
      Book(
        id: '3',
        title: 'Trí Tuệ Nhân Tạo',
        author: 'Stuart Russell',
        category: 'AI & Data',
        image: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400',
        description: 'Khám phá thế giới trí tuệ nhân tạo từ lý thuyết cơ bản đến các ứng dụng tiên tiến như học máy, mạng nơ-ron và robot học. Một tài liệu không thể thiếu cho những ai muốn hiểu về tương lai của công nghệ.',
        pages: 520,
      ),
      Book(
        id: '4',
        title: 'Big Data',
        author: 'Viktor Mayer',
        category: 'AI & Data',
        image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=400',
        description: 'Big Data giải thích cách dữ liệu quy mô lớn đang định hình lại nền kinh tế, khoa học và lối sống của chúng ta. Cuốn sách giúp bạn hiểu sức mạnh của thông tin và cách khai phá tiềm năng của nó.',
        pages: 380,
      ),
    ];
  }
}
