
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/common/multi_select_feild.dart';
import 'package:multi_select_flutter/util/enums.dart';
import '../util/multi_select_panel.dart';
// import '../util/multi_select_actions.dart';

class MultiSelectDialogConfig<V> extends MultiSelectFieldConfig<V> {
  bool showOpButtons;
  Decoration? buttonDecoration;

  DialogType? dialogType;

  MultiSelectDialogConfig({
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
    this.showOpButtons = true,
    this.buttonDecoration,
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
          panelConfig != null
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
              dialogConfig: this,
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
          dialogConfig: this,
        );
      },
    );

    state.setState(() {});
  }
}

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiSelectDialog<T> extends StatefulWidget {
  FormFieldState<List> formFieldState;

  MultiSelectDialogConfig<T> dialogConfig;
  bool showOpButtons = true;

  MultiSelectDialog({
    super.key,
    required this.formFieldState,
    required this.dialogConfig,
  });

  @override
  State createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  MultiSelectDialogConfig<T> get dialogConfig => widget.dialogConfig;
  @override
  Widget build(BuildContext context) {
    /// 总共分成五个部分：
    /// 1. 标题部分（需区分是否可以搜索）
    /// 2. 搜索面板部分（需区分是否可以搜索）
    /// 3. 选项面板部分
    /// 4. 操作按钮部分
    /// 5. 错误信息部分

    final multiSelectPanel = dialogConfig.buildMultiSelectPanel();
    final selectedValues = dialogConfig.panelConfig!.selectedValues;

    final children = <Widget>[];
    if (dialogConfig.showHeader) {
      children.add(dialogConfig.buildHeader(this));
    }

    if (dialogConfig.searchable) {
      children.add(dialogConfig.buildSearch(this));
    }

    if (dialogConfig.showItems) {
      children.add(multiSelectPanel);
    }

    if (dialogConfig.showOpButtons) {
      children.add(buildOpButtons(multiSelectPanel));
    }

    if (dialogConfig.showErrors && widget.formFieldState.hasError) {
      children.add(SizedBox(height: 5));

      children.add(dialogConfig.buildErrors(widget.formFieldState.errorText!));
    }

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );

    /// 区分 dialog 和 bottomSheet 两种类型的 dialog
    if (dialogConfig.dialogType == DialogType.dialog) {
      return Container(child: column);
    } else if (dialogConfig.dialogType == DialogType.bottomSheet) {
      return DraggableScrollableSheet(
        // should not set initialChildSize or maxChildSize
        // initialChildSize: widget.initialChildSize ?? 0.3,
        // maxChildSize: widget.maxChildSize ?? 0.6,
        minChildSize: dialogConfig.minChildSize ?? 0.3,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return column;
        },
      );
    }

    return Container();
  }

  buildOpButtons(Widget multiSelectPanel) {
    TextStyle buttonTextStyle = TextStyle(
      color:
          (dialogConfig.panelConfig!.selectedColor != null &&
                  dialogConfig.panelConfig!.selectedColor !=
                      Colors.transparent)
              ? dialogConfig.panelConfig!.selectedColor!.withOpacity(1)
              : Theme.of(context).primaryColor,
    );

    return Container(
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
              child:
                  dialogConfig.cancelText ??
                  Text("CANCEL", style: buttonTextStyle),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextButton(
              onPressed: () {
                if (dialogConfig.onConfirm != null) {
                  dialogConfig.onConfirm!(
                    dialogConfig.panelConfig!.selectedValues,
                  );
                }

                Navigator.pop(context, 'confirm');
              },
              child:
                  dialogConfig.confirmText ??
                  Text("OK", style: buttonTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
