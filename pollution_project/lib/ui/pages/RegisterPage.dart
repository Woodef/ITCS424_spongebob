import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _fullnameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  Future addUserDetails(String fullname, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'full_name': fullname,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

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
                    initialValue: {
                      'name': '',
                      'email': '',
                      'password': '',
                      'confirm_password': '',
                    },
                    child: Column(children: [
                      // Full name text field
                      FormBuilderTextField(
                        controller: _fullnameController,
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
                      const SizedBox(height: 15),
                      // Email text field
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
                      // Password text field
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
                          FormBuilderValidators.minLength(6,
                              errorText: 'in length 6 characters'),
                        ]),
                      ),
                      // Confirm password text field
                      FormBuilderTextField(
                        controller: _confirmpasswordController,
                        name: 'confirm_password',
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Comfirm Password',
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please insert password'),
                          FormBuilderValidators.minLength(6,
                              errorText: 'in length 6 characters'),
                          (val) {
                            if (passwordConfirmed()) {
                              return null;
                            }
                            return 'The field value must equal to password.';
                          }
                        ]),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () async {
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            // Authenticate user
                            try {
                              if (passwordConfirmed()) {
                                // Create user
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: _emailController.text
                                      .toLowerCase()
                                      .trim(),
                                  password: _passwordController.text.trim(),
                                );

                                // Add user details
                                addUserDetails(
                                  _fullnameController.text.trim(),
                                  _emailController.text.trim(),
                                );

                                Navigator.pushNamed(context, '/login');
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                              Navigator.pushNamed(context, '/register');
                            } catch (e) {
                              print(e);
                              Navigator.pushNamed(context, '/register');
                            }
                          } else {
                            print("validation failed");
                            Navigator.pushNamed(context, '/register');
                          }
                        },
                        child: const Text("Register",
                            style: TextStyle(color: Colors.black)),
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'I am a member!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'Login now',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
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
