import 'package:flutter/material.dart';
import '../../store/biblioteca_store.dart';
import 'cores_spotify.dart';

class ModalCriar extends StatefulWidget {
  final BibliotecaStore store;
  const ModalCriar({required this.store, super.key});

  @override
  State<ModalCriar> createState() => _ModalCriarState();
}

class _ModalCriarState extends State<ModalCriar> {
  final _controlador = TextEditingController();

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  void _criarPlaylist() {
    final nome = _controlador.text.trim();

    if (nome.isNotEmpty) {
      widget.store.adicionarPlaylist(nome);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Playlist "$nome" criada!'),
          backgroundColor: CoresSpotify.verde,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CoresSpotify.fundoModal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Criar playlist',
            style: TextStyle(
              color: CoresSpotify.branco,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controlador,
            style: const TextStyle(color: CoresSpotify.branco),
            decoration: InputDecoration(
              hintText: 'Nome da playlist',
              hintStyle: const TextStyle(color: CoresSpotify.cinza),
              filled: true,
              fillColor: CoresSpotify.fundoChip,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => _criarPlaylist(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: CoresSpotify.cinza),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _criarPlaylist,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresSpotify.verde,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Criar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
