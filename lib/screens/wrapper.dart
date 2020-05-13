import 'package:coffeemaker/models/user.dart';
import 'package:coffeemaker/screens/authenticate/authenticate.dart';
import 'package:coffeemaker/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Getting type data User from the top provider
    final user = Provider.of<User>(context);

    // return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
