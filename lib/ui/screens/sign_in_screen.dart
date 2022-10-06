import 'package:alwan/api/dto/request/sign_in_dto.dart';
import 'package:alwan/services.dart';
import 'package:alwan/ui/common/primary_scaffold.dart';
import 'package:alwan/ui/widgets/input_text_field.dart';
import 'package:alwan/ui/widgets/submit_form.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      title: 'Sign In',
      body: SubmitForm(
        formFields: [
          InputTextField(
            label: 'Username',
            onSubmit: (String? value) => _username = value,
          ),
          InputTextField(
            label: 'Password',
            onSubmit: (String? value) => _password = value,
            isSensitive: true,
          ),
        ],
        submitActionLabel: 'Sing In',
        onFormSubmit: () async {
          await Services.anaClient.signIn(SignInRequestDto(username: _username!, password: _password!));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
