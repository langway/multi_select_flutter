import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_actions.dart';
import '../util/enums.dart';
import '../util/multi_select_panel.dart';
import 'package:multi_select_flutter/util/multi_select_dialog.dart';

/// A customizable InkWell widget that opens the MultiSelectDialog
// ignore: must_be_immutable
class MultiSelectDialogField<V> extends FormField<List<V>> {
  /// panel that will be displayed on the page.
  MultiSelectPanelConfig<V> fieldPanelConfig;

  /// panel that will be displayed on the dialog sheet.
  MultiSelectPanelConfig<V> dialogPanelConfig;

  /// #############################################
  ///
  /// #############################################
  /// The text at the top of the Dialog.
  final Widget? title;

  /// Set text that is displayed on the button.
  final Text? buttonText;

  /// Specify the button icon.
  final Icon? buttonIcon;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>)? onConfirm;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Set the initial height of the Dialog.
  final double? initialChildSize;

  /// Set the minimum height threshold of the Dialog before it closes.
  final double? minChildSize;

  /// Set the maximum height of the Dialog.
  final double? maxChildSize;

  /// Apply a ShapeBorder to alter the edges of the Dialog.
  final ShapeBorder? shape;

  /// Set the color of the space outside the Dialog.
  final Color? barrierColor;

  /// Set the background color of the dialog .
  final Color? backgroundColor;

  /// The TextStyle of the items within the Dialog.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  /// Whether the user can dismiss the widget by tapping outside
  final bool isDismissible;

  FormFieldState<List<V>>? state;

  /// An enum that determines which type of item to render.
  final ItemViewType? itemViewTypeOn;

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

  DialogType dialogType;

  /// Style the Container that makes up the chip display.
  BoxDecoration? decoration;

  MultiSelectDialogField({
    super.key,
    this.dialogType=DialogType.dialog,
    required this.fieldPanelConfig,
    required this.dialogPanelConfig,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.initialValue = const [],

    /// ###################################
    ///
    /// ###################################
    this.title,
    this.onConfirm,
    this.buttonText,
    this.buttonIcon,
    this.itemViewTypeOn,
    this.onSelectionChanged,
    this.confirmText,
    this.cancelText,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.backgroundColor,
    this.unselectedColor,
    this.itemsTextStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.isDismissible = true,
    this.searchable = false,
    this.searchIcon,
    this.closeSearchIcon,
    this.searchTextStyle,
    this.searchHint,
    this.searchHintStyle,
    this.decoration,
  }) : super(builder: (FormFieldState<List<V>> state) {
          return _MultiSelectDialogFieldView<V>(
            state: state,
          );
        });
}

// ignore: must_be_immutable
class _MultiSelectDialogFieldView<V> extends StatefulWidget
    with MultiSelectActions<V> {
  FormFieldState<List> state;

  _MultiSelectDialogFieldView({
    required this.state,
  });

  @override
  State createState() => __MultiSelectDialogFieldViewState<V>();
}

class __MultiSelectDialogFieldViewState<V>
    extends State<_MultiSelectDialogFieldView<V>> {
  late MultiSelectDialogField<V> field;
  @override
  void initState() {
    super.initState();
    field = widget.state.widget as MultiSelectDialogField<V>;
  }

  void _showDialog(BuildContext ctx) async {
    final result = await showDialog<String>(
        barrierColor: field.barrierColor,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
            // insetPadding: EdgeInsets.only(bottom: 100),
            // alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                minHeight: MediaQuery.of(context).size.height * 0.5,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: MultiSelectDialog<V>(
                dialogType: DialogType.dialog,
                dialogPanelConfig: field.dialogPanelConfig,
                checkColor: field.checkColor,
                selectedItemsTextStyle: field.selectedItemsTextStyle,
                searchable: field.searchable,
                searchTextStyle: field.searchTextStyle,
                searchHintStyle: field.searchHintStyle,
                searchIcon: field.searchIcon,
                closeSearchIcon: field.closeSearchIcon,
                searchHint: field.searchHint,
                itemsTextStyle: field.itemsTextStyle,
                cancelText: field.cancelText,
                confirmText: field.confirmText,
                onConfirm: (selected) {
                  if (field.onConfirm != null) field.onConfirm!(selected);
                },
                onSelectionChanged: field.onSelectionChanged,
                title: field.title,
                initialChildSize: field.initialChildSize,
                minChildSize: field.minChildSize,
                maxChildSize: field.maxChildSize,
              ),
            ),
          );
        });

    setState(() {});
  }

  void _showBottomSheet(BuildContext ctx) async {
    final result = await showModalBottomSheet<String>(
        isDismissible: field.isDismissible,
        backgroundColor: field.backgroundColor,
        barrierColor: field.barrierColor,
        shape: field.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return MultiSelectDialog<V>(
            dialogType: DialogType.bottomSheet,
            dialogPanelConfig: field.dialogPanelConfig,
            checkColor: field.checkColor,
            selectedItemsTextStyle: field.selectedItemsTextStyle,
            searchable: field.searchable,
            searchTextStyle: field.searchTextStyle,
            searchHintStyle: field.searchHintStyle,
            searchIcon: field.searchIcon,
            closeSearchIcon: field.closeSearchIcon,
            searchHint: field.searchHint,
            itemsTextStyle: field.itemsTextStyle,
            cancelText: field.cancelText,
            confirmText: field.confirmText,
            onConfirm: (selected) {
              if (field.onConfirm != null) field.onConfirm!(selected);
            },
            onSelectionChanged: field.onSelectionChanged,
            title: field.title,
            initialChildSize: field.initialChildSize,
            minChildSize: field.minChildSize,
            maxChildSize: field.maxChildSize,
          );
        });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedValues = field.fieldPanelConfig.selectedValues;

    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (field.dialogType == DialogType.bottomSheet) {
              _showBottomSheet(context);
              return;
            } else if (field.dialogType == DialogType.dialog) {
              _showDialog(context);
              return;
            }
          },
          child: Container(
            decoration: field.decoration ??
                BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: widget.state.hasError
                          ? Colors.red.shade800.withOpacity(0.6)
                          : selectedValues != null && selectedValues.isNotEmpty
                              ? (field.fieldPanelConfig.selectedColor != null &&
                                      field.fieldPanelConfig.selectedColor !=
                                          Colors.transparent)
                                  ? field.fieldPanelConfig.selectedColor!
                                  : Theme.of(context).primaryColor
                              : Colors.black45,
                      width: selectedValues != null && selectedValues.isNotEmpty
                          ? (widget.state.hasError)
                              ? 1.4
                              : 1.8
                          : 1.2,
                    ),
                  ),
                ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                field.buttonText ?? Text("Select"),
                field.buttonIcon ?? Icon(Icons.arrow_downward),
              ],
            ),
          ),
        ),
        field.fieldPanelConfig
            .buildMultiSelectPanel(itemsToShow: field.fieldPanelConfig.items),
        widget.state.hasError ? SizedBox(height: 5) : Container(),
        widget.state.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      widget.state.errorText!,
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
