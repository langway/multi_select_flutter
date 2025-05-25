
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/enums.dart';
import 'package:multi_select_flutter/util/multi_select_actions.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_panel.dart';
// import '../multi_select_flutter.dart';

// ignore: must_be_immutable

class MultiSelectFieldConfig<V> with MultiSelectActions<V> {
  /// panel that will be displayed on the page.
  MultiSelectPanelConfig<V>? panelConfig;

  /// #############################################
  ///
  /// #############################################
  /// The text at the top of the Dialog.
  Widget? title;

  /// Set text that is displayed on the button.
  Text? buttonText;

  /// Specify the button icon.
  Icon? buttonIcon;

  /// Fires when the an item is selected / unselected.
  void Function(List<V>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  void Function(List<MultiSelectItem<V>>?)? onConfirm;

  /// Text on the confirm button.
  Text? confirmText;

  /// Text on the cancel button.
  Text? cancelText;

  /// Set the initial height of the Dialog.
  double? initialChildSize;

  /// Set the minimum height threshold of the Dialog before it closes.
  double? minChildSize;

  /// Set the maximum height of the Dialog.
  double? maxChildSize;

  /// Apply a ShapeBorder to alter the edges of the Dialog.
  ShapeBorder? shape;

  /// Set the color of the space outside the Dialog.
  Color? barrierColor;

  /// Set the background color of the dialog .
  Color? backgroundColor;

  /// The TextStyle of the items within the Dialog.
  TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  TextStyle? selectedItemsTextStyle;

  /// Moves the selected items to the top of the list.
  bool separateSelectedItems = false;

  /// Set the color of the check in the checkbox
  Color? checkColor;

  /// Whether the user can dismiss the widget by tapping outside
  bool isDismissible = false;

  FormFieldState<List<V>>? state;

  /// An enum that determines which type of item to render.
  ItemViewType? itemViewTypeOn;

  /// Toggles search functionality.
  bool searchable = true;

  /// Set the placeholder text of the search fieldConfig.
  String? searchHint;

  /// Icon button that shows the search fieldConfig.
  Icon? searchIcon;

  /// Icon button that hides the search field
  Icon? closeSearchIcon;

  /// Style the search text.
  TextStyle? searchTextStyle;

  /// Style the search hint.
  TextStyle? searchHintStyle;

  bool showHeader = true;
  bool showItems = true;
  bool showErrors = true;

  /// Style the Container that makes up the chip display.
  Decoration? headerDecoration;

  /// itemsDecoration is in MultiSelectPanelConfig
  // Decoration? itemsDecoration;
  Decoration? errorsDecoration;

  MultiSelectFieldConfig({
    this.panelConfig,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.onSelectionChanged,
    this.onConfirm,
    this.confirmText,
    this.cancelText,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.backgroundColor,
    this.itemsTextStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.isDismissible = false,
    this.state,
    this.itemViewTypeOn,
    this.searchable = false,
    this.searchHint,
    this.searchIcon,
    this.closeSearchIcon,
    this.searchTextStyle,
    this.searchHintStyle,
    this.showHeader = true,
    this.showItems = true,
    this.showErrors = true,
    this.headerDecoration,
    // this.itemsDecoration,
    this.errorsDecoration,
  });

  bool _showSearch = false;
  List<MultiSelectItem<V>>? filteredList = [];
  String searchQuery = "";

  buildMultiSelectPanel() {
    return panelConfig!.buildMultiSelectPanel(
      itemsToShow: (searchQuery.isNotEmpty) ? filteredList : panelConfig!.items,
    );
  }

  Padding buildHeader(State state) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title ?? Text("Select", style: TextStyle(fontSize: 18)),
          searchable
              ? IconButton(
                icon:
                    _showSearch
                        ? closeSearchIcon ?? Icon(Icons.close)
                        : searchIcon ?? Icon(Icons.search),
                onPressed: () {
                  state.setState(() {
                    _showSearch = !_showSearch;
                  });
                },
              )
              : Padding(padding: EdgeInsets.all(15)),
        ],
      ),
    );
  }

  buildSearch(State state) {
    return _showSearch
        ? Container(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            autofocus: true,
            style: searchTextStyle,
            decoration: InputDecoration(
              hintStyle: searchHintStyle,
              hintText: searchHint ?? "Search",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      panelConfig!.selectedColor ??
                      Theme.of(state.context).primaryColor,
                ),
              ),
            ),
            onChanged: (val) {
              state.setState(() {
                searchQuery = val;
                filteredList = updateSearchQuery(val, panelConfig!.items);
              });
            },
          ),
        )
        : Container();
  }

  ConstrainedBox buildMultiSelectPanelWidget(
    BuildContext context,
    Widget multiSelectPanel,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: multiSelectPanel,
    );
  }

  Row buildErrors(String errorText) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            errorText,
            style: TextStyle(color: Colors.red[800], fontSize: 12.5),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class MultiSelectField<V> extends FormField<List<V>> {
  MultiSelectFieldConfig<V> fieldConfig;

  MultiSelectField({
    super.key,
    required this.fieldConfig,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.initialValue = const [],
  }) : super(
         // 这里把 FormField<List<V>>传递给了 MultiSelectDialogFieldView<V>，
         builder: (FormFieldState<List<V>> state) {
           return MultiSelectFieldView<V>(
             formFieldState: state,
             fieldConfig: fieldConfig,
           );
         },
       );
}

// ignore: must_be_immutable
class MultiSelectFieldView<V> extends StatefulWidget {
  FormFieldState<List> formFieldState;

  MultiSelectFieldConfig<V> fieldConfig;

  MultiSelectFieldView({
    super.key,
    required this.formFieldState,
    required this.fieldConfig,
  });

  @override
  State createState() => MultiSelectFieldViewState<V>();
}

class MultiSelectFieldViewState<V> extends State<MultiSelectFieldView<V>> {
  MultiSelectFieldConfig<V> get fieldConfig => widget.fieldConfig;

  @override
  Widget build(BuildContext context) {
    /// 总共分成四个部分：
    /// 1. 标题部分（需区分是否可以搜索）
    /// 2. 搜索面板部分（需区分是否可以搜索）
    /// 3. 选项面板部分
    /// 4. 错误信息部分
    ///
    final multiSelectPanel = fieldConfig.buildMultiSelectPanel();
    final selectedValues = fieldConfig.panelConfig!.selectedValues;

    final children = <Widget>[];
    if (fieldConfig.showHeader) {
      children.add(fieldConfig.buildHeader(this));
    }
    if (fieldConfig.searchable) {
      children.add(fieldConfig.buildSearch(this));
    }

    if (fieldConfig.showItems) {
      children.add(multiSelectPanel);
    }

    if (fieldConfig.showErrors && widget.formFieldState.hasError) {
      children.add(SizedBox(height: 5));

      children.add(fieldConfig.buildErrors(widget.formFieldState.errorText!));
    }
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }
}

