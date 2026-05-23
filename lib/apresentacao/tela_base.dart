import 'package:flutter/material.dart';
import '../store/home_store.dart';
import '../store/biblioteca_store.dart';
import 'tela_home.dart';
import 'tela_buscar.dart';
import 'tela_biblioteca.dart';
import 'widgets/mini_player.dart';
import 'widgets/cores_spotify.dart';
import 'widgets/modal_criar.dart';

class TelaBase extends StatefulWidget {
  const TelaBase({super.key});

  @override
  State<TelaBase> createState() => _TelaBaseState();
}

class _TelaBaseState extends State<TelaBase> {
  int _abaAtual = 0;

  final homeStore       = HomeStore();
  final bibliotecaStore = BibliotecaStore();

  @override
  void initState() {
    super.initState();
    homeStore.carregarDados();
    bibliotecaStore.carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    final telas = [
      TelaHome(store: homeStore),
      const TelaBuscar(),
      TelaBiblioteca(store: bibliotecaStore, homeStore: homeStore),
    ];

    return Scaffold(
      backgroundColor: CoresSpotify.fundo,
      body: _abaAtual < telas.length
          ? telas[_abaAtual]
          : telas[0],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MiniPlayer(store: homeStore),
          BottomNavigationBar(
            currentIndex: _abaAtual,
            onTap: (index) {
              if (index == 3) {
                _abrirModalCriar(context);
              } else {
                setState(() => _abaAtual = index);
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: CoresSpotify.fundo,
            selectedItemColor: CoresSpotify.branco,
            unselectedItemColor: CoresSpotify.cinza,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Buscar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                label: 'Sua Biblioteca',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Criar',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _abrirModalCriar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => ModalCriar(store: bibliotecaStore),
    );
  }
}
