import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/main.dart';

void main() {
  testWidgets('App inicia sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const SpotifyCloneApp());
    expect(find.byType(SpotifyCloneApp), findsOneWidget);
  });
}
