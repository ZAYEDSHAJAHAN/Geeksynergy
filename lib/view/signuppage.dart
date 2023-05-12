import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class UserSignupPage extends StatefulWidget {
  @override
  _UserSignupPageState createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _password = '';
  String _email = '';
  String _phone = '';
  String _profession = '';

  String dropdownvalue = 'Doctor';

  var items = [
    'Doctor',
    'Engineer',
    'Teacher',
    'Student',
  ];

  void _saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
    prefs.setString('password', _password);
    prefs.setString('email', _email);
    prefs.setString('phone', _phone);
    prefs.setString('profession', _profession);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Signup')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              DropdownButton(
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    _profession = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  }
                },
                child: Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
