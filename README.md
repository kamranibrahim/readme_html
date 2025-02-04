Here’s an updated version of the README file based on the template you provided:

```markdown
# `read_more_html` Package

The `read_more_html` package provides a widget that renders HTML content and adds "Read More" functionality. It truncates content if it exceeds a specified number of lines and allows users to toggle between the truncated and full content by clicking a "More" or "Less" link.

## Features

- Display HTML content with truncation support.
- Toggle between truncated and full content with "More" and "Less" links.
- Supports customizable link colors and text styles.
- Allows specifying a maximum number of lines for the truncated content.
- Provides an optional callback to notify when the content is expanded or collapsed.

## Getting Started

1. Add the `read_more_html` package to your `pubspec.yaml` file:
   ```yaml
   dependencies:
     read_more_html:
       path: ../read_more_html  # Path to your local package, or specify a version if using pub.dev
   ```

2. Run the following command to install the package:
   ```bash
   flutter pub get
   ```

3. Import the package into your Dart files:
   ```dart
   import 'package:read_more_html/read_more_html.dart';
   ```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:read_more_html/read_more_html.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReadMoreHtml(
          htmlText: "<p>Your HTML content goes here. It may be long or short.</p>",
          maxLines: 3, // Set maximum lines for truncation
          moreText: "Read More", // Custom text for the "More" link
          lessText: "Read Less", // Custom text for the "Less" link
          linkColor: Colors.blue, // Custom color for the links
          onToggle: (isExpanded) {
            print(isExpanded ? "Content expanded" : "Content collapsed");
          },
        ),
      ),
    ),
  ));
}
```

### Parameters

- **htmlText** (`String`): The HTML content to be displayed.
    - **Required**

- **maxLines** (`int`): The maximum number of lines after which the content will be truncated.
    - **Default**: 3

- **moreText** (`String`): The text to display for the "More" link.
    - **Default**: "More"

- **lessText** (`String`): The text to display for the "Less" link.
    - **Default**: "Less"

- **linkColor** (`Color`): The color of the "More" and "Less" links.
    - **Default**: `Colors.blue`

- **textStyle** (`TextStyle?`): The style to be applied to the body text. If not provided, default text style is used.

- **onToggle** (`Function(bool isExpanded)?`): A callback function that is called when the user toggles the content between expanded and collapsed states.
    - **Parameters**: `isExpanded` - A boolean indicating whether the content is expanded (`true`) or collapsed (`false`).


## Additional Information

For more details, check out the following:

- **Contributing**: Feel free to open an issue or submit a pull request.
- **Issues**: If you encounter any bugs or need support, please [open an issue](https://github.com/kamranibrahim/readme_html/issues).
- **License**: This package is open-source and available under the [MIT License](https://opensource.org/licenses/MIT).
```

You can now use this as your `README.md` file. It includes all the necessary sections like features, usage, and additional information for contributors or users seeking help.# readme_html
