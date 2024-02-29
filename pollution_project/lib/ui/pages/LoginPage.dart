import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    child: Column(children: [
                      FormBuilderTextField(
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
                      ),
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                        name: 'password',
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please insert password'),
                          FormBuilderValidators.minLength(6,
                              errorText: 'in length 6 characters'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, '/placeList');
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
                              Navigator.pushNamed(context, '/register');
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
