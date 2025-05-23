import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_feild_base.dart';
import '../multi_select_flutter.dart';

class MultiSelectCommonField<V> extends MultiSelectFieldBase<V> {
  MultiSelectCommonField({
    required super.items,
    super.decoration,
    super.unselectedColor,
    super.selectedColor,
    super.colorator,
    super.textStyle,
    super.selectedTextStyle,
    super.icon,
    super.searchIcon,
    super.closeSearchIcon,
    super.chipShape,
    super.onTap,
    super.title,
    super.scroll = true,
    super.searchable,
    super.searchHint,
    super.searchHintStyle,
    super.searchTextStyle,
    super.headerColor,
    super.key,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.initialValue = const [],
    super.itemBuilder,
    super.height,
    super.width,
    super.scrollControl,
    super.showHeader = true,
    super.itemViewType = ItemViewType.CHIP,
    super.listType = ListTypes.block,
    super.showCheckmark = true,
    super.alignment,
    super.borderShape,
    // FormFieldBuilder<List<V>>? multiSelectFieldBuilder,
  }) : super(multiSelectFieldBuilder: (FormFieldState<List<V>> state) {
          MultiSelectFieldView<V> view = MultiSelectFieldView<V>(
            items: items,
            decoration: decoration,
            unselectedColor: unselectedColor,
            selectedColor: selectedColor,
            colorator: colorator,
            textStyle: textStyle,
            selectedTextStyle: selectedTextStyle,
            icon: icon,
            searchIcon: searchIcon,
            closeSearchIcon: closeSearchIcon,
            chipShape: chipShape,
            onTap: onTap,
            title: title,
            canScroll: scroll,
            initialValue: initialValue,
            searchable: searchable,
            searchHint: searchHint,
            searchHintStyle: searchHintStyle,
            searchTextStyle: searchTextStyle,
            headerColor: headerColor,
            itemBuilder: itemBuilder,
            height: height,
            width: width,
            scrollControl: scrollControl,
            showHeader: showHeader,
            itemViewType: itemViewType,
            listType: listType,
            showCheckmark: showCheckmark,
            alignment: alignment,
            borderShape: borderShape,
          );
          view.state = state;
          return view;
          // return MultiSelectFieldView.createWithState<V>(view, state);
        });
}
