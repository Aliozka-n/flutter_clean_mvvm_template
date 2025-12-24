import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_border_radius.dart';
import '../common_widgets/button_widget.dart';
import '../common_widgets/text_field_widget.dart';

/// Alert dialog utility widget
class AlertDialogWidget {
  AlertDialogWidget._();

  /// Success dialog
  static void showSuccessfulDialog(
    BuildContext context,
    String message, {
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.large(),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.successColor),
            const SizedBox(width: AppSizes.sizeSmall),
            const Text('Success'),
          ],
        ),
        content: Text(message),
        actions: [
          ButtonWidget(
            textTitle: 'OK',
            onTap: () {
              Navigator.pop(context);
              onOk?.call();
            },
            width: 100,
            height: 40,
          ),
        ],
      ),
    );
  }

  /// Error dialog
  static void showErrorDialog(
    BuildContext context,
    String message, {
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.large(),
        ),
        title: Row(
          children: [
            Icon(Icons.error, color: AppColors.errorColor),
            const SizedBox(width: AppSizes.sizeSmall),
            const Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          ButtonWidget(
            textTitle: 'OK',
            onTap: () {
              Navigator.pop(context);
              onOk?.call();
            },
            width: 100,
            height: 40,
            color: AppColors.errorColor,
          ),
        ],
      ),
    );
  }

  /// Confirmation dialog
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String message, {
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.large(),
        ),
        title: const Text('Confirm'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ButtonWidget(
            textTitle: confirmText,
            onTap: () {
              Navigator.pop(context, true);
              onConfirm?.call();
            },
            width: 100,
            height: 40,
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Input dialog
  static Future<String?> showInputDialog(
    BuildContext context,
    String title,
    TextFieldWidget textField, {
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
  }) async {
    final controller = textField.textController ?? TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.large(),
        ),
        title: Text(title),
        content: textField.textController == null
            ? TextFieldWidget(
                textTitle: '',
                textController: controller,
              )
            : textField,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
          ButtonWidget(
            textTitle: confirmText,
            onTap: () {
              Navigator.pop(context, controller.text);
              onConfirm?.call();
            },
            width: 100,
            height: 40,
          ),
        ],
      ),
    );
    return result;
  }
}

