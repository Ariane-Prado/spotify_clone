# Spotify Clone Flutter

Clone do Spotify desenvolvido em Flutter, com interface escura e navegação básica por telas.

## Visão geral

Este projeto representa uma versão de demonstração do aplicativo Spotify, com telas de:
- Início com playlists, estações recomendadas e mixagens
- Buscar com cards de conteúdo
- Biblioteca com filtros, playlists e opções de gerenciamento
- Mini player e controle de músicas favoritas

A aplicação usa `MobX` para gerenciamento reativo e `shared_preferences` para persistência local.

## Tecnologias

- Flutter
- Dart
- MobX
- shared_preferences


## Estrutura principal

- `lib/main.dart` — ponto de entrada do app
- `lib/apresentacao/` — telas e widgets da interface
- `lib/store/` — stores MobX para estado de `home` e `biblioteca`
- `lib/servico/` — entidades de música, playlist e persistência
- `assets/images/` — recursos visuais usados no app

## Executar o projeto

No terminal, execute:

```bash
git clone <repo> # se ainda não tiver clonado
cd spotify
flutter pub get
flutter run
```

## Observações

- `pubspec.lock` deve ser versionado para apps Flutter.
- O projeto já inclui `MobX` com geração de código (`build_runner`).
