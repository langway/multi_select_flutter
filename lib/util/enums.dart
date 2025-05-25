/// Used by MultiSelectDialog and MultiSelectBottomSheet to determine which type of list to render.
enum ItemViewType { checkBoxList, checkBox, chip, image, text }

enum ItemsDisplayMode {
  /// Displays all items in the list mixin.
  all,

  /// Displays only the selected items in the list.
  selected,

  /// Displays only the unselected items in the list.
  unselected,

  /// Displays selected and unselected in two layer.
  cascade,
}

enum ListTypes { horizontalList, verticalList, block }

enum DialogType {
  /// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
  bottomSheet,

  /// A dialog widget containing either a classic checkbox style list, or a chip style list.
  dialog,
}
