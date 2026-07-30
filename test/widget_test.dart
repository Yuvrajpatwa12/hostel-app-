import 'package:flutter_test/flutter_test.dart';

import 'package:kathmadnuhostel/main.dart'; // Apka main file import

void main() {
  testWidgets('HostelMate app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that Splash Screen starts and shows app name 'HostelMate'
    expect(find.text('HostelMate'), findsOneWidget);
    expect(find.text('Your Ultimate Hostel Companion'), findsOneWidget);
  });
}