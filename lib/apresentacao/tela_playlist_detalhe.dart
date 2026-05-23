import 'package:flutter/material.dart';
import '../servico/entidade/playlist.dart';
import '../store/home_store.dart';
import '../servico/entidade/musica.dart';
import 'widgets/cores_spotify.dart';
import 'widgets/mini_player.dart';

class TelaPlaylistDetalhe extends StatelessWidget {
  final Playlist? playlist;
  final HomeStore? homeStore;

  const TelaPlaylistDetalhe({this.playlist, this.homeStore, super.key});

  @override
  Widget build(BuildContext context) {
    final titulo = playlist?.nome ?? 'Playlist';
    final ids = playlist?.musicaIds ?? [];
    final musicas = (homeStore != null && ids.isNotEmpty)
      ? homeStore!.musicas.where((m) => ids.contains(m.id)).toList()
      : <Musica>[];
    return Scaffold(
      backgroundColor: CoresSpotify.fundo,
      appBar: AppBar(
        backgroundColor: CoresSpotify.fundo,
        title: Text(titulo, style: const TextStyle(color: CoresSpotify.branco)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CoresSpotify.branco),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: homeStore != null
          ? MiniPlayer(store: homeStore!)
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('Músicas', style: TextStyle(color: CoresSpotify.branco, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: musicas.isEmpty
                  ? const Center(child: Text('Nenhuma faixa disponível', style: TextStyle(color: CoresSpotify.cinza)))
                  : ListView.builder(
                      itemCount: musicas.length,
                      itemBuilder: (_, index) {
                        final m = musicas[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                          leading: Container(width:50, height:50, color: CoresSpotify.fundoCard, child: const Icon(Icons.music_note, color: CoresSpotify.cinza)),
                          title: Text(m.titulo, style: const TextStyle(color: CoresSpotify.branco)),
                          subtitle: Text(m.artista, style: const TextStyle(color: CoresSpotify.cinza)),
                          onTap: () {
                            if (homeStore != null) homeStore!.tocarMusica(m);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
