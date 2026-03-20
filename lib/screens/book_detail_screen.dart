import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 450.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A1A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.book.id,
                child: CachedNetworkImage(
                  imageUrl: widget.book.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[200], child: const Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => const Icon(Icons.book, size: 100),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.book.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.auto_stories_outlined, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.book.pages} trang',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.book.title,
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tác giả: ${widget.book.author}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  Text(
                    'Giới thiệu nội dung',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.book.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tính năng đọc sách đang được phát triển...')),
                        );
                      },
                      icon: const Icon(Icons.chrome_reader_mode_rounded),
                      label: const Text(
                        'ĐỌC SÁCH NGAY',
                        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A1A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
