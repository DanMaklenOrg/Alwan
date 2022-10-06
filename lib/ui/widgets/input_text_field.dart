import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.label,
    required this.onSubmit,
    this.isSensitive = false,
  }) : super(key: key);

  final String label;
  final bool isSensitive;

  final FormFieldSetter<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onSaved: onSubmit,
        obscureText: isSensitive,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: (String? value) {
          if(value == null || value.isEmpty) return 'This field is required!';
          return null;
        },
      ),
    );
  }
}
