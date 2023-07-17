import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/utitlities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Delete',
      content: 'Are you sure you want todelete this item?',
      optionsBuilder: () => {
            'cancel': false,
            'Yes': true,
          }).then(
    (value) => value ?? false,
  );
}
