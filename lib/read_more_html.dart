library;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

/// A widget that displays HTML content with the ability to show/hide more text
/// when the content exceeds a given number of lines.
class ReadMoreHtml extends StatefulWidget {
  final String htmlText; // The HTML content to display.
  final int maxLines; // Maximum number of lines to display before truncating.
  final String
      moreText; // Text to display when content is truncated and the user clicks "More".
  final String
      lessText; // Text to display when content is expanded and the user clicks "Less".
  final Color linkColor; /// Color for the "More" and "Less" links.
  final TextStyle? textStyle; // Custom style for the text content.
  final Function(bool isExpanded)?
      onToggle; /// Callback when the state (expanded/collapsed) changes.

  const ReadMoreHtml({
    super.key,
    required this.htmlText,
    this.maxLines = 3,
    this.moreText = "More",
    this.lessText = "Less",
    this.linkColor = Colors.blue,
    this.textStyle,
    this.onToggle,
  });

  @override
  State<ReadMoreHtml> createState() => _ReadMoreHtmlState();
}

class _ReadMoreHtmlState extends State<ReadMoreHtml> {
  bool isExpanded = false; // Flag to determine whether the content is expanded.
  bool needsTruncation =
      false; // Flag to check if the content exceeds the maximum number of lines.
  String truncatedText = ""; // The truncated version of the content if needed.

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate truncation based on available width.
        _calculateTruncation(constraints.maxWidth);

        // Display the full content if expanded or if no truncation is needed,
        // otherwise show the truncated content.
        String displayText =
            isExpanded || !needsTruncation ? widget.htmlText : truncatedText;

        // Show "More" or "Less" link depending on whether the content is expanded.
        String toggleText = needsTruncation
            ? (isExpanded
                ? " <a href='toggle'>${widget.lessText}</a>"
                : " <a href='toggle'>${widget.moreText}</a>")
            : "";

        return Html(
          data:
              "$displayText$toggleText", // Combine the HTML content with the "More"/"Less" link.
          style: {
            "body": Style(
              fontSize: FontSize.medium,
              fontFamily: widget.textStyle?.fontFamily,
              color: widget.textStyle?.color ?? Colors.black,
            ),
            "a": Style(
              color: widget.linkColor,
              fontWeight: FontWeight.bold,
              textDecoration: TextDecoration.none,
            ),
          },
          // Handle the toggle functionality when the "More" or "Less" link is clicked.
          onLinkTap: (url, context, _, ) {
            if (url == "toggle") {
              setState(() {
                isExpanded = !isExpanded; // Toggle the expanded state.
                widget.onToggle
                    ?.call(isExpanded); // Call the callback with the new state.
              });
            }
          },
        );
      },
    );
  }

  // Calculates if truncation is needed based on the available width.
  void _calculateTruncation(double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(
          text: widget.htmlText,
          style: widget.textStyle ?? const TextStyle(fontSize: 16)),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    // If the content exceeds the max lines, truncation is required.
    if (textPainter.didExceedMaxLines) {
      needsTruncation = true;
      truncatedText = _truncateText(widget.htmlText,
          maxWidth); // Get the truncated version of the content.
    } else {
      needsTruncation = false; // No truncation is needed.
    }
  }

  /// Truncates the text until it fits within the max number of lines.
  String _truncateText(String text, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(style: widget.textStyle ?? const TextStyle(fontSize: 16)),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    String truncated = text;
    // Gradually reduce the text length by one character until it fits within the max lines.
    while (truncated.isNotEmpty) {
      textPainter.text =
          TextSpan(text: "$truncated...", style: widget.textStyle);
      textPainter.layout(maxWidth: maxWidth);
      if (!textPainter.didExceedMaxLines) break;
      truncated = truncated.substring(0, truncated.length - 1);
    }
    return "$truncated..."; // Return the truncated text with ellipsis.
  }
}
