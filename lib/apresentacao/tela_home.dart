import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/home_store.dart';
import '../servico/entidade/playlist.dart';
import '../servico/entidade/musica.dart';
import 'tela_drawer.dart';
import 'tela_curtidas.dart';
import 'widgets/cores_spotify.dart';

class TelaHome extends StatelessWidget {
  final HomeStore store;
  const TelaHome({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoresSpotify.fundo,
      drawer: const TelaDrawer(),
      body: Builder(
        builder: (innerContext) => SafeArea(
          child: Observer(
            builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _construirTopo(innerContext),
                Expanded(
                  child: store.filtroAtivo == 'Música'
                      ? _listaMusicas()
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _construirGridAtalhos(),
                              _secaoHorizontal('Estações recomendadas', store.estacoesRecomendadas),
                              _secaoHorizontal('Seus mixes mais ouvidos', store.mixes),
                              _secaoRecentes(),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _construirTopo(BuildContext context) {
    final filtros = ['Tudo', 'Música', 'Podcasts'];
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: CoresSpotify.verde,
                child: Text('A', style: TextStyle(
                  color: CoresSpotify.branco,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            const SizedBox(width: 12),
            ...filtros.map((filtro) {
              final ativo = store.filtroAtivo == filtro;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => store.alterarFiltro(filtro),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: ativo ? CoresSpotify.verde : CoresSpotify.fundoChip,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filtro,
                      style: TextStyle(
                        color: ativo ? Colors.black : CoresSpotify.branco,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Lista de músicas exibida quando filtro "Música" está ativo
  Widget _listaMusicas() {
    return Observer(
      builder: (_) => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: store.musicas.length,
        itemBuilder: (_, index) => _itemMusica(store.musicas[index]),
      ),
    );
  }

  Widget _itemMusica(Musica musica) {
    return Observer(
      builder: (_) {
        final curtida = store.estaCurtida(musica.id);
        final estaAtiva = store.musicaAtual?.id == musica.id && store.tocando;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 50, height: 50,
              color: CoresSpotify.fundoCard,
              child: Icon(
                Icons.music_note,
                color: estaAtiva ? CoresSpotify.verde : CoresSpotify.cinza,
              ),
            ),
          ),
          title: Text(
            musica.titulo,
            style: TextStyle(
              color: estaAtiva ? CoresSpotify.verde : CoresSpotify.branco,
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

  Widget _construirGridAtalhos() {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.atalhos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3.5,
          ),
          itemBuilder: (ctx, index) => _cardAtalho(ctx, store.atalhos[index]),
        ),
      ),
    );
  }

  Widget _cardAtalho(BuildContext context, Playlist item) {
    return GestureDetector(
      onTap: () {
        if (item.id == 'a1') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TelaCurtidas(store: store)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: CoresSpotify.fundoCard,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              child: Container(
                width: 48, height: 48,
                color: CoresSpotify.cinzaEscuro,
                child: const Icon(Icons.music_note, color: CoresSpotify.cinza, size: 20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.nome,
                style: const TextStyle(
                  color: CoresSpotify.branco,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secaoHorizontal(String titulo, List<Playlist> lista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(titulo, style: const TextStyle(
            color: CoresSpotify.branco,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          )),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: lista.length,
            itemBuilder: (_, i) => _cardHorizontal(lista[i]),
          ),
        ),
      ],
    );
  }

  Widget _cardHorizontal(Playlist item) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 140, height: 140,
              color: CoresSpotify.fundoCard,
              child: const Icon(Icons.music_note, color: CoresSpotify.cinza, size: 40),
            ),
          ),
          const SizedBox(height: 6),
          Text(item.nome, style: const TextStyle(
            color: CoresSpotify.branco,
            fontWeight: FontWeight.bold, fontSize: 13,
          ), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(item.subtitulo, style: const TextStyle(
            color: CoresSpotify.cinza, fontSize: 11,
          ), maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _secaoRecentes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Recentes', style: TextStyle(
                color: CoresSpotify.branco,
                fontWeight: FontWeight.bold, fontSize: 22,
              )),
              Text('Mostrar tudo',
                style: TextStyle(color: CoresSpotify.cinza, fontSize: 13)),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: Observer(
            builder: (_) => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: store.recentes.length,
              itemBuilder: (_, i) {
                final item = store.recentes[i];
                final ehArtista = item.tipo == 'artista';
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ehArtista
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: CoresSpotify.fundoCard,
                              child: Icon(Icons.person,
                                color: CoresSpotify.cinza, size: 40),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                width: 120, height: 120,
                                color: CoresSpotify.fundoCard,
                                child: const Icon(Icons.music_note,
                                  color: CoresSpotify.cinza, size: 40),
                              ),
                            ),
                      const SizedBox(height: 6),
                      Text(item.nome, style: const TextStyle(
                        color: CoresSpotify.branco,
                        fontWeight: FontWeight.bold, fontSize: 13,
                      ), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(item.subtitulo, style: const TextStyle(
                        color: CoresSpotify.cinza, fontSize: 11,
                      )),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
