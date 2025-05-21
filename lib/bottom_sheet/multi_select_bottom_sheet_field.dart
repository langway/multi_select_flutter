import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_dialog.dart';

/// A customizable InkWell widget that opens the MultiSelectBottomSheet
// ignore: must_be_immutable
class MultiSelectBottomSheetField<V> extends MultiSelectDialogField {
  MultiSelectBottomSheetField({
    super.key,
    required super.fieldPanelConfig,
    required super.dialogPanelConfig,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,

    /// ###################################
    /// 
    /// ###################################
    super.title,
    super.onConfirm,
    super.buttonText,
    super.buttonIcon,
    super.itemViewTypeOn,
    super.onSelectionChanged,
    super.confirmText,
    super.cancelText,
    super.initialChildSize,
    super.minChildSize,
    super.maxChildSize,
    super.shape,
    super.barrierColor,
    super.backgroundColor,
    super.unselectedColor,
    super.itemsTextStyle,
    super.selectedItemsTextStyle,
    super.separateSelectedItems = false,
    super.checkColor,
    super.isDismissible = true,
    super.searchable = false,
    super.searchIcon,
    super.closeSearchIcon,
    super.searchTextStyle,
    super.searchHint,
    super.searchHintStyle,
    super.decoration,
  }) : super(dialogType: DialogType.bottomSheet);
}
