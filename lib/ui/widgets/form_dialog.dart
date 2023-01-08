import 'package:alwan/ui/widgets/input_text_field.dart';
import 'package:alwan/ui/widgets/submit_form.dart';
import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  FormDialog({
    Key? key,
    required this.formFields,
    required this.submitActionLabel,
    required this.onFormSubmit,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Widget> formFields;
  final String submitActionLabel;
  final VoidCallback onFormSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Domain'),
      actions: [_buildSubmitButton()],
      content: Container(
        constraints: const BoxConstraints(minWidth: 300),
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: formFields),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        FormState state = _formKey.currentState!;
        if (state.validate()) {
          state.save();
          onFormSubmit();
        }
      },
      child: const Text('Save Progress'),
    );
  }
}
