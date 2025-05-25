
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/enums.dart';
import '../dialog/multi_select_dialog_field.dart';

/// A customizable InkWell widget that opens the MultiSelectBottomSheet
// ignore: must_be_immutable
class MultiSelectBottomSheetField<V> extends MultiSelectDialogField {
  MultiSelectBottomSheetField({
    super.key,
    required super.dialogFieldConfig,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.initialValue = const [],
  }) {
    // Set the dialog type to BottomSheet
    dialogFieldConfig.dialogType = DialogType.bottomSheet;
  }
}
