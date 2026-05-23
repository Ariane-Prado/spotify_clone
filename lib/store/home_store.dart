import 'package:mobx/mobx.dart';
import '../servico/entidade/playlist.dart';
import '../servico/entidade/musica.dart';
import '../servico/persistencia.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {

  @observable
  String filtroAtivo = 'Tudo';

  @observable
  bool tocando = false;

  @observable
  ObservableList<Playlist> atalhos = ObservableList<Playlist>.of([
    Playlist(id: 'a1', nome: 'Músicas Curtidas', imagemUrl: '', tipo: 'playlist', musicaIds: ['ms1','ms2','ms3']),
    Playlist(id: 'a2', nome: 'DJ',               imagemUrl: '', tipo: 'playlist', musicaIds: ['ms4','ms5']),
    Playlist(id: 'a3', nome: 'obra aberta',       imagemUrl: '', tipo: 'podcast'),
    Playlist(id: 'a4', nome: 'Mix de Rock',       imagemUrl: '', tipo: 'playlist', musicaIds: ['ms4','ms1']),
    Playlist(id: 'a5', nome: 'Daily Mix 1',       imagemUrl: '', tipo: 'playlist', musicaIds: ['ms2','ms3']),
    Playlist(id: 'a6', nome: 'Top Brasil',        imagemUrl: '', tipo: 'playlist', musicaIds: ['ms5']),
    Playlist(id: 'a7', nome: 'Podcast Dev',       imagemUrl: '', tipo: 'podcast'),
    Playlist(id: 'a8', nome: 'Recentes',          imagemUrl: '', tipo: 'playlist'),
  ]);

  // 3 músicas pré-curtidas para testar imediatamente
  @observable
  ObservableSet<String> musicasCurtidas = ObservableSet<String>.of([
    'ms1', 'ms2', 'ms3',
  ]);

  @observable
  Musica? musicaAtual = Musica(
    id: 'ms1',
    titulo: 'Minha Cabeça',
    artista: 'Clarice Falcão',
    imagemUrl: '',
    progresso: 0.35,
  );

  @observable
  ObservableList<Musica> musicas = ObservableList<Musica>.of([
    Musica(id: 'ms1', titulo: 'Minha Cabeça',  artista: 'Clarice Falcão', imagemUrl: '', progresso: 0.35),
    Musica(id: 'ms2', titulo: 'Flutua',        artista: 'Clarice Falcão', imagemUrl: ''),
    Musica(id: 'ms3', titulo: 'Te Ligo',       artista: 'Clarice Falcão', imagemUrl: ''),
    Musica(id: 'ms4', titulo: 'Trevo (Tu)',    artista: 'AnaVitória',     imagemUrl: ''),
    Musica(id: 'ms5', titulo: 'De Você',       artista: 'AnaVitória',     imagemUrl: ''),
  ]);

  @observable
  ObservableList<Playlist> estacoesRecomendadas = ObservableList<Playlist>.of([
    Playlist(id: 'e1', nome: 'Rádio Moptop',     imagemUrl: '', subtitulo: 'Vivendo do Ócio, Moptop...', musicaIds: ['ms1','ms4']),
    Playlist(id: 'e2', nome: 'Rodrigo Alarcon',  imagemUrl: '', subtitulo: 'Rock Nacional...', musicaIds: ['ms4']),
    Playlist(id: 'e3', nome: 'Rádio Pop Brasil', imagemUrl: '', subtitulo: 'Hits do momento...', musicaIds: ['ms3','ms5']),
  ]);

  @observable
  ObservableList<Playlist> mixes = ObservableList<Playlist>.of([
    Playlist(id: 'm1', nome: 'Mix de NandaTsunami', imagemUrl: '', subtitulo: 'AJULLIACOSTA, Afreekassia...', musicaIds: ['ms2','ms3']),
    Playlist(id: 'm2', nome: 'Mix rock',            imagemUrl: '', subtitulo: 'Slipknot, Evanescence...', musicaIds: ['ms4']),
    Playlist(id: 'm3', nome: 'Mix Eletrônico',      imagemUrl: '', subtitulo: 'Daft Punk, The Weeknd...', musicaIds: ['ms5']),
  ]);

  @observable
  ObservableList<Playlist> recentes = ObservableList<Playlist>.of([
    Playlist(id: 'r1', nome: 'Tem Conserto', imagemUrl: '', tipo: 'album',    subtitulo: 'Álbum • Clarice', musicaIds: ['ms1','ms3']),
    Playlist(id: 'r2', nome: 'Daisy Jones',  imagemUrl: '', tipo: 'artista',  subtitulo: 'Artista', musicaIds: ['ms2']),
    Playlist(id: 'r3', nome: 'Daily Mix 1',  imagemUrl: '', tipo: 'playlist', subtitulo: 'Playlist', musicaIds: ['ms2','ms5']),
    Playlist(id: 'r4', nome: 'Top Hits',     imagemUrl: '', tipo: 'playlist', subtitulo: 'Playlist', musicaIds: ['ms3','ms4']),
  ]);

  @computed
  List<Musica> get musicasCurtidasLista =>
      musicas.where((m) => musicasCurtidas.contains(m.id)).toList();

  @action
  void alterarFiltro(String filtro) {
    filtroAtivo = filtro;
  }

  @action
  void toggleTocando() {
    tocando = !tocando;
  }

  @action
  void tocarMusica(Musica musica) {
    musicaAtual = musica;
    tocando = true;
  }

  @action
  void toggleCurtir(String musicaId) {
    if (musicasCurtidas.contains(musicaId)) {
      musicasCurtidas.remove(musicaId);
    } else {
      musicasCurtidas.add(musicaId);
    }
    Persistencia.salvarMusicasCurtidas(musicasCurtidas.toSet());
  }

  bool estaCurtida(String musicaId) {
    return musicasCurtidas.contains(musicaId);
  }

  Future<void> carregarDados() async {
    final curtidas = await Persistencia.carregarMusicasCurtidas();
    if (curtidas != null) {
      runInAction(() {
        musicasCurtidas = ObservableSet<String>.of(curtidas);
      });
    }
  }

}
