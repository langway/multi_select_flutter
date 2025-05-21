import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_panel.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_actions.dart';

enum DialogType {
  /// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
  bottomSheet,

  /// A dialog widget containing either a classic checkbox style list, or a chip style list.
  dialog,
}

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiSelectDialog<T> extends StatefulWidget with MultiSelectActions<T> {
  /// panel that will be displayed on the bottom sheet.
  MultiSelectPanelConfig<T> dialogPanelConfig;

  DialogType dialogType;

  /// The text at the top of the BottomSheet.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<T>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<T>)? onConfirm;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  /// Toggles search functionality.
  final bool searchable;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  MultiSelectDialog({
    super.key,
    required this.dialogType,
    required this.dialogPanelConfig,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.cancelText,
    this.confirmText,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.itemsTextStyle,
    this.searchable = false,
    this.searchIcon,
    this.closeSearchIcon,
    this.searchTextStyle,
    this.searchHint,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.checkColor,
  });

  @override
  _MultiSelectDialogState<T> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  bool _showSearch = false;
  List<MultiSelectItem<T>>? filteredList = [];
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final multiSelectPanel = widget.dialogPanelConfig.buildMultiSelectPanel(
        itemsToShow: (searchQuery.isNotEmpty)
            ? filteredList
            : widget.dialogPanelConfig.items);

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.title ??
                  Text(
                    "Select",
                    style: TextStyle(fontSize: 18),
                  ),
              widget.searchable
                  ? IconButton(
                      icon: _showSearch
                          ? widget.closeSearchIcon ?? Icon(Icons.close)
                          : widget.searchIcon ?? Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _showSearch = !_showSearch;
                        });
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.all(15),
                    ),
            ],
          ),
        ),
        _showSearch
            ? Container(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  autofocus: true,
                  style: widget.searchTextStyle,
                  decoration: InputDecoration(
                    hintStyle: widget.searchHintStyle,
                    hintText: widget.searchHint ?? "Search",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.dialogPanelConfig.selectedColor ??
                              Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                      filteredList = widget.updateSearchQuery(
                          val, widget.dialogPanelConfig.items);
                    });
                  },
                ),
              )
            : Container(),
        SizedBox(height: 15),
        // multi select panel
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          child: multiSelectPanel,
        ),
        // buttons: cancel and confirm
        Container(
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (multiSelectPanel is MultiSelectPanel<T>) {
                        multiSelectPanel.clearChangedItems();
                      }
                    });

                    Navigator.pop(context, 'cancel');
                  },
                  child: widget.cancelText ??
                      Text(
                        "CANCEL",
                        style: TextStyle(
                          color:
                              (widget.dialogPanelConfig.selectedColor != null &&
                                      widget.dialogPanelConfig.selectedColor !=
                                          Colors.transparent)
                                  ? widget.dialogPanelConfig.selectedColor!
                                      .withOpacity(1)
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'confirm');
                  },
                  child: widget.confirmText ??
                      Text(
                        "OK",
                        style: TextStyle(
                          color:
                              (widget.dialogPanelConfig.selectedColor != null &&
                                      widget.dialogPanelConfig.selectedColor !=
                                          Colors.transparent)
                                  ? widget.dialogPanelConfig.selectedColor!
                                      .withOpacity(1)
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (widget.dialogType == DialogType.dialog) {
      return Container(
        child: column,
      );
    } else if (widget.dialogType == DialogType.bottomSheet) {
      return Container(
        child: DraggableScrollableSheet(
          // should not set initialChildSize or maxChildSize
          // initialChildSize: widget.initialChildSize ?? 0.3,
          // maxChildSize: widget.maxChildSize ?? 0.6,
          minChildSize: widget.minChildSize ?? 0.3,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return column;
          },
        ),
      );
    }

    return Container();
  }
}
