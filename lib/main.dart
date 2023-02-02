import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/product_overview_screen.dart';
import './providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          textTheme: TextTheme(
            titleMedium: GoogleFonts.roboto(),
            titleLarge: GoogleFonts.roboto(),
            bodyLarge: GoogleFonts.roboto(),
            bodyMedium: GoogleFonts.roboto(),
            bodySmall: GoogleFonts.roboto(),
          ),
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
