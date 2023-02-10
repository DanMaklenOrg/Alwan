import 'package:alwan/ui/widgets/form_dialog.dart';
import 'package:alwan/ui/widgets/input_text_field.dart';
import 'package:flutter/material.dart';

class NewEntityDialog extends StatefulWidget {
  const NewEntityDialog._({Key? key}) : super(key: key);

  static Future<String> show(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const NewEntityDialog._(),
    );
  }

  @override
  State<NewEntityDialog> createState() => _NewEntityDialogState();
}

class _NewEntityDialogState extends State<NewEntityDialog> {
  String? _domainName;

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      formFields: [InputTextField(label: 'Name', onSubmit: (value) => _domainName = value)],
      submitActionLabel: 'Add Entity',
      onFormSubmit: () => Navigator.of(context).pop(_domainName),
    );
  }
}
