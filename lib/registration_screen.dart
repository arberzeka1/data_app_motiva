import 'dart:convert';
import 'package:data_app_motiva/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:data_app_motiva/providers/registration_privider.dart';
import 'package:data_app_motiva/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Registrations>(context, listen: false)
          .postReservation(
        RegisterComponent(
          name: nameController.text,
          surname: surnameController.text,
          age: int.parse(ageController.text),
        ),
      )
          .then(
        (value) {
          nameController.clear();
          surnameController.clear();
          ageController.clear();
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Home();
              },
            ),
          );
        },
      );
    } catch (error) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'New Component',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Name*',
                          keyboardType: TextInputType.text,
                          errorText: nameController == null
                              ? 'Name is required'
                              : null,
                        ),
                        CustomTextField(
                          controller: surnameController,
                          hintText: 'Surname*',
                          keyboardType: TextInputType.text,
                          errorText: surnameController == null
                              ? 'Surname is required'
                              : null,
                        ),
                        CustomTextField(
                          controller: ageController,
                          hintText: 'Age*',
                          keyboardType: TextInputType.number,
                          errorText:
                              ageController == null ? 'Age is required' : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FlatButton(
                            onPressed: () async {
                              _saveForm();
                            },
                            child: const Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Save Registration',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void showToast1(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }
}
