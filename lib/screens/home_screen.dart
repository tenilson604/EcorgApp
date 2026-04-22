import 'package:flutter/material.dart';
import '../widgets/home_bottons.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/image_carousel.dart';
import '../widgets/tarjet_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const SidebarMenu(),
      appBar: AppBar(
        title: const Text("Inicio"),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Bienvenido a Ecoregistro Web",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const ImageCarousel(),

            const TarjetWidget(),

            const SizedBox(height: 20),

            // Aquí reemplazamos los botones por el nuevo widget
            const HomeButtons(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

