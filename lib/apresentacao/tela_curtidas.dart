import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/home_store.dart';
import '../servico/entidade/musica.dart';
import 'widgets/cores_spotify.dart';

class TelaCurtidas extends StatelessWidget {
  final HomeStore store;
  const TelaCurtidas({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoresSpotify.fundo,
      appBar: AppBar(
        backgroundColor: CoresSpotify.fundo,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CoresSpotify.branco),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Músicas Curtidas',
          style: TextStyle(
            color: CoresSpotify.branco,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Observer(
        builder: (_) {
          final lista = store.musicasCurtidasLista;

          if (lista.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma música curtida ainda.\nCurta músicas para vê-las aqui.',
                textAlign: TextAlign.center,
                style: TextStyle(color: CoresSpotify.cinza, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: lista.length,
            itemBuilder: (_, index) => _itemMusica(lista[index]),
          );
        },
      ),
    );
  }

  Widget _itemMusica(Musica musica) {
    return Observer(
      builder: (_) {
        final curtida = store.estaCurtida(musica.id);
        final estaToando = store.musicaAtual?.id == musica.id && store.tocando;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 50, height: 50,
              color: CoresSpotify.fundoCard,
              child: Icon(
                Icons.music_note,
                color: estaToando ? CoresSpotify.verde : CoresSpotify.cinza,
              ),
            ),
          ),
          title: Text(
            musica.titulo,
            style: TextStyle(
              color: estaToando ? CoresSpotify.verde : CoresSpotify.branco,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            musica.artista,
            style: const TextStyle(color: CoresSpotify.cinza, fontSize: 13),
          ),
          trailing: IconButton(
            icon: Icon(
              curtida ? Icons.favorite : Icons.favorite_border,
              color: curtida ? CoresSpotify.verde : CoresSpotify.cinza,
              size: 22,
            ),
            onPressed: () => store.toggleCurtir(musica.id),
          ),
          onTap: () => store.tocarMusica(musica),
        );
      },
    );
  }
}
