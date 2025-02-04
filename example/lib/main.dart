import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_more_html/read_more_html.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Read More HTML Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ReadMoreHtml(
            htmlText: """
            <h1>Welcome</h1>
            <p>This is a simple example of HTML content with a Read More functionality.</p>
            <p>The content is initially truncated and can be expanded by clicking on 'See more'.</p>
            <p>The content is initially truncated and can be expanded by clicking on 'See more'.</p>
            <p>The content content content content is initially truncated and can be expanded by clicking on 'See more'.</p>
            """,
            maxLines: 4,
            onToggle: (isExpanded) {
              if (kDebugMode) {
                print(isExpanded ? "Content expanded" : "Content collapsed");
              }
            },
          ),
        ),
      ),
    );
  }
}
