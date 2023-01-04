import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  Map user = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 192, 106, 36),
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
            height: 300.0,
            width: 350.0,
            color: Colors.white60,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (value) {
                        user['email'] = value;
                        print(user['email']);
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
                            borderSide: BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        prefixIcon: Icon(
                          Icons.password_rounded,
                          color: Colors.grey[800],
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        user['password'] = value;
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
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: ElevatedButton(
                      
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow[900])),
                      onPressed: () {},
                      child: Text('Login'),
                    ),
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
