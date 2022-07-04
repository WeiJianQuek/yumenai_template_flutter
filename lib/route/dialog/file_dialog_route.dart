import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileDialogRoute {
  static Future<List<File>> select(final BuildContext context, {
    final String? title,
    final bool enableMultipleSelection = false,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: enableMultipleSelection,
    );

    if (result != null) {
      final fileList = <File> [];

      for (final file in result.files) {
        if (file.path?.isNotEmpty ?? false) {
          fileList.add(File(file.path ?? ''));
        }
      }

      return fileList;
    }

    return [];
  }

  const FileDialogRoute._();
}