import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_more_html/read_more_html.dart';

void main() {
  testWidgets('ReadMoreHtml widget displays the truncated text and toggles correctly', (WidgetTester tester) async {
    // Test data
    const String longHtmlText = "<p>This is a very long HTML content that will be truncated when it exceeds the maximum number of lines.</p>";
    const int maxLines = 2;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReadMoreHtml(
            htmlText: longHtmlText,
            maxLines: maxLines,
            moreText: 'Show more',
            lessText: 'Show less',
            linkColor: Colors.blue,
          ),
        ),
      ),
    );

    // Verify that the truncated version of the text is displayed
    expect(find.textContaining('Show more'), findsOneWidget);
    expect(find.textContaining('This is a very long HTML content that will'), findsOneWidget);

    // Tap the "Show more" link and verify that the content expands
    await tester.tap(find.text('Show more'));
    await tester.pump();

    // Verify that the full content is now displayed and "Show less" is shown
    expect(find.textContaining('This is a very long HTML content that will be truncated when it exceeds the maximum number of lines.'), findsOneWidget);
    expect(find.text('Show less'), findsOneWidget);

    // Tap the "Show less" link and verify that the content collapses
    await tester.tap(find.text('Show less'));
    await tester.pump();

    // Verify that the text is truncated again and "Show more" is shown
    expect(find.text('Show more'), findsOneWidget);
  });
}
