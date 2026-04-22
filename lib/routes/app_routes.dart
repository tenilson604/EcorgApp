import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/clima_screen.dart';
import '../screens/registro_screen.dart';
import '../screens/registros_list_screen.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (_) => const LoginScreen(),
    '/home': (_) => const HomeScreen(),
    '/clima': (_) => const ClimaScreen(),
    '/registro': (_) => const RegistroScreen(),
    '/registrosList': (_) => const RegistrosListScreen(),
  };
}
