import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasklist_app/func.dart';
import 'package:tasklist_app/main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with Func {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create New Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Your new password must be different from the old password.',
                ),
                TextFormField(
                  controller: oldPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Old Password',
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          oldPassword.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter old password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: newPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter New Password',
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          newPassword.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter new password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          confirmPassword.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm new password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed:
                        // !_formKey.currentState!.validate()
                        //     ? () {}
                        //     :
                        () async {
                      if (_formKey.currentState!.validate()) {
                        if (newPassword.text == confirmPassword.text) {
                          // Note: server generates a 404; TODO
                          bool hasUpdated = await updateUserUsingBasic(
                            context,
                            customProvider.user['id'],
                            customProvider.user['name'],
                            customProvider.user['username'],
                            newPassword.text,
                            oldPassword.text,
                          );
                          if (context.mounted && hasUpdated) {
                            Navigator.pushNamed(context, '/sign-in');
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'New Password and Confirm Password do not match!',
                              ),
                            ),
                          );
                        }
                      }
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
