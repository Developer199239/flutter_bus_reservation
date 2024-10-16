import 'package:flutter/material.dart';

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
    _roleController.text = 'user'; // Default role
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to free resources
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
              ),
              _buildTextField(
                controller: _mobileController,
                label: 'Mobile',
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                focusNode: _mobileFocusNode,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on done
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
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
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
          return null;
        },
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final userData = {
        "userName": _userNameController.text,
        "password": _passwordController.text,
        "role": _roleController.text,
        "customer_name": _customerNameController.text,
        "email": _emailController.text,
        "mobile": _mobileController.text,
      };

      // Implement sign-up logic here
      print('User Data: $userData');

      // Show success message and navigate back or to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful')),
      );
      Navigator.pop(context);
    }
  }
}
