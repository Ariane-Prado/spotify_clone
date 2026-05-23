// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biblioteca_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BibliotecaStore on BibliotecaStoreBase, Store {
  Computed<List<Playlist>>? _$itensFiltradosComputed;

  @override
  List<Playlist> get itensFiltrados => (_$itensFiltradosComputed ??=
          Computed<List<Playlist>>(() => super.itensFiltrados,
              name: 'BibliotecaStoreBase.itensFiltrados'))
      .value;

  late final _$filtroAtivoAtom =
      Atom(name: 'BibliotecaStoreBase.filtroAtivo', context: context);

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

  late final _$itensAtom =
      Atom(name: 'BibliotecaStoreBase.itens', context: context);

  @override
  ObservableList<Playlist> get itens {
    _$itensAtom.reportRead();
    return super.itens;
  }

  @override
  set itens(ObservableList<Playlist> value) {
    _$itensAtom.reportWrite(value, super.itens, () {
      super.itens = value;
    });
  }

  late final _$BibliotecaStoreBaseActionController =
      ActionController(name: 'BibliotecaStoreBase', context: context);

  @override
  void alterarFiltro(String filtro) {
    final _$actionInfo = _$BibliotecaStoreBaseActionController.startAction(
        name: 'BibliotecaStoreBase.alterarFiltro');
    try {
      return super.alterarFiltro(filtro);
    } finally {
      _$BibliotecaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void adicionarPlaylist(String nome) {
    final _$actionInfo = _$BibliotecaStoreBaseActionController.startAction(
        name: 'BibliotecaStoreBase.adicionarPlaylist');
    try {
      return super.adicionarPlaylist(nome);
    } finally {
      _$BibliotecaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deletarPlaylist(String id) {
    final _$actionInfo = _$BibliotecaStoreBaseActionController.startAction(
        name: 'BibliotecaStoreBase.deletarPlaylist');
    try {
      return super.deletarPlaylist(id);
    } finally {
      _$BibliotecaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCurtirPlaylist(String id) {
    final _$actionInfo = _$BibliotecaStoreBaseActionController.startAction(
        name: 'BibliotecaStoreBase.toggleCurtirPlaylist');
    try {
      return super.toggleCurtirPlaylist(id);
    } finally {
      _$BibliotecaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filtroAtivo: ${filtroAtivo},
itens: ${itens},
itensFiltrados: ${itensFiltrados}
    ''';
  }
}
