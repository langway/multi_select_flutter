
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/common/multi_select_feild.dart';
import '../util/enums.dart';
import '../util/multi_select_dialog.dart';

class MultiSelectDialogFieldConfig<V> extends MultiSelectFieldConfig<V> {
  bool showButton;
  Decoration? buttonDecoration;

  DialogType? dialogType;

  /// panel that will be displayed on the dialog sheet.
  MultiSelectDialogConfig<V>? dialogConfig;

  MultiSelectDialogFieldConfig({
    super.panelConfig,
    super.title,
    super.buttonText,
    super.buttonIcon,
    super.onSelectionChanged,
    super.onConfirm,
    super.confirmText,
    super.cancelText,
    super.initialChildSize,
    super.minChildSize,
    super.maxChildSize,
    super.shape,
    super.barrierColor,
    super.backgroundColor,
    super.itemsTextStyle,
    super.selectedItemsTextStyle,
    super.separateSelectedItems = false,
    super.checkColor,
    super.isDismissible = false,
    super.state,
    super.itemViewTypeOn,
    super.searchable = false,
    super.searchHint,
    super.searchIcon,
    super.closeSearchIcon,
    super.searchTextStyle,
    super.searchHintStyle,
    this.dialogType = DialogType.dialog,
    super.showHeader = true,
    super.showItems = true,
    super.showErrors = true,
    super.headerDecoration,
    // super.itemsDecoration,
    super.errorsDecoration,
    this.showButton = true,
    this.buttonDecoration,
    this.dialogConfig,
  });

  /// Builds the button that opens the dialog.
  InkWell buildButton(
    BuildContext context,
    bool hasError,
    State state,
    FormFieldState<List<dynamic>> formFieldState,
  ) {
    final selectedValues = panelConfig!.selectedValues;
    Widget buttonChild;

    if (panelConfig!.itemViewType == ItemViewType.text) {
      buttonChild = buttonText ?? Text("Select");
    } else {
      buttonChild = Container(
        decoration:
            buttonDecoration ??
            BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:
                      hasError
                          ? Colors.red.shade800.withOpacity(0.6)
                          : selectedValues != null && selectedValues.isNotEmpty
                          ? (panelConfig!.selectedColor != null &&
                                  panelConfig!.selectedColor !=
                                      Colors.transparent)
                              ? panelConfig!.selectedColor!
                              : Theme.of(context).primaryColor
                          : Colors.black45,
                  width:
                      selectedValues != null && selectedValues.isNotEmpty
                          ? (hasError)
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
            buttonText ?? Text("Select"),
            buttonIcon ?? Icon(Icons.arrow_downward),
          ],
        ),
      );
    }

    return InkWell(
      onTap:
          dialogConfig != null
              ? () {
                if (dialogType == DialogType.bottomSheet) {
                  _showBottomSheet(context, state, formFieldState);
                  return;
                } else if (dialogType == DialogType.dialog) {
                  _showDialog(context, state, formFieldState);
                  return;
                }
              }
              : null,
      child: buttonChild,
    );
  }

  void _showDialog(
    BuildContext context,
    State state,
    FormFieldState<List<dynamic>> formFieldState,
  ) async {
    final result = await showDialog<String>(
      barrierColor: barrierColor,
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
              formFieldState: formFieldState,
              dialogConfig: dialogConfig!,
            ),
          ),
        );
      },
    );

    state.setState(() {});
  }

  void _showBottomSheet(
    BuildContext context,
    State state,
    FormFieldState<List<dynamic>> formFieldState,
  ) async {
    final result = await showModalBottomSheet<String>(
      isDismissible: isDismissible,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
          ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return MultiSelectDialog<V>(
          formFieldState: formFieldState,
          dialogConfig: dialogConfig!,
        );
      },
    );

    state.setState(() {});
  }
}

/// A customizable InkWell widget that opens the MultiSelectDialog
// ignore: must_be_immutable
class MultiSelectDialogField<V> extends FormField<List<V>> {
  MultiSelectDialogFieldConfig<V> dialogFieldConfig;

  MultiSelectDialogField({
    super.key,
    required this.dialogFieldConfig,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.initialValue = const [],
  }) : super(
         // 这里把 FormField<List<V>>传递给了 MultiSelectDialogFieldView<V>，
         builder: (FormFieldState<List<V>> state) {
           return _MultiSelectDialogFieldView<V>(
             formFieldState: state,
             dialogFieldConfiguration: dialogFieldConfig,
           );
         },
       );
}

// ignore: must_be_immutable
class _MultiSelectDialogFieldView<V> extends StatefulWidget {
  FormFieldState<List> formFieldState;

  MultiSelectDialogFieldConfig<V>? dialogFieldConfiguration;
  MultiSelectDialogFieldConfig<V> get fieldConfig => dialogFieldConfiguration!;

  _MultiSelectDialogFieldView({
    super.key,
    required this.formFieldState,
    required this.dialogFieldConfiguration,
  });

  @override
  State createState() => _MultiSelectDialogFieldViewState<V>();
}

class _MultiSelectDialogFieldViewState<V>
    extends State<_MultiSelectDialogFieldView<V>> {
  MultiSelectDialogFieldConfig<V> get fieldConfig => widget.fieldConfig;

  @override
  Widget build(BuildContext context) {
    /// 总共分成五个部分：
    /// 1. 标题部分（需区分是否可以搜索）
    /// 2. 按钮部分
    /// 3. 搜索面板部分（需区分是否可以搜索）
    /// 4. 选项面板部分
    /// 5. 错误信息部分

    final multiSelectPanel = fieldConfig.buildMultiSelectPanel();
    final selectedValues = fieldConfig.panelConfig!.selectedValues;

    final children = <Widget>[];
    if (fieldConfig.showHeader) {
      children.add(fieldConfig.buildHeader(this));
    }
    if (fieldConfig.showButton) {
      children.add(
        fieldConfig.buildButton(
          context,
          widget.formFieldState.hasError,
          this,
          widget.formFieldState,
        ),
      );
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
