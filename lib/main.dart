import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  runApp(const MyLibraryApp());
}

class MyLibraryApp extends StatelessWidget {
  const MyLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Library',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        textTheme: GoogleFonts.outfitTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF263238),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const LibraryHomeScreen(),
    );
  }
}
