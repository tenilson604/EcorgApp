import 'dart:convert';
import 'package:http/http.dart' as http;

class ClimaService {
  static Future<Map<String, dynamic>> obtenerClimaCompleto() async {
    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=19.43&longitude=-99.13&current_weather=true"
    );

    final res = await http.get(url);

    if (res.statusCode != 200) return {};

    final data = jsonDecode(res.body);
    final clima = data["current_weather"];

    return {
      "temp": clima["temperature"],
      "wind": clima["windspeed"],
      "direction": clima["winddirection"],
      "code": clima["weathercode"],
      "time": clima["time"],
    };
  }
}

