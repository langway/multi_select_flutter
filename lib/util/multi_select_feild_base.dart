import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/enums.dart';
import 'package:multi_select_flutter/util/multi_select_actions.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_panel.dart';

class MultiSelectFieldBase<V> extends FormField<List<V>>
    with MultiSelectMixIn<V> {
  /// Style the text of the selected chips.
  final TextStyle? selectedTextStyle;

  /// Replaces the deafult search icon when searchable is true.
  final Icon? searchIcon;

  /// Replaces the default close search icon when searchable is true.
  final Icon? closeSearchIcon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  final ShapeBorder? chipShape;

  /// Defines the header text.
  final Text? title;

  /// Enables horizontal scrolling. Default is true.
  final bool scroll;

  /// Enables search functionality.
  final bool? searchable;

  /// Set the search hint.
  final String? searchHint;

  /// Set the TextStyle of the search hint.
  final TextStyle? searchHintStyle;

  /// Set the TextStyle of the text that gets typed into the search bar.
  final TextStyle? searchTextStyle;

  /// Set the header color.
  final Color? headerColor;

  /// Build a custom widget that gets created dynamically for each item.
  Widget Function(MultiSelectItem<V>, BuildContext context)? itemBuilder;

  /// Make use of the ScrollController to automatically scroll through the list.
  final Function(ScrollController)? scrollControl;

  /// Determines whether to show the header.
  final bool showHeader;

  final List<V> initialValue;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<List<V>>? validator;
  final FormFieldSetter<List<V>>? onSaved;
  final GlobalKey<FormFieldState>? key;

  Function(FormFieldState<List<V>>) multiSelectFieldBuilder;

  MultiSelectFieldBase({
    this.key,

    /// The source list of selected items.
    required List<MultiSelectItem<V>> items,

    /// Fires when a chip is tapped.
    Function(MultiSelectItem<V>)? onTap,

    /// Color of the chip body or checkbox border while not selected.
    Color? unselectedColor,

    /// Sets the color of the checkbox or chip when it's selected.
    Color? selectedColor,

    /// Change the alignment of the chips.
    Alignment? alignment,

    /// Style the Container that makes up the chip display.
    BoxDecoration? decoration,

    // Style the text on the chips.
    TextStyle? textStyle,

    /// A function that sets the color of selected items based on their value.
    Color? Function(V)? colorator,

    /// An icon to display prior to the chip's label.
    Icon? icon,

    /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
    ShapeBorder? borderShape,

    // /// Enables horizontal scrolling.
    bool canScroll = false,

    // /// Enables the scrollbar when scroll is `true`.
    // HorizontalScrollBar? horizontalScrollBar,

    /// Set a fixed height.
    double? height,

    /// Set the width of the chips.
    double? width,

    /// disabled
    bool? disabled,

    /// An enum that determines which type of list to render.
    ItemViewType? itemViewType = ItemViewType.CHIP,

    /// An enum that determines which items to display.
    ItemsDisplayMode? itemsDisplayMode = ItemsDisplayMode.all,

    /// set listType
    ListTypes? listType = ListTypes.block,

    /// show checkmark on chip
    bool showCheckmark = true,

    /// Style the Container that makes up the chip display.
    BoxDecoration? checkBoxDecoration,

    /// Set a ShapeBorder for the checkbox. Typically a CircleBorder.
    ShapeBorder? checkBoxBorderShape,
    this.selectedTextStyle,
    this.searchIcon,
    this.closeSearchIcon,
    this.chipShape,
    this.title,
    this.scroll = true,
    this.searchable,
    this.searchHint,
    this.searchHintStyle,
    this.searchTextStyle,
    this.headerColor,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.initialValue = const [],
    this.scrollControl,
    this.showHeader = true,
    required this.multiSelectFieldBuilder,
    Widget Function(MultiSelectItem<V>, BuildContext context)? itemBuilder,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            initialValue: initialValue,
            builder: (FormFieldState<List<V>> state) {
              return multiSelectFieldBuilder(state);
            }) {
    this.disabled = disabled;
    this.items = items;
    this.onTap = onTap;
    this.unselectedColor = unselectedColor;
    this.selectedColor = selectedColor;
    this.alignment = alignment;
    this.decoration = decoration;
    this.textStyle = textStyle;
    this.colorator = colorator;
    this.icon = icon;
    this.borderShape = borderShape;
    this.canScroll = canScroll;
    this.height = height;
    this.width = width;
    this.itemViewType = itemViewType;
    this.itemsDisplayMode = itemsDisplayMode!;
    this.listType = listType;
    this.showCheckmark = showCheckmark;
    this.itemBuilder = itemBuilder;
    this.checkBoxDecoration = checkBoxDecoration;
    this.checkBoxBorderShape = checkBoxBorderShape;
  }

  @override
  List<MultiSelectItem<V>>? get selectedValues {
    return items!.where((item) => item.selected).toList();
  }

  @override
  List<MultiSelectItem<V>>? get unSelectedValues {
    return items!.where((item) => !item.selected).toList();
  }
}

// ignore: must_be_immutable
class MultiSelectFieldView<V> extends StatefulWidget
    with MultiSelectActions<V> {
  final BoxDecoration? decoration;
  List<MultiSelectItem<V>> items;
  final List<MultiSelectItem<V>>? selectedItems;
  final Color? unselectedColor;
  final Color? selectedColor;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final Icon? icon;
  final Icon? searchIcon;
  final Icon? closeSearchIcon;
  final ShapeBorder? chipShape;
  final Text? title;
  final bool canScroll;
  final bool? searchable;
  final String? searchHint;
  final TextStyle? searchHintStyle;
  final TextStyle? searchTextStyle;
  final List<V> initialValue;
  final Color? Function(V)? colorator;
  final Function(MultiSelectItem<V>)? onTap;
  final Color? headerColor;
  final Widget Function(MultiSelectItem<V>, BuildContext context)? itemBuilder;
  final double? height;
  final double? width;
  FormFieldState<List<V>>? state;
  final Function(ScrollController)? scrollControl;
  final bool showHeader;
  ItemViewType? itemViewType;
  ListTypes? listType;
  bool showCheckmark;

  /// Change the alignment of the chips.
  Alignment? alignment;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  ShapeBorder? borderShape;

  /// disabled
  bool? disabled;

  ItemsDisplayMode? itemsDisplayMode;

  MultiSelectFieldView({
    required this.items,
    this.selectedItems,
    this.decoration,
    this.unselectedColor,
    this.selectedColor,
    this.colorator,
    this.textStyle,
    this.selectedTextStyle,
    this.icon,
    this.chipShape,
    this.onTap,
    this.title,
    this.canScroll = true,
    this.initialValue = const [],
    this.searchable,
    this.searchHint,
    this.searchIcon,
    this.closeSearchIcon,
    this.searchHintStyle,
    this.searchTextStyle,
    this.headerColor,
    this.itemBuilder,
    this.height,
    this.width,
    this.scrollControl,
    this.showHeader = true,
    this.itemViewType = ItemViewType.CHIP,
    this.listType = ListTypes.block,
    this.itemsDisplayMode = ItemsDisplayMode.all,
    this.showCheckmark = true,
    this.alignment,
    this.borderShape,
    this.disabled,
  }) {
    if (initialValue.isNotEmpty && selectedItems == null) {
      for (var item in items) {
        if (initialValue.contains(item.value)) {
          item.selected = true;
        }
      }
    }
  }

  @override
  State createState() => MultiSelectFieldViewState<V>();
}

class MultiSelectFieldViewState<V> extends State<MultiSelectFieldView<V>> {
  bool _showSearch = false;

  ScrollController _scrollController = ScrollController();

  MultiSelectFieldViewState();

  void initState() {
    super.initState();

    if (widget.scrollControl != null && widget.canScroll)
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToPosition());
  }

  _scrollToPosition() {
    widget.scrollControl!(_scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: widget.decoration ??
              BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
              ),
          child: Column(
            children: [
              widget.showHeader
                  ? Container(
                      color:
                          widget.headerColor ?? Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _showSearch
                              ? Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextField(
                                      style: widget.searchTextStyle,
                                      decoration: InputDecoration(
                                        hintStyle: widget.searchHintStyle,
                                        hintText: widget.searchHint ?? "Search",
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: widget.selectedColor ??
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          widget.items =
                                              widget.updateSearchQuery(
                                                  val, widget.items);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: widget.title != null
                                      ? Text(
                                          widget.title!.data!,
                                          style: TextStyle(
                                              color: widget.title!.style != null
                                                  ? widget.title!.style!.color
                                                  : null,
                                              fontSize:
                                                  widget.title!.style != null
                                                      ? widget.title!.style!
                                                              .fontSize ??
                                                          18
                                                      : 18),
                                        )
                                      : Text(
                                          "Select",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                ),
                          widget.searchable != null && widget.searchable!
                              ? IconButton(
                                  icon: _showSearch
                                      ? widget.closeSearchIcon ??
                                          Icon(
                                            Icons.close,
                                            size: 22,
                                          )
                                      : widget.searchIcon ??
                                          Icon(
                                            Icons.search,
                                            size: 22,
                                          ),
                                  onPressed: () {
                                    setState(() {
                                      _showSearch = !_showSearch;
                                      // if (!_showSearch) _items = widget.items;
                                    });
                                  },
                                )
                              : Padding(
                                  padding: EdgeInsets.all(18),
                                ),
                        ],
                      ),
                    )
                  : Container(),
              MultiSelectPanel<V>(
                items: widget.items,
                itemViewType: widget.itemViewType,
                listType: widget.listType,
                colorator: widget.colorator,
                onTap: (item) {
                  if (widget.onTap != null) {
                    dynamic result = widget.onTap!(item);
                  }
                },
                decoration: widget.decoration,
                unselectedColor: widget.unselectedColor,
                selectedColor: widget.selectedColor,
                alignment: widget.alignment,
                textStyle: widget.textStyle,
                icon: widget.icon,
                borderShape: widget.borderShape,
                canScroll: widget.canScroll,
                height: widget.height,
                width: widget.width,
                disabled: widget.disabled,
                itemsDisplayMode: widget.itemsDisplayMode!,
                showCheckmark: widget.showCheckmark,
                itemBuilder: widget.itemBuilder,
              ),
            ],
          ),
        ),
        widget.state != null && widget.state!.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                    child: Text(
                      widget.state!.errorText!,
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
