import 'package:flutter/material.dart';
import '../services/clima_service.dart';

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({super.key});

  @override
  State<ClimaScreen> createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  Map<String, dynamic> clima = {};

  @override
  void initState() {
    super.initState();
    cargarClima();
  }

  Future<void> cargarClima() async {
    final data = await ClimaService.obtenerClimaCompleto();
    if (!mounted) return;
    setState(() => clima = data);
  }

  Widget weatherCard({required IconData icon, required String title, required String value}) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 36, color: colors.primary),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clima actual"),
        elevation: 0,
      ),

      body: clima.isEmpty
          ? Center(
              child: CircularProgressIndicator(color: colors.primary),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // Encabezado bonito
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.wb_sunny, size: 60, color: Colors.white),
                        const SizedBox(height: 10),
                        Text(
                          "${clima["temp"]}°C",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Temperatura actual",
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tarjetas con datos
                  weatherCard(
                    icon: Icons.air,
                    title: "Velocidad del viento",
                    value: "${clima["wind"]} km/h",
                  ),

                  weatherCard(
                    icon: Icons.explore,
                    title: "Dirección del viento",
                    value: "${clima["direction"]}°",
                  ),

                  weatherCard(
                    icon: Icons.cloud,
                    title: "Código del clima",
                    value: clima["code"].toString(),
                  ),

                  weatherCard(
                    icon: Icons.access_time,
                    title: "Última actualización",
                    value: clima["time"],
                  ),
                ],
              ),
            ),
    );
  }
}




