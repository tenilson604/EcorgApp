import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class RegistrosService {
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/registros.json';
  }

  static Future<List<Map<String, dynamic>>> obtenerRegistros() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('registros') ?? '[]';
      final List<dynamic> data = jsonDecode(jsonString);
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      try {
        final path = await _getFilePath();
        final file = File(path);

        if (!file.existsSync()) return [];

        final contenido = await file.readAsString();
        final List<dynamic> data = jsonDecode(contenido);

        return data.map((e) => Map<String, dynamic>.from(e)).toList();
      } catch (e) {
        debugPrint('Error al leer registros: $e');
        return [];
      }
    }
  }

  static Future<void> guardarRegistro(Map<String, dynamic> registro) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final registros = await obtenerRegistros();
      registros.add(registro);
      await prefs.setString('registros', jsonEncode(registros));
    } else {
      try {
        final path = await _getFilePath();
        final file = File(path);

        List<dynamic> registros = [];

        if (file.existsSync()) {
          final contenido = await file.readAsString();
          registros = jsonDecode(contenido);
        }

        registros.add(registro);

        await file.writeAsString(jsonEncode(registros));
      } catch (e) {
        debugPrint('Error al guardar registro: $e');
        throw Exception('No se pudo guardar el registro');
      }
    }
  }

  // Método para eliminar un registro por su timestamp
  static Future<void> eliminarRegistro(String timestamp) async {
    final registros = await obtenerRegistros();
    registros.removeWhere((reg) => reg['timestamp'] == timestamp);
    await _guardarLista(registros);
  }

  // Método para actualizar un registro por su timestamp
  static Future<void> actualizarRegistro(String timestamp, Map<String, dynamic> nuevoRegistro) async {
    final registros = await obtenerRegistros();
    final index = registros.indexWhere((reg) => reg['timestamp'] == timestamp);
    if (index != -1) {
      registros[index] = nuevoRegistro;
      await _guardarLista(registros);
    }
  }

  // Guarda la lista completa de registros (usado por eliminar y actualizar)
  static Future<void> _guardarLista(List<Map<String, dynamic>> registros) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('registros', jsonEncode(registros));
    } else {
      try {
        final path = await _getFilePath();
        final file = File(path);
        await file.writeAsString(jsonEncode(registros));
      } catch (e) {
        debugPrint('Error al guardar la lista de registros: $e');
        throw Exception('No se pudo guardar la lista de registros');
      }
    }
  }
}
