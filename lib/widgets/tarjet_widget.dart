import 'package:flutter/material.dart';

class TarjetWidget extends StatelessWidget {
  const TarjetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... tu contenido actual ...
              
              Row(
                children: [
                  Icon(Icons.eco, color: colors.primary, size: 28),
                  SizedBox(width: 10),
                  Text(
                    "¿Qué es Ecoregistro Web?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
    
              SizedBox(height: 10),
              Text(
                "Ecoregistro Web es una plataforma diseñada para facilitar "
                "el registro, consulta y seguimiento de información ambiental.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
    
              SizedBox(height: 20),
    
              Row(
                children: [
                  Icon(Icons.flag, color: colors.primary, size: 26),
                  SizedBox(width: 10),
                  Text(
                    "Objetivo del Proyecto",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
    
              SizedBox(height: 10),
              Text(
                "El objetivo principal es brindar una plataforma digital que "
                "permita visualizar datos del clima y registrar información ambiental.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
    
              SizedBox(height: 20),
    
              Row(
                children: [
                  Icon(Icons.star_rate, color: colors.primary, size: 26),
                  SizedBox(width: 10),
                  Text(
                    "Funciones Principales",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
    
              SizedBox(height: 10),
              Text(
                "• Visualización del clima en tiempo real\n"
                "• Registro de datos ecológicos\n"
                "• Navegación mediante menú lateral\n"
                "• Interfaz ligera y moderna\n"
                "• Carrusel con imágenes informativas",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
