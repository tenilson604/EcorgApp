import 'package:flutter/material.dart';
import '../services/registros_service.dart';
import 'registro_screen.dart';

class RegistrosListScreen extends StatefulWidget {
  const RegistrosListScreen({super.key});

  @override
  State<RegistrosListScreen> createState() => _RegistrosListScreenState();
}

class _RegistrosListScreenState extends State<RegistrosListScreen> {
  List<Map<String, dynamic>> registros = [];

  @override
  void initState() {
    super.initState();
    cargarRegistros();
  }

  Future<void> cargarRegistros() async {
    final lista = await RegistrosService.obtenerRegistros();
    setState(() => registros = lista);
  }

  Future<void> eliminarRegistro(String timestamp) async {
    await RegistrosService.eliminarRegistro(timestamp);
    await cargarRegistros();
  }

  void editarRegistro(Map<String, dynamic> registro) async {
    final actualizado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistroScreen(registroEditar: registro),
      ),
    );

    if (actualizado == true) {
      await cargarRegistros();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis registros"),
        elevation: 0,
      ),
      body: registros.isEmpty
          ? Center(
              child: Text(
                "No hay registros guardados",
                style: TextStyle(fontSize: 18, color: colors.primary),
              ),
            )
          : ListView.builder(
              itemCount: registros.length,
              itemBuilder: (context, index) {
                final reg = registros[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(
                      reg["nombre"] ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: colors.primary,
                      ),
                    ),
                    subtitle: Text(
                      "Fecha: ${reg["fecha"] ?? ""}\nTipo: ${reg["tipo"] ?? ""}\nZona: ${reg["zona"] ?? ""}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: colors.primary),
                            tooltip: 'Editar',
                            onPressed: () => editarRegistro(reg),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            tooltip: 'Eliminar',
                            onPressed: () async {
                              final confirmar = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Confirmar eliminación"),
                                  content: const Text("¿Deseas eliminar este registro?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: Text("Cancelar", style: TextStyle(color: colors.primary)),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmar == true) {
                                await eliminarRegistro(reg["timestamp"]);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

