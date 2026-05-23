import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Persistencia {
  static const _keyMusicasCurtidas = 'musicas_curtidas';
  static const _keyBibliotecaItens = 'biblioteca_itens';

  // ---------- Músicas curtidas ----------

  /// Retorna null se nunca foi salvo (usa os defaults da store).
  static Future<Set<String>?> carregarMusicasCurtidas() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList(_keyMusicasCurtidas);
    return lista?.toSet();
  }

  static Future<void> salvarMusicasCurtidas(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyMusicasCurtidas, ids.toList());
  }

  // ---------- Itens da biblioteca ----------

  /// Retorna null se nunca foi salvo (usa os defaults da store).
  static Future<List<Map<String, dynamic>>?> carregarBibliotecaItens() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyBibliotecaItens);
    if (json == null) return null;
    final lista = jsonDecode(json) as List;
    return lista.cast<Map<String, dynamic>>();
  }

  static Future<void> salvarBibliotecaItens(
      List<Map<String, dynamic>> itens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyBibliotecaItens, jsonEncode(itens));
  }
}
