class Playlist {
  final String id;
  final String nome;
  final String imagemUrl;
  final String tipo;
  final String subtitulo;
  final bool fixada;
  final bool baixada;
  bool curtida;

  Playlist({
    required this.id,
    required this.nome,
    required this.imagemUrl,
    this.tipo = 'playlist',
    this.subtitulo = '',
    this.fixada = false,
    this.baixada = false,
    this.curtida = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'imagemUrl': imagemUrl,
    'tipo': tipo,
    'subtitulo': subtitulo,
    'fixada': fixada,
    'baixada': baixada,
    'curtida': curtida,
  };

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
    id: json['id'] as String,
    nome: json['nome'] as String,
    imagemUrl: json['imagemUrl'] as String,
    tipo: json['tipo'] as String? ?? 'playlist',
    subtitulo: json['subtitulo'] as String? ?? '',
    fixada: json['fixada'] as bool? ?? false,
    baixada: json['baixada'] as bool? ?? false,
    curtida: json['curtida'] as bool? ?? false,
  );
}
