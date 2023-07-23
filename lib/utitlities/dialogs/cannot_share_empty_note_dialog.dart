import 'package:flutter/material.dart';
import 'package:flutter_application_2/utitlities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You Cannot Share Empty Note',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
