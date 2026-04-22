import 'package:flutter/material.dart';
import '../services/registros_service.dart';

class RegistroScreen extends StatefulWidget {
  final Map<String, dynamic>? registroEditar;

  const RegistroScreen({super.key, this.registroEditar});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final formKey = GlobalKey<FormState>();

  final nombreCtrl = TextEditingController();
  final fechaCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();
  final zonaCtrl = TextEditingController();
  final descripcionCtrl = TextEditingController();
  final responsableCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.registroEditar != null) {
      final r = widget.registroEditar!;
      nombreCtrl.text = r["nombre"] ?? "";
      fechaCtrl.text = r["fecha"] ?? "";
      tipoCtrl.text = r["tipo"] ?? "";
      zonaCtrl.text = r["zona"] ?? "";
      descripcionCtrl.text = r["descripcion"] ?? "";
      responsableCtrl.text = r["responsable"] ?? "";
    }
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    fechaCtrl.dispose();
    tipoCtrl.dispose();
    zonaCtrl.dispose();
    descripcionCtrl.dispose();
    responsableCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.registroEditar != null;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(esEdicion ? "Editar Actividad" : "Registrar Actividad")),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: fechaCtrl,
                  decoration: const InputDecoration(
                    labelText: "Fecha",
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: tipoCtrl,
                  decoration: const InputDecoration(
                    labelText: "Tipo",
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: zonaCtrl,
                  decoration: const InputDecoration(
                    labelText: "Zona",
                    prefixIcon: Icon(Icons.place_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descripcionCtrl,
                  decoration: const InputDecoration(
                    labelText: "Descripción",
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: responsableCtrl,
                  decoration: const InputDecoration(
                    labelText: "Responsable",
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Limpiar campos sin afectar la edición
                        nombreCtrl.clear();
                        fechaCtrl.clear();
                        tipoCtrl.clear();
                        zonaCtrl.clear();
                        descripcionCtrl.clear();
                        responsableCtrl.clear();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: colors.secondary),
                      child: const Text("Limpiar"),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final nuevoRegistro = {
                            "nombre": nombreCtrl.text.trim(),
                            "fecha": fechaCtrl.text.trim(),
                            "tipo": tipoCtrl.text.trim(),
                            "zona": zonaCtrl.text.trim(),
                            "descripcion": descripcionCtrl.text.trim(),
                            "responsable": responsableCtrl.text.trim(),
                            "timestamp": esEdicion ? widget.registroEditar!["timestamp"] : DateTime.now().toString(),
                          };

                          if (esEdicion) {
                            await RegistrosService.actualizarRegistro(nuevoRegistro["timestamp"]!, nuevoRegistro);
                          } else {
                            await RegistrosService.guardarRegistro(nuevoRegistro);
                          }
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(esEdicion ? "Registro actualizado" : "Registro guardado")),
                          );

                          Navigator.pushReplacementNamed(context, '/registrosList');
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
                      child: Text(esEdicion ? "Actualizar" : "Guardar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
