import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colors.primary),
            child: Text("Menú", style: TextStyle(color: colors.onPrimary, fontSize: 24)),
          ),

          ExpansionTile(
            title: const Text("Registros"),
            children: [
              ListTile(
                title: const Text("Registrar actividad"),
                onTap: () => Navigator.pushNamed(context, '/registro'),
              ),
              ListTile(
                title: const Text("Ver Mis Registros"),
                onTap: () => Navigator.pushNamed(context, '/registrosList'),
              )
            ],
          ),

          ListTile(
            title: const Text("Clima"),
            onTap: () => Navigator.pushNamed(context, '/clima'),
          ),

          ListTile(
            title: const Text("Cerrar Sesión"),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }
}
