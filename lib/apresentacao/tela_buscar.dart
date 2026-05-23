import 'package:flutter/material.dart';
import '../rotas.dart';
import 'widgets/cores_spotify.dart';

class TelaBuscar extends StatelessWidget {
  const TelaBuscar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoresSpotify.fundo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Buscar', style: TextStyle(
                    color: CoresSpotify.branco,
                    fontWeight: FontWeight.bold, fontSize: 24,
                  )),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: CoresSpotify.branco),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('O que você quer ouvir?',
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Explore videoclipes', style: TextStyle(
                color: CoresSpotify.branco,
                fontWeight: FontWeight.bold, fontSize: 22,
              )),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, i) => _cardVertical(
                    context,
                    'Vídeo ${i + 1}',
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Descubra episódios pra você', style: TextStyle(
                color: CoresSpotify.branco,
                fontWeight: FontWeight.bold, fontSize: 22,
              )),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, i) => _cardVertical(
                    context,
                    'Episódio ${i + 1}',
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardVertical(BuildContext context, String titulo, String videoUrl) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeVideo, arguments: {
        'videoUrl':     videoUrl,
        'titulo':       titulo,
        'artista':      '',
        'playlistNome': 'Explore videoclipes',
      }),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 140, height: 210,
                color: CoresSpotify.fundoCard,
                child: const Icon(Icons.play_circle, color: CoresSpotify.cinza, size: 40),
              ),
            ),
            Positioned(
              bottom: 12, left: 12, right: 12,
              child: Text(
                titulo,
                style: const TextStyle(
                  color: CoresSpotify.branco,
                  fontWeight: FontWeight.bold, fontSize: 14,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
