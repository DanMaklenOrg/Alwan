import 'package:flutter/material.dart';

class SubmitForm extends StatelessWidget {
  SubmitForm({
    Key? key,
    required this.formFields,
    required this.onFormSubmit,
    required this.submitActionLabel,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  })  : assert(secondaryActionLabel == null && onSecondaryAction == null || secondaryActionLabel != null && onSecondaryAction != null),
        super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Widget> formFields;

  final String submitActionLabel;
  final VoidCallback onFormSubmit;

  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...formFields,
            _buildSubmitButton(),
            if (onSecondaryAction != null) _buildSecondaryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                FormState state = _formKey.currentState!;
                if (state.validate()) {
                  state.save();
                  onFormSubmit();
                }
              },
              child: Text(submitActionLabel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onSecondaryAction,
        child: Text(
          secondaryActionLabel!,
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
