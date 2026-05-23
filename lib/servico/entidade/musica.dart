class Musica {
  final String id;
  final String titulo;
  final String artista;
  final String imagemUrl;
  final String videoUrl;
  double progresso;

  Musica({
    required this.id,
    required this.titulo,
    required this.artista,
    required this.imagemUrl,
    this.videoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    this.progresso = 0.0,
  });
}
