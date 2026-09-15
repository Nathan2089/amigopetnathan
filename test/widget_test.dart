import 'package:flutter_test/flutter_test.dart';
import 'package:amigopetnathan/main.dart';

void main() {
  testWidgets('AmigoPet smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AmigoPetApp());

    // Verifica se a tela inicial carrega o título esperado do AmigoPet
    expect(find.text('AmigoPet — Cuidadores'), findsOneWidget);
  });
}
