# Spotify Clone — Flutter

Clone funcional do Spotify desenvolvido em Flutter com interface dark, navegação entre telas, gerenciamento reativo de estado e persistência local.

---

## Funcionalidades

- **Tela Início** — grid de atalhos, seções horizontais (estações recomendadas, mixes, recentes) e filtros (Tudo, Música, Podcasts)
- **Tela Buscar** — cards de videoclipes e episódios com navegação para o player de vídeo
- **Tela Biblioteca** — listagem de playlists/podcasts com filtros (Playlists, Podcasts, Álbuns, Artistas, Baixado), criação e exclusão de playlists
- **Tela Músicas Curtidas** — lista reativa das músicas marcadas com coração
- **Detalhe de Playlist** — faixas associadas à playlist com reprodução ao tocar
- **Player de Vídeo** — tela no estilo Spotify com vídeo, barra de progresso com seek, controles (anterior/play/pause/próximo), dispositivo conectado e painel de letra
- **Mini Player** — barra persistente em todas as telas (inclusive playlists) com nome da música, artista, curtir e play/pause; ao clicar abre o player de vídeo
- **Drawer de Perfil** — menu lateral com opções da conta
- **Modal Criar** — criação de playlist com nome e seleção de músicas

---

## Tecnologias

| Tecnologia | Uso |
|---|---|
| Flutter | Framework principal |
| Dart | Linguagem |
| MobX + flutter_mobx | Gerenciamento reativo de estado |
| mobx_codegen + build_runner | Geração dos arquivos `.g.dart` |
| video_player | Reprodução de vídeo no player |
| shared_preferences | Persistência local de curtidas e biblioteca |

---

## Arquitetura

```
lib/
├── main.dart                        # Ponto de entrada e roteamento nomeado
├── rotas.dart                       # Constantes de rota (/curtidas, /playlist, /video)
├── servico/
│   ├── entidade/
│   │   ├── musica.dart              # Modelo Musica (id, titulo, artista, videoUrl, progresso)
│   │   └── playlist.dart            # Modelo Playlist com toJson/fromJson/copyWith
│   └── persistencia.dart            # Leitura e gravação via shared_preferences
├── store/
│   ├── home_store.dart              # Estado da home: músicas, curtidas, filtro, player
│   ├── home_store.g.dart            # Gerado pelo MobX codegen
│   ├── biblioteca_store.dart        # Estado da biblioteca: itens, filtros, CRUD de playlists
│   └── biblioteca_store.g.dart      # Gerado pelo MobX codegen
└── apresentacao/
    ├── tela_base.dart               # Scaffold raiz com bottom nav e mini player
    ├── tela_home.dart               # Tela Início
    ├── tela_buscar.dart             # Tela Buscar
    ├── tela_biblioteca.dart         # Tela Sua Biblioteca
    ├── tela_curtidas.dart           # Tela Músicas Curtidas
    ├── tela_playlist_detalhe.dart   # Detalhe de uma playlist
    ├── tela_video_player.dart       # Player de vídeo estilo Spotify
    ├── tela_drawer.dart             # Menu lateral de perfil
    └── widgets/
        ├── mini_player.dart         # Barra de player persistente
        ├── modal_criar.dart         # Modal de criação de playlist
        └── cores_spotify.dart       # Paleta de cores do app
```

---

## Rotas nomeadas

| Rota | Argumento | Descrição |
|---|---|---|
| `/curtidas` | `HomeStore` | Tela de músicas curtidas |
| `/playlist` | `Map {'playlist': Playlist, 'store': HomeStore}` | Detalhe de playlist |
| `/video` | `Map {'videoUrl', 'titulo', 'artista', 'playlistNome'}` | Player de vídeo |

---

## Como executar

```bash
flutter pub get
flutter run
```

Para regenerar os arquivos MobX após alterar as stores:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Desenvolvido por

Ariane Prado
