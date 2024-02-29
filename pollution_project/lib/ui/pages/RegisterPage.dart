import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

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
                    key: formKey,
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
                        name: 'name',
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please insert name'),
                        ]),
                      ),
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
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, '/login');
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
