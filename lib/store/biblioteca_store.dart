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
    ),
    Playlist(
      id: 'b4',
      nome: 'puro rock de pai divorciado',
      imagemUrl: '',
      tipo: 'playlist',
      subtitulo: 'Playlist • Nick',
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
    }
    return itens.toList();
  }

  @action
  void alterarFiltro(String filtro) {
    filtroAtivo = filtro;
  }

  @action
  void adicionarPlaylist(String nome) {
    final novaPlaylist = Playlist(
      id: 'playlist_${DateTime.now().millisecondsSinceEpoch}',
      nome: nome,
      imagemUrl: '',
      tipo: 'playlist',
      subtitulo: 'Playlist • Você',
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
      itens[index].curtida = !itens[index].curtida;
      itens[index] = itens[index];
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
    }
  }
}
