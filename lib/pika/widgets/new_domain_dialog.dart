import 'package:alwan/ui/widgets/form_dialog.dart';
import 'package:alwan/ui/widgets/input_text_field.dart';
import 'package:flutter/material.dart';

class NewDomainDialog extends StatefulWidget {
  const NewDomainDialog._({Key? key}) : super(key: key);

  static Future<String> show(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const NewDomainDialog._(),
    );
  }

  @override
  State<NewDomainDialog> createState() => _NewDomainDialogState();
}

class _NewDomainDialogState extends State<NewDomainDialog> {
  String? _domainName;

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      formFields: [InputTextField(label: 'Name', onSubmit: (value) => _domainName = value)],
      submitActionLabel: 'Add Domain',
      onFormSubmit: () => Navigator.of(context).pop(_domainName),
    );
  }
}
