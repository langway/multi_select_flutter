import 'package:flutter/material.dart';
import '../util/enums.dart';
import 'multi_select_item.dart';

mixin MultiSelectMixIn<V> {
  /// The source list of selected items.
  List<MultiSelectItem<V>>? items;

  /// The source list of selected items.
  List<MultiSelectItem<V>>? get selectedValues;

  /// The source list of unselected items.
  List<MultiSelectItem<V>>? get unSelectedValues;

  /// Fires when a chip is tapped.
  Function(MultiSelectItem<V>)? onTap;

  /// Color of the chip body or checkbox border while not selected.
  Color? unselectedColor;

  /// Sets the color of the checkbox or chip when it's selected.
  Color? selectedColor;

  /// Change the alignment of the chips.
  Alignment? alignment;

  /// Style the Container that makes up the chip display.
  ShapeDecoration? panelDecoration;

  /// Style the Container that makes up the chip display.
  ShapeDecoration? itemDecoration;

  /// Style the text on the chips.
  TextStyle? textStyle;

  /// A function that sets the color of selected items based on their value.
  Color? Function(V)? colorator;

  /// An icon to display prior to the chip's label.
  Icon? icon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  ShapeBorder? itemBorderShape;

  /// Enables horizontal scrolling.
  bool canScroll = false;

  /// Set a fixed height.
  double? height;

  /// Set the width of the chips.
  double? width;

  /// disabled
  bool disabled = false;

  /// An enum that determines which type of list to render.
  ItemViewType? itemViewType;

  ListTypes? listType;

  /// show checkmark on chip
  bool? showCheckmark;

  /// An enum that determines which items to display.
  ItemsDisplayMode? itemsDisplayMode = ItemsDisplayMode.all;

  /// Style the Container that makes up the chip display.
  ShapeDecoration? checkBoxDecoration;
}

class MultiSelectPanelConfig<V> with MultiSelectMixIn<V> {
  MultiSelectPanelConfig({
    /// The source list of selected items.
    List<MultiSelectItem<V>>? items,

    /// Fires when a chip is tapped.
    Function(MultiSelectItem<V>)? onTap,

    /// Color of the chip body or checkbox border while not selected.
    Color? unselectedColor,

    /// Sets the color of the checkbox or chip when it's selected.
    Color? selectedColor,

    /// Change the alignment of the chips.
    Alignment? alignment,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? panelDecoration,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? itemDecoration,

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
    bool disabled = false,

    /// An enum that determines which type of list to render.
    ItemViewType? itemViewType = ItemViewType.chip,

    /// An enum that determines which items to display.
    ItemsDisplayMode? itemsDisplayMode = ItemsDisplayMode.all,

    /// set listType
    ListTypes? listType = ListTypes.block,

    /// show checkmark on chip
    bool? showCheckmark = true,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? checkBoxDecoration,

    /// Set a ShapeBorder for the checkbox. Typically a CircleBorder.
    ShapeBorder? checkBoxBorderShape,

    /// function to build item
    Widget Function(MultiSelectItem<V>, BuildContext context)? itemBuilder,
  }) {
    this.disabled = disabled;
    this.items = items;
    this.onTap = onTap;
    this.unselectedColor = unselectedColor;
    this.selectedColor = selectedColor;
    this.alignment = alignment;
    this.panelDecoration = panelDecoration;
    this.itemDecoration = itemDecoration;
    this.textStyle = textStyle;
    this.colorator = colorator;
    this.icon = icon;
    itemBorderShape = borderShape;
    this.canScroll = canScroll;
    this.height = height;
    this.width = width;
    this.itemViewType = itemViewType;
    this.itemsDisplayMode = itemsDisplayMode!;
    this.listType = listType;
    this.showCheckmark = showCheckmark;
    this.checkBoxDecoration = checkBoxDecoration;
  }

  Widget buildMultiSelectPanel({
    List<MultiSelectItem<V>>? itemsToShow,
    State? state,
  }) {
    itemsToShow ??= items;

    return MultiSelectPanel<V>(
      items: itemsToShow,
      colorator: colorator,
      disabled: disabled,
      onTap: (item) {
        if (state != null) {
          state.setState(() {});
        }
        if (onTap != null) {
          dynamic result = onTap!(item);
        }
      },
      panelDecoration: panelDecoration,
      itemDecoration: itemDecoration,
      unselectedColor: unselectedColor ??
          ((selectedColor != null && selectedColor != Colors.transparent)
              ? selectedColor!.withOpacity(0.35)
              : null),
      alignment: alignment,
      textStyle: textStyle,
      icon: icon,
      borderShape: itemBorderShape,
      height: height,
      width: width,
      itemViewType: itemViewType,
      listType: listType,
      selectedColor: selectedColor,
      canScroll: canScroll,
      itemsDisplayMode: itemsDisplayMode!,
      showCheckmark: showCheckmark,
      checkBoxDecoration: checkBoxDecoration,
    );
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

/// A widget meant to display selected values as chips.
// ignore: must_be_immutable
class MultiSelectPanel<V> extends StatefulWidget with MultiSelectMixIn<V> {
  Widget Function(MultiSelectItem<V>, BuildContext context)? itemBuilder;

  MultiSelectPanel({
    super.key,

    /// The source list of selected items.
    List<MultiSelectItem<V>>? items,

    /// Fires when a chip is tapped.
    Function(MultiSelectItem<V>)? onTap,

    /// Color of the chip body or checkbox border while not selected.
    Color? unselectedColor,

    /// Sets the color of the checkbox or chip when it's selected.
    Color? selectedColor,

    /// Change the alignment of the chips.
    Alignment? alignment,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? panelDecoration,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? itemDecoration,

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
    bool disabled = false, // 只显示，不可编辑更改
    /// An enum that determines which type of list to render.
    ItemViewType? itemViewType = ItemViewType.chip,

    /// An enum that determines which items to display.
    ItemsDisplayMode? itemsDisplayMode = ItemsDisplayMode.all,

    /// set listType
    ListTypes? listType = ListTypes.block,

    /// show checkmark on chip
    bool? showCheckmark = true,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? checkBoxDecoration,

    /// Set a ShapeBorder for the checkbox. Typically a CircleBorder.
    ShapeBorder? checkBoxBorderShape,

    /// function to build item
    this.itemBuilder,
  }) {
    this.disabled = disabled;
    this.items = items;
    this.onTap = onTap;
    this.unselectedColor = unselectedColor;
    this.selectedColor = selectedColor;
    this.alignment = alignment;
    this.panelDecoration = panelDecoration;
    this.itemDecoration = itemDecoration;
    this.textStyle = textStyle;
    this.colorator = colorator;
    this.icon = icon;
    itemBorderShape = borderShape;
    this.canScroll = canScroll;
    this.height = height;
    this.width = width;
    this.itemViewType = itemViewType;
    this.itemsDisplayMode = itemsDisplayMode!;
    this.listType = listType;
    this.showCheckmark = showCheckmark;
    this.checkBoxDecoration = checkBoxDecoration;
  }

  MultiSelectPanel.none({
    super.key,

    /// The source list of selected items.
    List<MultiSelectItem<V>>? items,

    /// The source list of selected items.
    List<MultiSelectItem<V>>? selectedValues,

    /// Fires when a chip is tapped.
    Function(MultiSelectItem<V>)? onTap,

    /// Color of the chip body or checkbox border while not selected.
    Color? unselectedColor,

    /// Sets the color of the checkbox or chip when it's selected.
    Color? selectedColor,

    /// Change the alignment of the chips.
    Alignment? alignment,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? panelDecoration,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? itemDecoration,

    /// Style the text on the chips.
    TextStyle? textStyle,

    /// A function that sets the color of selected items based on their value.
    Color? Function(V)? colorator,

    /// An icon to display prior to the chip's label.
    Icon? icon,

    /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
    ShapeBorder? shape,

    // /// Enables horizontal scrolling.
    bool? scroll,

    /// Set a fixed height.
    double? height,

    /// Set the width of the chips.
    double? width,

    /// disabled
    bool disabled = false,

    /// An enum that determines which type of list to render.
    ItemViewType? itemViewType,

    /// An enum that determines which items to display.
    ItemsDisplayMode? itemsDisplayMode,

    /// set listType
    ListTypes? listType,

    /// show checkmark on chip
    bool? showCheckmark = true,

    /// Style the Container that makes up the chip display.
    ShapeDecoration? checkBoxDecoration,

    /// Set a ShapeBorder for the checkbox. Typically a CircleBorder.
    ShapeBorder? checkBoxBorderShape,

    /// function to build item
    Widget Function(MultiSelectItem<V>, BuildContext context)? itemBuilder,
  }) {
    this.disabled = disabled;
    this.items = items;
    this.onTap = onTap;
    this.unselectedColor = unselectedColor;
    this.selectedColor = selectedColor;
    this.alignment = alignment;
    this.panelDecoration = panelDecoration;
    this.itemDecoration = itemDecoration;
    this.textStyle = textStyle;
    this.colorator = colorator;
    this.icon = icon;
    itemBorderShape = shape;
    canScroll = canScroll;
    this.height = height;
    this.width = width;
    this.itemViewType = itemViewType;
    this.itemsDisplayMode = itemsDisplayMode;
    this.listType = listType;
    this.showCheckmark = showCheckmark;
    this.itemBuilder = itemBuilder;
  }

  @override
  List<MultiSelectItem<V>>? get selectedValues {
    return items!.where((item) => item.selected).toList();
  }

  @override
  List<MultiSelectItem<V>>? get unSelectedValues {
    return items!.where((item) => !item.selected).toList();
  }

  /// List of selected items in this state.
  List<MultiSelectItem> changedItems = [];

  void clearChangedItems() {
    for (var item in changedItems) {
      // 反选
      item.selected = !item.selected;
    }
    changedItems.clear();
  }

  @override
  State<StatefulWidget> createState() {
    return _MultiSelectPanelState<V>();
  }
}

class _MultiSelectPanelState<V> extends State<MultiSelectPanel<V>> {
  /// ScrollController for the MultiSelectChipDisplay.
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.items == null || widget.items!.isEmpty) return Container();
    return Container(
      decoration: widget.panelDecoration,
      alignment: widget.alignment ?? Alignment.centerLeft,
      child: _buildItems(context),
    );
  }

  Widget _buildItems(BuildContext context) {
    if (widget.itemsDisplayMode == ItemsDisplayMode.all) {
      return _buildItemsBlock(context, widget.items);
    } else if (widget.itemsDisplayMode == ItemsDisplayMode.selected) {
      return _buildItemsBlock(context, widget.selectedValues);
    } else if (widget.itemsDisplayMode == ItemsDisplayMode.unselected) {
      return _buildItemsBlock(context, widget.unSelectedValues);
    } else if (widget.itemsDisplayMode == ItemsDisplayMode.cascade) {
      return Column(
        children: [
          _buildItemsBlock(context, widget.selectedValues),
          Divider(height: 1, color: Colors.grey),
          _buildItemsBlock(context, widget.unSelectedValues),
        ],
      );
    }
    return Container();
  }

  Widget _buildItemsBlock(
    BuildContext context,
    List<MultiSelectItem<V>>? items,
  ) {
    if (items == null || items.isEmpty) return Container();

    if (widget.listType == ListTypes.horizontalList ||
        widget.listType == ListTypes.verticalList) {
      Axis scrollDirection;
      if (widget.listType == ListTypes.horizontalList) {
        scrollDirection = Axis.horizontal;
      } else {
        scrollDirection = Axis.vertical;
      }
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: widget.width ?? MediaQuery.of(context).size.width * 0.1,
          maxWidth: widget.width ?? MediaQuery.of(context).size.width,
          minHeight: widget.height ?? MediaQuery.of(context).size.height * 0.1,
          maxHeight: widget.height ?? MediaQuery.of(context).size.height * 0.5,
        ),
        // width: MediaQuery.of(context).size.width,
        // height: widget.height ?? MediaQuery.of(context).size.height * 0.8,
        child: widget.canScroll
            ? Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: scrollDirection,
                  itemCount: items.length,
                  itemBuilder: (ctx, index) {
                    return _buildItem(
                      items[index],
                      context,
                      widget.itemViewType,
                      widget,
                    );
                  },
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                scrollDirection: scrollDirection,
                itemCount: items.length,
                itemBuilder: (ctx, index) {
                  return _buildItem(
                    items[index],
                    context,
                    widget.itemViewType,
                    widget,
                  );
                },
              ),
      );
    } else if (widget.listType == ListTypes.block) {
      return Wrap(
        children: items
            .map(
              (item) => _buildItem(item, context, widget.itemViewType, widget),
            )
            .toList(),
      );
    }

    return Container();
  }

  void onItemChanged(item) {
    if (widget.disabled) return; // 只显示，不可编辑更改
    setState(() {
      item.selected = !item.selected;
      if (widget.changedItems.contains(item)) {
        widget.changedItems.remove(item);
      } else {
        widget.changedItems.add(item);
      }
    });

    if (widget.onTap != null) widget.onTap!(item);
  }

  Widget _buildItem(
    MultiSelectItem<V> item,
    BuildContext context,
    ItemViewType? itemViewType,
    MultiSelectPanel<V> widget,
  ) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(item, context);
    }
    // ThemeData theme = Theme.of(context);
    // Color? curItemColor;
    // if (widget.colorator != null) {
    //   curItemColor = widget.colorator!(item.value);
    // }
    itemViewType ??= ItemViewType.chip;

    final roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
        bottom: Radius.circular(15.0),
      ),
    );
    ShapeBorder? itemBorderShape = widget.itemDecoration?.shape ??
        // widget.itemBorderShape as OutlinedBorder? ??
        roundedRectangleBorder;

    if (itemBorderShape is! OutlinedBorder) {
      itemBorderShape = roundedRectangleBorder;
    }
    Color? selectedColor = widget.selectedColor ??
        Theme.of(context).primaryColor.withOpacity(0.35);

    if (itemViewType == ItemViewType.chip ||
        itemViewType == ItemViewType.image) {
      Widget label;
      if (itemViewType == ItemViewType.image &&
          item.imageUrl != null &&
          item.imageUrl!.isNotEmpty) {
        label = SizedBox(
          width: widget.width ?? 80,
          child: Column(
            children: [
              loadImageByPath(item.imageUrl!),
              Text(
                item.label,
                overflow: TextOverflow.ellipsis,
                style: widget.textStyle,
              ),
            ],
          ),
        );
      } else {
        label = SizedBox(
          width: widget.width,
          child: Text(item.label, style: widget.textStyle),
        );
      }

      return Container(
        margin: EdgeInsets.all(0),
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          showCheckmark: widget.showCheckmark,
          backgroundColor: widget.unselectedColor,
          shape: itemBorderShape,
          avatar: widget.icon != null
              ? Icon(
                  widget.icon!.icon,
                  color: widget.colorator != null &&
                          widget.colorator!(item.value) != null
                      ? widget.colorator!(item.value)!.withOpacity(1)
                      : widget.icon!.color ?? Theme.of(context).primaryColor,
                )
              : null,
          label: label,
          selected: item.selected,
          selectedColor: selectedColor,
          onSelected: (_) {
            onItemChanged(item);
          },
        ),
      );
    } else if (itemViewType == ItemViewType.checkBox) {
      return Container(
        margin: EdgeInsets.all(0),
        padding: const EdgeInsets.all(2.0),
        decoration: widget.itemDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: item.selected,
              onChanged: (_) {
                onItemChanged(item);
              },
              shape: widget.checkBoxDecoration != null
                  ? widget.checkBoxDecoration!.shape as OutlinedBorder
                  : null,
            ),
            SizedBox(width: 4.0),
            Text(item.label, style: widget.textStyle),
          ],
        ),
      );
    } else if (itemViewType == ItemViewType.checkBoxList) {
      return Container(
        margin: EdgeInsets.all(0),
        padding: const EdgeInsets.all(2.0),
        height: widget.height,
        width: widget.width ?? MediaQuery.of(context).size.width * 0.73,
        child: CheckboxListTile(
          title: Text(item.label, style: widget.textStyle),
          value: item.selected,
          onChanged: (_) {
            onItemChanged(item);
          },
          controlAffinity: ListTileControlAffinity.leading,
          shape: itemBorderShape,
          checkboxShape: widget.checkBoxDecoration != null
              ? widget.checkBoxDecoration!.shape as OutlinedBorder
              : null,
        ),
      );
    } else if (itemViewType == ItemViewType.text) {
      return Container(
        margin: EdgeInsets.all(0),
        padding: const EdgeInsets.all(2.0),
        child: Text(item.label, style: widget.textStyle),
      );
    } else {
      return Container();
    }
  }

  loadImageByPath(String s) {
    if (s.startsWith("http")) {
      return Image.network(s);
    } else {
      return Image.asset(s);
    }
  }
}
