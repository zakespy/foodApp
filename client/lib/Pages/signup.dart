import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../Data/customer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map user = {
    'emailId': '',
    'password': '',
    'confirmPassword': '',
    'name': '',
    'phoneNo': '',
  };

  void signup() {
    Customer c1 = Customer();
    // print(user['emailId'] + user['password'] + user['name'] + user['phoneNo']);
    // c1.register(user['emailId'], user['password'], user['name'], user['phoneNo']);
    c1.register(user);
    Navigator.pop(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.yellow.shade800,
              Colors.yellow.shade700,
              Colors.yellow.shade500,
              Colors.yellow.shade400,
            ],
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white60,
            ),
            height: 500.0,
            width: 350.0,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        // prefixIcon: Icon(
                        //   Icons.email,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          user['emailId'] = value;
                        });
                        print(user['emailId']);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        // prefixIcon: Icon(
                        //   Icons.password_rounded,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          user['password'] = value;
                        });
                        print(user['password']);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Your password';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        // prefixIcon: Icon(
                        //   Icons.password_rounded,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          user['confirmPassword'] = value;
                        });
                        print(user['confirmPassword']);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Name',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        // prefixIcon: Icon(
                        //   Icons.password_rounded,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          user['name'] = value;
                        });
                        print(user['Name']);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Your Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Phone No',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        // prefixIcon: Icon(
                        //   Icons.password_rounded,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          user['phoneNo'] = value;
                        });
                        print(user['phoneNo']);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Your Phone Number';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow[900])),
                      onPressed: () {
                        // print(user);
                        // signup(user['emailId'], user['password'], user['name'],
                        //     user['phoneNo']);
                        signup();
                      },
                      child: Text('Sign Up'),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, '/');
                      },
                      child: Text("Already have account. Login")),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Color.fromARGB(255, 224, 147, 59),
      ),
    );
  }
}
