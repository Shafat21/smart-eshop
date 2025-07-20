// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'utils/shared_prefs.dart';
import 'utils/constants.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/product_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Smart EShop',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProv.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':               (_) => SplashScreen(),
        '/login':          (_) => LoginScreen(),
        '/register':       (_) => RegisterScreen(),
        '/home':           (_) => HomeScreen(),
        '/cart':           (_) => CartScreen(),
        '/checkout':       (_) => CheckoutScreen(),   // ← Now recognized
        '/favourites':     (_) => FavouritesScreen(),
        '/profile':        (_) => ProfileScreen(),
        '/product_detail': (_) => ProductDetailScreen(),
      },
    );
  }
}
