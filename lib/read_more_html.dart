library;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class ReadMoreHtml extends StatefulWidget {
  final String htmlText;
  final int maxLines;
  final String moreText;
  final String lessText;
  final Color linkColor;
  final TextStyle? textStyle;
  final Function(bool isExpanded)? onToggle;

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
  bool isExpanded = false;
  bool needsTruncation = false;
  String truncatedText = "";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _calculateTruncation(constraints.maxWidth);

        String displayText = isExpanded || !needsTruncation ? widget.htmlText : truncatedText;
        String toggleText = needsTruncation
            ? (isExpanded
            ? " <a href='toggle'>${widget.lessText}</a>"
            : " <a href='toggle'>${widget.moreText}</a>")
            : "";

        return Html(
          data: "$displayText$toggleText",
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
          onLinkTap: (url, context, _, ele){
            if (url == "toggle") {
                  setState(() {
                    isExpanded = !isExpanded;
                    widget.onToggle?.call(isExpanded);
                  });
                }
          },
        );
      },
    );
  }

  void _calculateTruncation(double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.htmlText, style: widget.textStyle ?? const TextStyle(fontSize: 16)),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    if (textPainter.didExceedMaxLines) {
      needsTruncation = true;
      truncatedText = _truncateText(widget.htmlText, maxWidth);
    } else {
      needsTruncation = false;
    }
  }

  String _truncateText(String text, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(style: widget.textStyle ?? const TextStyle(fontSize: 16)),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    String truncated = text;
    while (truncated.isNotEmpty) {
      textPainter.text = TextSpan(text: "$truncated...", style: widget.textStyle);
      textPainter.layout(maxWidth: maxWidth);
      if (!textPainter.didExceedMaxLines) break;
      truncated = truncated.substring(0, truncated.length - 1);
    }
    return "$truncated...";
  }
}
