import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/book.dart';

class FavoritesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Lấy User ID hiện tại
  String? get _uid => _auth.currentUser?.uid;

  // Lưu sách vào yêu thích
  Future<void> addToFavorites(Book book) async {
    if (_uid == null) return;
    try {
      await _db
          .collection('users')
          .doc(_uid)
          .collection('favorites')
          .doc(book.id)
          .set(book.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // Xóa khỏi yêu thích
  Future<void> removeFromFavorites(String bookId) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(bookId)
        .delete();
  }

  // Kiểm tra xem sách đã được yêu thích chưa
  Future<bool> isFavorite(String bookId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(bookId)
        .get();
    return doc.exists;
  }

  // Lấy danh sách yêu thích dạng Stream
  Stream<List<Book>> getFavorites() {
    if (_uid == null) return Stream.value([]);
    return _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .snapshots()
        .map((snap) => snap.docs.map((d) => Book.fromJson(d.data())).toList());
  }
}
