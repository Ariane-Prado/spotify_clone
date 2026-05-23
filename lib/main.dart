import 'package:flutter/material.dart';
import 'apresentacao/tela_base.dart';
import 'store/home_store.dart';
import 'apresentacao/tela_curtidas.dart';
import 'apresentacao/tela_playlist_detalhe.dart';
import 'apresentacao/tela_video_player.dart';
import 'rotas.dart';

void main() => runApp(const SpotifyCloneApp());

class SpotifyCloneApp extends StatelessWidget {
  const SpotifyCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      home: const TelaBase(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case routeCurtidas:
            final args = settings.arguments as HomeStore?;
            if (args != null) {
              return MaterialPageRoute(
                builder: (_) => TelaCurtidas(store: args),
                settings: settings,
              );
            }
            return null;

          case routePlaylist:
            final args = settings.arguments as Map?;
            final playlist = args?['playlist'];
            final store = args?['store'];
            return MaterialPageRoute(
              builder: (_) => TelaPlaylistDetalhe(playlist: playlist, homeStore: store),
              settings: settings,
            );

          case routeVideo:
            final args = settings.arguments as Map?;
            return MaterialPageRoute(
              builder: (_) => TelaVideoPlayer(
                videoUrl:      args?['videoUrl']      as String? ?? '',
                titulo:        args?['titulo']        as String? ?? '',
                artista:       args?['artista']       as String? ?? '',
                playlistNome:  args?['playlistNome']  as String? ?? '',
              ),
              settings: settings,
            );

          default:
            return null;
        }
      },
    );
  }
}
