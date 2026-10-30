# Smart Catalog & Infinite Feed App

**Laboratory Work 8 (LW8)** — Dynamic Lists, Grids & Scrollable Touch Interactions
Course: Cross-Platform Mobile Application Development (Flutter & Dart)
Narxoz University | School of Digital Technologies

## Overview

An interactive Flutter app that displays a product catalog in two switchable views
and supports three touch gestures: pull-to-refresh, swipe-to-delete and undo.

## Features

| Feature | Implementation |
|---|---|
| **List view** | `ListView.separated` with thin `Divider` separators. Each row: avatar icon, title, category tag, star rating, price |
| **Grid view** | `GridView.builder`, 2 columns, `childAspectRatio: 0.72`, styled cards (no RenderFlex overflow) |
| **View toggle** | AppBar icon button switches between List and Grid |
| **Pull-to-Refresh** | `RefreshIndicator`, simulated 1.5 s request (`Future.delayed`), new item inserted at index 0 |
| **Swipe-to-Delete** | `Dismissible` with `ValueKey(product.id)`, right-to-left swipe, red background with `Icons.delete` |
| **Undo** | Floating `SnackBar` with **UNDO** action, restores the item at its original index |
| **Empty state** | Icon, "Catalog is Empty" text and a **Reset Catalog** button that restores the seed data |

## Project Structure

```
lib/
├── main.dart                       # App entry point, MaterialApp, theme
├── models/
│   └── product.dart                # Product model + seed data
├── screens/
│   └── catalog_screen.dart         # Main screen: state, refresh, delete/undo, view toggle
└── widgets/
    ├── product_list_tile.dart      # Row for list view
    ├── product_grid_card.dart      # Card for grid view
    └── empty_state.dart            # Placeholder shown when the catalog is empty
```

## How to Run

```bash
git clone https://github.com/YepAndTeam/lab8.git
cd lab8
flutter pub get
flutter run -d chrome      # or any connected device / emulator
```

> In a browser, use a mouse drag for swipe and pull-to-refresh.
> On a phone or emulator, use regular touch gestures.

## Key Concepts (for defense)

- **Lazy rendering:** `ListView.builder` / `GridView.builder` / `ListView.separated` build only the visible items, unlike a `Column`, which builds everything at once and wastes memory on large collections.
- **`ValueKey`:** gives each `Dismissible` a unique identity so Flutter can correctly track and remove the right element.
- **Undo:** the original index is saved before removal and used to re-insert the item.
- **`mounted` check:** after an `await`, the widget may already be disposed, so `setState` is guarded by `if (!mounted) return;`.
- **`childAspectRatio: 0.72`:** the ratio of cell width to height; cells are taller than wide so card content fits without overflow.

## Tech Stack

- Flutter (Material 3)
- Dart

## Author

YepAndTeam