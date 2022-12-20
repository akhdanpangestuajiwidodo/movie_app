import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/auth_bloc.dart';
import 'package:movie_app/blocs/auth_event.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null && value.length < 6
                                ? "Enter min. 6 characters"
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Sign Up'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Text("Already have an account?"),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Sign In"),
                ),
                const Text("Or"),
                IconButton(
                  onPressed: () {},
                  icon: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authenticatedWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(SignUpEvent(_emailController.text, _passwordController.text));
    }
  }

  void _autenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInEvent());
  }
}
