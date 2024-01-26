import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/app_state.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:flutter/material.dart';

final class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  late AutovalidateMode autoValidateMode;

  @override
  void initState() {
    autoValidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
      title: 'Sign In',
      body: Form(
        key: _formKey,
        autovalidateMode: autoValidateMode,
        child: SizedBox(
          width: 500,
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'UserName'),
                  validator: (val) => val?.isEmpty ?? true ? 'This field is required!' : null,
                  onSaved: (val) => _username = val!,
                  autofillHints: const [AutofillHints.username],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (val) => val?.isEmpty ?? true ? 'This field is required!' : null,
                  onSaved: (val) => _password = val!,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.search,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _signIn,
                  child: const Text('Sign In'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    FormState state = _formKey.currentState!;
    if (state.validate()) {
      state.save();
      var apiClient = serviceProvider.get<ApiClient>();
      var appState = serviceProvider.get<AppState>();
      var response = await apiClient.signIn(SignInRequestDto(username: _username, password: _password));
      appState.auth.login(response.token);
    }
    setState(() => autoValidateMode = AutovalidateMode.onUserInteraction);
  }
}
