import 'dart:io';
import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(String, String, String, File?, bool, BuildContext)
      _onSubmit;

  AuthForm(this._onSubmit);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImage;

  void _pickedImage(File image) {
    _userImage = image;
  }

  var _isLogin = true;

  Future<void> _trySubmit() async {
    final state = _formKey.currentState;
    if (state == null) {
      return;
    }

    FocusScope.of(context).unfocus();

    if (!_isLogin && _userImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick an image'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return;
    }


    final isValid = state.validate();
    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    state.save();

    try {
      await widget._onSubmit(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImage,
        _isLogin,
        context,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(onPick: _pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    onSaved: (value) => _userEmail = value ?? '',
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      onSaved: (value) => _userName = value ?? '',
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (value) => _userPassword = value ?? '',
                    validator: (value) {
                      if (value == null || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  if (!_isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!_isLoading)
                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have in account'),
                    ),
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(child: CircularProgressIndicator()),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
