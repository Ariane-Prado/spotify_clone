// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<bool>? _$temMusicasCurtidasComputed;

  @override
  bool get temMusicasCurtidas => (_$temMusicasCurtidasComputed ??=
          Computed<bool>(() => super.temMusicasCurtidas,
              name: 'HomeStoreBase.temMusicasCurtidas'))
      .value;
  Computed<List<Musica>>? _$musicasCurtidasListaComputed;

  @override
  List<Musica> get musicasCurtidasLista => (_$musicasCurtidasListaComputed ??=
          Computed<List<Musica>>(() => super.musicasCurtidasLista,
              name: 'HomeStoreBase.musicasCurtidasLista'))
      .value;

  late final _$filtroAtivoAtom =
      Atom(name: 'HomeStoreBase.filtroAtivo', context: context);

  @override
  String get filtroAtivo {
    _$filtroAtivoAtom.reportRead();
    return super.filtroAtivo;
  }

  @override
  set filtroAtivo(String value) {
    _$filtroAtivoAtom.reportWrite(value, super.filtroAtivo, () {
      super.filtroAtivo = value;
    });
  }

  late final _$tocandoAtom =
      Atom(name: 'HomeStoreBase.tocando', context: context);

  @override
  bool get tocando {
    _$tocandoAtom.reportRead();
    return super.tocando;
  }

  @override
  set tocando(bool value) {
    _$tocandoAtom.reportWrite(value, super.tocando, () {
      super.tocando = value;
    });
  }

  late final _$atalhosAtom =
      Atom(name: 'HomeStoreBase.atalhos', context: context);

  @override
  ObservableList<Playlist> get atalhos {
    _$atalhosAtom.reportRead();
    return super.atalhos;
  }

  @override
  set atalhos(ObservableList<Playlist> value) {
    _$atalhosAtom.reportWrite(value, super.atalhos, () {
      super.atalhos = value;
    });
  }

  late final _$musicasCurtidasAtom =
      Atom(name: 'HomeStoreBase.musicasCurtidas', context: context);

  @override
  ObservableSet<String> get musicasCurtidas {
    _$musicasCurtidasAtom.reportRead();
    return super.musicasCurtidas;
  }

  @override
  set musicasCurtidas(ObservableSet<String> value) {
    _$musicasCurtidasAtom.reportWrite(value, super.musicasCurtidas, () {
      super.musicasCurtidas = value;
    });
  }

  late final _$musicaAtualAtom =
      Atom(name: 'HomeStoreBase.musicaAtual', context: context);

  @override
  Musica? get musicaAtual {
    _$musicaAtualAtom.reportRead();
    return super.musicaAtual;
  }

  @override
  set musicaAtual(Musica? value) {
    _$musicaAtualAtom.reportWrite(value, super.musicaAtual, () {
      super.musicaAtual = value;
    });
  }

  late final _$musicasAtom =
      Atom(name: 'HomeStoreBase.musicas', context: context);

  @override
  ObservableList<Musica> get musicas {
    _$musicasAtom.reportRead();
    return super.musicas;
  }

  @override
  set musicas(ObservableList<Musica> value) {
    _$musicasAtom.reportWrite(value, super.musicas, () {
      super.musicas = value;
    });
  }

  late final _$estacoesRecomendadasAtom =
      Atom(name: 'HomeStoreBase.estacoesRecomendadas', context: context);

  @override
  ObservableList<Playlist> get estacoesRecomendadas {
    _$estacoesRecomendadasAtom.reportRead();
    return super.estacoesRecomendadas;
  }

  @override
  set estacoesRecomendadas(ObservableList<Playlist> value) {
    _$estacoesRecomendadasAtom.reportWrite(value, super.estacoesRecomendadas,
        () {
      super.estacoesRecomendadas = value;
    });
  }

  late final _$mixesAtom = Atom(name: 'HomeStoreBase.mixes', context: context);

  @override
  ObservableList<Playlist> get mixes {
    _$mixesAtom.reportRead();
    return super.mixes;
  }

  @override
  set mixes(ObservableList<Playlist> value) {
    _$mixesAtom.reportWrite(value, super.mixes, () {
      super.mixes = value;
    });
  }

  late final _$recentesAtom =
      Atom(name: 'HomeStoreBase.recentes', context: context);

  @override
  ObservableList<Playlist> get recentes {
    _$recentesAtom.reportRead();
    return super.recentes;
  }

  @override
  set recentes(ObservableList<Playlist> value) {
    _$recentesAtom.reportWrite(value, super.recentes, () {
      super.recentes = value;
    });
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void alterarFiltro(String filtro) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.alterarFiltro');
    try {
      return super.alterarFiltro(filtro);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTocando() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.toggleTocando');
    try {
      return super.toggleTocando();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tocarMusica(Musica musica) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.tocarMusica');
    try {
      return super.tocarMusica(musica);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCurtir(String musicaId) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.toggleCurtir');
    try {
      return super.toggleCurtir(musicaId);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void alterarMusica(Musica musica) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.alterarMusica');
    try {
      return super.alterarMusica(musica);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filtroAtivo: ${filtroAtivo},
tocando: ${tocando},
atalhos: ${atalhos},
musicasCurtidas: ${musicasCurtidas},
musicaAtual: ${musicaAtual},
musicas: ${musicas},
estacoesRecomendadas: ${estacoesRecomendadas},
mixes: ${mixes},
recentes: ${recentes},
temMusicasCurtidas: ${temMusicasCurtidas},
musicasCurtidasLista: ${musicasCurtidasLista}
    ''';
  }
}
