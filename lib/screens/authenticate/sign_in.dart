import 'package:coffeemaker/services/auth.dart';
import 'package:coffeemaker/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text('Sign In To Coffee Maker'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text("Register"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'E-Mail'),
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val){
                  setState(() {
                    return email = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter 6+ Character Password' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    return password = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.blueAccent[400],
                child: Text("Sign In",
                style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  setState(() {
                    return loading = true;
                  });
                  if(_formKey.currentState.validate()){
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        loading = false;
                        error = 'Error Signing In';
                      });
                    }
                  }
                  else {
                  }
                },
              ),
              SizedBox(height: 12,),
              Text(error,style: TextStyle(color: Colors.red, fontSize: 14.0),),
            ],
          ),
        ),
      ),
    );
  }
}
