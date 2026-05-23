import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/biblioteca_store.dart';
import '../store/home_store.dart';
import '../servico/entidade/playlist.dart';
import 'tela_curtidas.dart';
import 'widgets/cores_spotify.dart';
import 'widgets/modal_criar.dart';

class TelaBiblioteca extends StatelessWidget {
  final BibliotecaStore store;
  final HomeStore homeStore;
  const TelaBiblioteca({required this.store, required this.homeStore, super.key});

  @override
  Widget build(BuildContext context) {
    final filtros = ['Playlists', 'Podcasts', 'Álbuns', 'Artistas', 'Baixado'];

    return Scaffold(
      backgroundColor: CoresSpotify.fundo,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: CoresSpotify.verde,
                    child: Text('A', style: TextStyle(
                      color: CoresSpotify.branco,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(width: 12),
                  const Text('Sua Biblioteca', style: TextStyle(
                    color: CoresSpotify.branco,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  )),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search, color: CoresSpotify.branco),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: CoresSpotify.branco),
                    onPressed: () => _abrirModalCriar(context),
                  ),
                ],
              ),
            ),
            Observer(
              builder: (_) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: filtros.map((filtro) {
                    final ativo = store.filtroAtivo == filtro;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => store.alterarFiltro(filtro),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ativo
                                ? CoresSpotify.branco
                                : CoresSpotify.fundoChip,
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
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(children: [
                    Icon(Icons.swap_vert, color: CoresSpotify.branco, size: 20),
                    SizedBox(width: 4),
                    Text('Recentes', style: TextStyle(color: CoresSpotify.branco, fontSize: 13)),
                  ]),
                  Icon(Icons.grid_view, color: CoresSpotify.branco, size: 20),
                ],
              ),
            ),
            Expanded(
              child: Observer(
                builder: (_) => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: store.itensFiltrados.length,
                  itemBuilder: (_, index) {
                    final item = store.itensFiltrados[index];
                    return _itemBiblioteca(context, item);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBiblioteca(BuildContext context, Playlist item) {
    final ehArtista = item.tipo == 'artista';

    return GestureDetector(
      onTap: () {
        if (item.id == 'b1') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TelaCurtidas(store: homeStore),
            ),
          );
        }
      },
      onLongPress: () => _mostrarOpcoes(context, item),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            ehArtista
                ? const CircleAvatar(
                    radius: 28,
                    backgroundColor: CoresSpotify.fundoCard,
                    child: Icon(Icons.person, color: CoresSpotify.cinza),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: 56, height: 56,
                      color: CoresSpotify.fundoCard,
                      child: const Icon(Icons.music_note, color: CoresSpotify.cinza),
                    ),
                  ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nome,
                    style: const TextStyle(
                      color: CoresSpotify.branco,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(children: [
                    if (item.fixada)
                      const Icon(Icons.push_pin, color: CoresSpotify.verde, size: 12),
                    if (item.baixada)
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.download_done, color: CoresSpotify.verde, size: 12),
                      ),
                    const SizedBox(width: 4),
                    Text(
                      item.subtitulo,
                      style: const TextStyle(color: CoresSpotify.cinza, fontSize: 12),
                    ),
                  ]),
                ],
              ),
            ),
            Observer(
              builder: (_) => IconButton(
                icon: Icon(
                  item.curtida ? Icons.favorite : Icons.favorite_border,
                  color: item.curtida ? CoresSpotify.verde : CoresSpotify.cinza,
                  size: 20,
                ),
                onPressed: () => store.toggleCurtirPlaylist(item.id),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarOpcoes(BuildContext context, Playlist item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CoresSpotify.fundoModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.favorite_border, color: CoresSpotify.branco),
            title: Text(
              item.curtida ? 'Descurtir playlist' : 'Curtir playlist',
              style: const TextStyle(color: CoresSpotify.branco),
            ),
            onTap: () {
              store.toggleCurtirPlaylist(item.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
            title: const Text('Deletar playlist',
              style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Navigator.pop(context);
              _confirmarDelecao(context, item);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _confirmarDelecao(BuildContext context, Playlist item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: CoresSpotify.fundoModal,
        title: const Text('Deletar playlist',
          style: TextStyle(color: CoresSpotify.branco)),
        content: Text(
          'Tem certeza que quer deletar "${item.nome}"?',
          style: const TextStyle(color: CoresSpotify.cinza),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar',
              style: TextStyle(color: CoresSpotify.cinza)),
          ),
          ElevatedButton(
            onPressed: () {
              store.deletarPlaylist(item.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Playlist deletada'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  void _abrirModalCriar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ModalCriar(store: store),
      ),
    );
  }
}
