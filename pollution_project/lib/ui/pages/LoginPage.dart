import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pollution_project/models/user.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.toLowerCase().trim(),
        password: _passwordController.text.trim(),
      );
      var user = context.read<UserModel>();
      await user.reset();
      await user.setEmail(_emailController.text.toLowerCase().trim());
      await user.setFullname();
      await user.setPlacesFromSavedPlaces();
      Navigator.pushReplacementNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Invalid login';
      });
      print(_errorMessage);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var user = context.read<UserModel>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Air Pollution',
                  style: GoogleFonts.birthstone(
                      textStyle: TextStyle(
                          fontSize: 30, color: theme.colorScheme.background)),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: {'email': '', 'password': ''},
                    child: Column(children: [
                      FormBuilderTextField(
                        controller: _emailController,
                        name: 'email',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please insert email'),
                          FormBuilderValidators.email(),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                        controller: _passwordController,
                        name: 'password',
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please insert password'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                print(_emailController.text.trim());
                                await signIn();
                              } else {
                                print("validation failed");
                              }
                            },
                            child: const Text("Log in",
                                style: TextStyle(color: Colors.black)),
                            color: Colors.white,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register');
                            },
                            child: Text('Sign up',
                                style: TextStyle(color: Colors.black)),
                            color: Colors.white,
                          ),
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
