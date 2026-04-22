import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // Obtener el ancho de la pantalla para hacer responsive
    final screenWidth = MediaQuery.of(context).size.width;

    // Definir si está en pantalla chica o grande
    final isSmallScreen = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRegistrarBtn(context, colors),
                const SizedBox(height: 10),
                _buildVerRegistrosBtn(context, colors),
                const SizedBox(height: 10),
                _buildClimaBtn(context, colors),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRegistrarBtn(context, colors),
                _buildVerRegistrosBtn(context, colors),
                _buildClimaBtn(context, colors),
              ],
            ),
    );
  }

  Widget _buildRegistrarBtn(BuildContext context, ColorScheme colors) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, "/registro");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 4,
      ),
      icon: const Icon(Icons.add_circle_outline),
      label: const Text(
        "Registrar actividad",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildVerRegistrosBtn(BuildContext context, ColorScheme colors) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pushNamed(context, "/registrosList"),
      icon: const Icon(Icons.list_alt),
      label: const Text("Ver mis registros"),
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 4,
      ),
    );
  }

  Widget _buildClimaBtn(BuildContext context, ColorScheme colors) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, "/clima");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.tertiary,
        foregroundColor: colors.onTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 4,
      ),
      icon: const Icon(Icons.cloud_outlined),
      label: const Text(
        "Ver clima",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
