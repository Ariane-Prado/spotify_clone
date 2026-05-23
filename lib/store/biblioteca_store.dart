import 'package:mobx/mobx.dart';
import '../servico/entidade/playlist.dart';
import '../servico/persistencia.dart';

part 'biblioteca_store.g.dart';

class BibliotecaStore = BibliotecaStoreBase with _$BibliotecaStore;

abstract class BibliotecaStoreBase with Store {

  @observable
  String filtroAtivo = 'Playlists';

  @observable
  ObservableList<Playlist> itens = ObservableList<Playlist>.of([
    Playlist(
      id: 'b1',
      nome: 'Músicas curtidas',
      imagemUrl: '',
      tipo: 'playlist',
      subtitulo: 'Playlist • Ariane Prado',
      fixada: true,
      baixada: true,
      musicaIds: ['ms1','ms2','ms3'],
    ),
    Playlist(
      id: 'b2',
      nome: 'Seus episódios',
      imagemUrl: '',
      tipo: 'podcast',
      subtitulo: 'Podcast',
    ),
    Playlist(
      id: 'b3',
      nome: 'DJ',
      imagemUrl: '',
      tipo: 'playlist',
      subtitulo: 'Playlist',
      baixada: true,
      musicaIds: ['ms4','ms5'],
    ),
    Playlist(
      id: 'b4',
      nome: 'puro rock de pai divorciado',
      imagemUrl: '',
      tipo: 'playlist',
      subtitulo: 'Playlist • Nick',
      musicaIds: ['ms4'],
    ),
  ]);

  @computed
  List<Playlist> get itensFiltrados {
    if (filtroAtivo == 'Playlists') {
      return itens.where((i) => i.tipo == 'playlist').toList();
    } else if (filtroAtivo == 'Podcasts') {
      return itens.where((i) => i.tipo == 'podcast').toList();
    } else if (filtroAtivo == 'Álbuns') {
      return itens.where((i) => i.tipo == 'album').toList();
    } else if (filtroAtivo == 'Artistas') {
      return itens.where((i) => i.tipo == 'artista').toList();
    } else if (filtroAtivo == 'Baixado') {
      return itens.where((i) => i.baixada).toList();
    }
    return itens.toList();
  }

  @action
  void alterarFiltro(String filtro) {
    filtroAtivo = filtro;
  }

  @action
  void adicionarPlaylist(String nome, {List<String>? musicaIds}) {
    final novaPlaylist = Playlist(
      id: 'playlist_${DateTime.now().millisecondsSinceEpoch}',
      nome: nome,
      imagemUrl: '',
      tipo: 'playlist',
      subtitulo: 'Playlist • Você',
      musicaIds: musicaIds ?? const [],
    );
    itens.add(novaPlaylist);
    _salvar();
  }

  @action
  void deletarPlaylist(String id) {
    itens.removeWhere((item) => item.id == id);
    _salvar();
  }

  @action
  void toggleCurtirPlaylist(String id) {
    final index = itens.indexWhere((item) => item.id == id);
    if (index >= 0) {
      itens[index] = itens[index].copyWith(curtida: !itens[index].curtida);
      _salvar();
    }
  }

  void _salvar() {
    Persistencia.salvarBibliotecaItens(
      itens.map((p) => p.toJson()).toList(),
    );
  }

  Future<void> carregarDados() async {
    final dados = await Persistencia.carregarBibliotecaItens();
    if (dados != null) {
      runInAction(() {
        itens = ObservableList<Playlist>.of(
          dados.map(Playlist.fromJson),
        );
      });
    } else {
      // salva itens iniciais na persistência para primeira execução
      _salvar();
    }
  }
}
