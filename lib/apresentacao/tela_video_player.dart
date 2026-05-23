import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TelaVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String titulo;
  final String artista;
  final String playlistNome;

  const TelaVideoPlayer({
    required this.videoUrl,
    this.titulo = '',
    this.artista = '',
    this.playlistNome = '',
    super.key,
  });

  @override
  State<TelaVideoPlayer> createState() => _TelaVideoPlayerState();
}

class _TelaVideoPlayerState extends State<TelaVideoPlayer> {
  late VideoPlayerController _controller;
  bool _erro = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(_atualizar);
      }).catchError((_) {
        setState(() => _erro = true);
      });
  }

  void _atualizar() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_atualizar);
    _controller.dispose();
    super.dispose();
  }

  String _formatarDuracao(Duration d) {
    final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final sec = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    final duracao = _controller.value.duration;
    final posicao = _controller.value.position;
    final progresso = duracao.inMilliseconds > 0
        ? (posicao.inMilliseconds / duracao.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (widget.playlistNome.isNotEmpty) ...[
                          const Text(
                            'TOCANDO DA PLAYLIST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                letterSpacing: 1.2),
                          ),
                          Text(
                            widget.playlistNome,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert,
                        color: Colors.white, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Vídeo / capa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    child: _erro
                        ? const Center(
                            child: Icon(Icons.music_note,
                                color: Colors.white24, size: 72))
                        : _controller.value.isInitialized
                            ? VideoPlayer(_controller)
                            : const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Título + botão adicionar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.titulo.isNotEmpty ? widget.titulo : 'Sem título',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.artista,
                          style: const TextStyle(
                              color: Colors.white60, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Barra de progresso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 14),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      overlayColor: Colors.white24,
                    ),
                    child: Slider(
                      value: progresso,
                      onChanged: (v) {
                        if (_controller.value.isInitialized) {
                          _controller.seekTo(duracao * v);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatarDuracao(posicao),
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 12)),
                        Text(_formatarDuracao(duracao),
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Controles: anterior, play/pause, próximo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.skip_previous, color: Colors.white),
                    onPressed: () {
                      if (_controller.value.isInitialized) {
                        _controller.seekTo(Duration.zero);
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                        size: 36,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.skip_next, color: Colors.white),
                    onPressed: () {
                      if (_controller.value.isInitialized) {
                        _controller.seekTo(duracao);
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dispositivo + compartilhar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Icon(Icons.headphones,
                      color: Color(0xFF1DB954), size: 18),
                  const SizedBox(width: 8),
                  const Text('JBL TUNE - Aris',
                      style: TextStyle(
                          color: Color(0xFF1DB954),
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.share_outlined,
                        color: Colors.white, size: 22),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Painel Letra
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Letra',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Row(
                    children: const [
                      Icon(Icons.share_outlined,
                          color: Colors.white54, size: 20),
                      SizedBox(width: 16),
                      Icon(Icons.open_in_full,
                          color: Colors.white54, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
