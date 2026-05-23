import 'package:flutter/material.dart';
import 'widgets/cores_spotify.dart';

class TelaDrawer extends StatelessWidget {
  const TelaDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final opcoes = [
      {'icone': Icons.add,                   'titulo': 'Adicionar conta',             'badge': null},
      {'icone': Icons.workspace_premium,      'titulo': 'Seu Premium',                 'badge': 'Universitário'},
      {'icone': Icons.analytics,              'titulo': 'Sua Cápsula sonora',          'badge': null},
      {'icone': Icons.history,                'titulo': 'Recentes',                    'badge': null},
      {'icone': Icons.notification_important, 'titulo': 'Suas atualizações',           'badge': null},
      {'icone': Icons.settings,               'titulo': 'Configurações e privacidade', 'badge': null},
    ];

    return Drawer(
      backgroundColor: CoresSpotify.fundoDrawer,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: CoresSpotify.verde,
                  child: Text('A', style: TextStyle(
                    color: CoresSpotify.branco,
                    fontWeight: FontWeight.bold, fontSize: 24,
                  )),
                ),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Ariane Prado', style: TextStyle(
                    color: CoresSpotify.branco,
                    fontWeight: FontWeight.bold, fontSize: 18,
                  )),
                  Text('Ver perfil', style: TextStyle(
                    color: CoresSpotify.cinza, fontSize: 13,
                  )),
                ]),
              ]),
              const SizedBox(height: 24),
              ...opcoes.map((op) => _itemMenu(op)),
              const SizedBox(height: 24),
              Row(children: [
                _botaoCircular(Icons.people, 'Atividade', 'Habilitar'),
                const SizedBox(width: 24),
                _botaoCircular(Icons.add, 'Convidar amigos', ''),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMenu(Map<String, dynamic> op) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Icon(op['icone'] as IconData, color: CoresSpotify.branco, size: 22),
        const SizedBox(width: 16),
        Expanded(child: Text(op['titulo'] as String,
          style: const TextStyle(color: CoresSpotify.branco, fontSize: 15))),
        if (op['badge'] != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8D5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(op['badge'] as String, style: const TextStyle(
              color: Color(0xFF6B2FBA), fontSize: 11, fontWeight: FontWeight.bold,
            )),
          ),
      ]),
    );
  }

  Widget _botaoCircular(IconData icone, String titulo, String subtitulo) {
    return Column(children: [
      CircleAvatar(
        radius: 28,
        backgroundColor: CoresSpotify.fundoChip,
        child: Icon(icone, color: CoresSpotify.branco),
      ),
      const SizedBox(height: 6),
      Text(titulo, style: const TextStyle(color: CoresSpotify.branco, fontSize: 12)),
      if (subtitulo.isNotEmpty)
        Text(subtitulo, style: const TextStyle(color: CoresSpotify.cinza, fontSize: 11)),
    ]);
  }
}
