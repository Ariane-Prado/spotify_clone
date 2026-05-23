import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../store/home_store.dart';
import '../../rotas.dart';
import 'cores_spotify.dart';

class MiniPlayer extends StatelessWidget {
  final HomeStore store;
  const MiniPlayer({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final musica = store.musicaAtual;

        if (musica == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            routeVideo,
            arguments: {
              'videoUrl':     musica.videoUrl,
              'titulo':       musica.titulo,
              'artista':      musica.artista,
              'playlistNome': '',
            },
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: CoresSpotify.miniPlayer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          width: 44, height: 44,
                          color: CoresSpotify.cinzaEscuro,
                          child: const Icon(Icons.music_note, color: CoresSpotify.cinza),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              musica.titulo,
                              style: const TextStyle(
                                color: CoresSpotify.branco,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              musica.artista,
                              style: const TextStyle(
                                color: CoresSpotify.cinza,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          final curtida = store.estaCurtida(musica.id);
                          return IconButton(
                            icon: Icon(
                              curtida ? Icons.favorite : Icons.favorite_border,
                              color: curtida ? CoresSpotify.verde : CoresSpotify.branco,
                              size: 20,
                            ),
                            onPressed: () => store.toggleCurtir(musica.id),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          store.tocando ? Icons.pause : Icons.play_arrow,
                          color: CoresSpotify.branco,
                          size: 26,
                        ),
                        onPressed: () => store.toggleTocando(),
                      ),
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  value: musica.progresso,
                  backgroundColor: CoresSpotify.cinzaEscuro,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    CoresSpotify.branco,
                  ),
                  minHeight: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
