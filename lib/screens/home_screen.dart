import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'book_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LibraryHomeScreen extends StatefulWidget {
  const LibraryHomeScreen({super.key});

  @override
  State<LibraryHomeScreen> createState() => _LibraryHomeScreenState();
}

class _LibraryHomeScreenState extends State<LibraryHomeScreen> {
  late Future<List<Book>> _futureBooks;
  String _query = '';
  String _selectedCategory = 'Tất cả';
  List<String> _categories = ['Tất cả'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _futureBooks = ApiService.fetchBooks();
    });
  }

  List<Book> _getFilteredBooks(List<Book> books) {
    // 1. Lọc theo thể loại
    List<Book> filtered = books.where((b) {
      return _selectedCategory == 'Tất cả' || b.category == _selectedCategory;
    }).toList();

    // 2. Lọc NGHIÊM NGẶT: Chỉ lấy sách có TIÊU ĐỀ bắt đầu bằng chữ cái tìm kiếm
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      filtered = filtered.where((b) {
        return b.title.toLowerCase().startsWith(q);
      }).toList();
    }

    // 3. Sắp xếp A-Z
    filtered.sort((a, b) => a.title.compareTo(b.title));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'TH3 - Bùi Ngọc Tùng Sơn - 2351160546',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Tìm theo chữ cái đầu...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (ctx, i) {
                  final cat = _categories[i];
                  final isSel = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSel,
                      onSelected: (_) => setState(() => _selectedCategory = cat),
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF1A1A1A),
                      labelStyle: TextStyle(
                        color: isSel ? Colors.white : const Color(0xFF1A1A1A),
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: isSel ? Colors.transparent : Colors.grey[300]!),
                      ),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: _futureBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF1A1A1A)));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off_rounded, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.error.toString().replaceAll('Exception: ', ''),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _loadData,
                            icon: const Icon(Icons.refresh),
                            label: const Text('THỬ LẠI'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A1A1A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _futureBooks = Future.value(ApiService.getMockBooks());
                              });
                            },
                            child: const Text('Xem dữ liệu mẫu (Offline)', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  final books = snapshot.data!;
                  final foundCategories = books.map((b) => b.category).toSet().toList();
                  foundCategories.sort();
                  if (_categories.length <= 1 && foundCategories.isNotEmpty) {
                    Future.microtask(() {
                      setState(() {
                        _categories = ['Tất cả', ...foundCategories];
                      });
                    });
                  }

                  final filteredList = _getFilteredBooks(books);
                  if (filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 60, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text('Không tìm thấy sách phù hợp', style: TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                    );
                  }
                  
                  return RefreshIndicator(
                    onRefresh: () async {
                      _loadData();
                    },
                    color: const Color(0xFF1A1A1A),
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: filteredList.length,
                      itemBuilder: (ctx, i) => _buildBookCard(filteredList[i]),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Book book) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Hero(
                        tag: book.id,
                        child: CachedNetworkImage(
                          imageUrl: book.image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey[100], child: const Center(child: CircularProgressIndicator(strokeWidth: 2))),
                          errorWidget: (context, url, error) => Container(color: Colors.grey[100], child: const Icon(Icons.book, size: 40, color: Colors.grey)),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            book.category,
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14, height: 1.2),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
