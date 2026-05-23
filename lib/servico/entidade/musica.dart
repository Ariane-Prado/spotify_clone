class Musica {
  final String id;
  final String titulo;
  final String artista;
  final String imagemUrl;
  double progresso;

  Musica({
    required this.id,
    required this.titulo,
    required this.artista,
    required this.imagemUrl,
    this.progresso = 0.0,
  });
}
