import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodapp/Data/customer.dart';
import '../Data/customer.dart';
import '../storage.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  Map user = {'emailId': '', 'password': ''};

  Map response = {};

  @override
  Widget build(BuildContext context) {
    Customer customer = Customer();

    Future<List> result = customer.getAllCustomer();
    print(result);

    Future<void> login() async {
      response = (await customer.login(user))!;
      final secureStorage store = secureStorage();
      print("***************");
      // print(response);
      String? id = await store.getId();
      String? token = await store.getToken();
      print("id "+id!);
      print("token "+token!);
      // print(store.getId());
      // print(store.getToken());

      response['status'] ? Navigator.pushReplacementNamed(context, '/home'):'';
    }

    // return Container(
    //     child: FutureBuilder<List>(
    //   future: customer.getAllCustomer(),
    //   builder: (context, snapshot) {
    //     print(snapshot.data);
    //     return Container();
    //   },
    // ));

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
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey[800],
                        ),
                      ),
                      onChanged: (value) {
                        user['emailId'] = value;
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade600)),
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
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow[900])),
                      onPressed: () {
                        login();
                      },
                      child: Text('Login'),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text("Don't have account. Sign Up")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
