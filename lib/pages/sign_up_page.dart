import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../models/sign_up_model.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  // FocusNodes to control field navigation
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _customerNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _roleController.text = 'User'; // Default role
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    _customerNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _customerNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              _buildTextField(
                controller: _userNameController,
                label: 'Username',
                icon: Icons.person_2_outlined,
                focusNode: _userNameFocusNode,
                nextFocusNode: _passwordFocusNode,
              ),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: isObscure,
                isPassword: true,
                focusNode: _passwordFocusNode,
                nextFocusNode: _customerNameFocusNode,
              ),
              _buildTextField(
                controller: _roleController,
                label: 'Role',
                icon: Icons.group,
                readOnly: true,
              ),
              _buildTextField(
                controller: _customerNameController,
                label: 'Customer Name',
                icon: Icons.person_outline,
                focusNode: _customerNameFocusNode,
                nextFocusNode: _emailFocusNode,
              ),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                nextFocusNode: _mobileFocusNode,
                emailValidation:
                    true, // Add this parameter to enable email validation
              ),
              _buildTextField(
                controller: _mobileController,
                label: 'Mobile',
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                focusNode: _mobileFocusNode,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool isPassword = false,
    bool readOnly = false,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextInputAction textInputAction = TextInputAction.next,
    VoidCallback? onEditingComplete,
    bool emailValidation = false, // New parameter to enable email validation
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          filled: true,
          labelText: label,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete ??
            () {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field must not be empty';
          }
          if (emailValidation) {
            const emailPattern =
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Basic email pattern
            final regExp = RegExp(emailPattern);
            if (!regExp.hasMatch(value)) {
              return 'Enter a valid email';
            }
          }
          return null;
        },
      ),
    );
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      SignUpModel signUpModel = SignUpModel(
          userName: _userNameController.text,
          password: _passwordController.text,
          role: _roleController.text,
          customerName: _customerNameController.text,
          email: _emailController.text,
          mobile: _mobileController.text);
      print('User Data: ${signUpModel.toString()}');

      EasyLoading.show(status: 'Signup user...');
      final response =
          await Provider.of<AppDataProvider>(context, listen: false)
              .signup(signUpModel);
      EasyLoading.dismiss();
      if (response != null && response.responseStatus == ResponseStatus.SAVED) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful')),
        );
        Navigator.pop(context);
      } else {
        var msg = response?.message ?? "Sign up failed";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    }
  }
}
