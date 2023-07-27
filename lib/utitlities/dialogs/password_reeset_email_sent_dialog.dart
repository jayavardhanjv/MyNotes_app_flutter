import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/utitlities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: 'Password Reset',
      content:
          'we now has sent you a password reset link.Please check your email for more information',
      optionsBuilder: () => {
            'OK': null,
          });
}
