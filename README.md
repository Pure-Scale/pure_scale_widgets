# Pure Scale Widgets

A set of widgets to help with scaling and layout in Flutter.

## How to use

### Install
Put this on your `pubspec.yaml` file.

```Dart
  pure_scale_widgets:
    git:
      url: https://github.com/Pure-Scale/pure_scale_widgets
```

### Import

```Dart
import 'package:pure_scale_widgets/pure_scale_widgets.dart';
```

## Structure

### Global Widgets
 
- `PSGlassWidget` - A widget that displays a glass effect for overlay or card-like components.
- `PSBackgroundWidget` - A widget that provides a consistent background effect across the app.
- `PSCardWidget` - A customizable card widget with shadow and rounded corners.
- `PSAppBar` - Custom app bar with consistent styling and optional actions.
- `PSBottomNavigationBar` - Standardized bottom navigation for app-wide navigation.
- `PSErrorWidget` - Displays error messages with optional retry functionality.
- `PSEmptyStateWidget` - Shows a message and optional action for empty lists or search results.
- `PSAvatarWidget` - Displays user avatars with fallback to initials.
- `PSRatingWidget` - Shows star ratings for jobs or user feedback.
- `PSTagWidget` - Displays tags or labels (e.g., job categories, skills).

### Data Widgets
These data widgets are universal and can work with any JSON or entities. They dynamically generate UI based on the types in the JSON or object types of the entities.
- `PSListShowWidget` - A widget that displays a list of items.
- `PSGridShowWidget` - A widget that displays a grid of items.
- `PSDataGridWidget` - A widget that displays a data grid.
- `PSDataListWidget` - A widget that displays a data list.
- `PSDataTableWidget` - A widget that displays a data table.
- `PSDataChartWidget` - A widget that displays a data chart.
- `PSDataFilterWidget` - A widget that displays a data filter.
- `PSDataSortWidget` - A widget that displays a data sort.

### Button Widgets

- `PSPrimaryButton` - A primary button widget with Filled style for main actions.
- `PSSecondaryButton` - A secondary button widget with Outlined style for less prominent actions.

### Loader Widgets

- `PSLoaderWidget` - A loader widget that displays a loading indicator for async operations.
- `PSShimmerLoaderWidget` - A shimmer loader widget that displays a shimmer loading effect for content placeholders.

### JSON View Widgets

- `PSJsonView` - A widget that displays JSON data in either vertical or horizontal layout.
- `PSJsonViewDemo` - A demo widget showcasing the usage of PSJsonView.

## Boilerplate Widget Code
```Dart

import 'package:flutter/material.dart';

class WidgetName extends StatelessWidget {

}
```

### Full Widget Creation Code
```shell
#!/bin/bash

# Function to create a new widget file
function createWidget() {
    # Check if filename is provided
    if [ -z "$1" ]; then
        echo "Please provide a widgetName."
        return 1
    fi

    # Set the filename
    widgetName="$1"
    filename="$widgetName.dart"
    # Create the file and write the basic widget structure
    cat << EOF > "$filename"
import 'package:flutter/material.dart';

class $1 extends StatelessWidget {
  const $1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
EOF

    echo "Widget file '$filename' created successfully."
}

# Usage example
# createWidget "my_widget.dart"

```


