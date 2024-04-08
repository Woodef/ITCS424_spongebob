import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserEditPasswordPage extends StatefulWidget {
  UserEditPasswordPage({Key? key}) : super(key: key);

  @override
  _UserEditPasswordPageState createState() => _UserEditPasswordPageState();
}

class _UserEditPasswordPageState extends State<UserEditPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  var _oldPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  bool _obscureText = true;
  String _message = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _oldPasswordController.text,
          );

          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(_newPasswordController.text);

          setState(() {
            _message = 'Password changed successfully';
          });
          _oldPasswordController.clear();
          _newPasswordController.clear();
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _message = e.message!;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Old Password',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your current password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'New Password',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'Enter your new password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    } else {
                      if (value.length < 6) {
                        return 'Your new password length must be >= 6.';
                      }
                      return null;
                    }
                  },
                ),
                Text(_message),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print(_newPasswordController.text);
                    print(_oldPasswordController.text);
                    _changePassword();
                    // Handle password change logic here
                  },
                  child: Text('Confirm Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
