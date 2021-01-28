import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';

class EditProfile extends StatefulWidget {
  _ProfileEditPage createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool isLoading = false;
  String firstname;
  String lastname;
  String email;
  String phone;
  String address;

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Бүртгэл засах'),
          elevation: 1.0,
        ),
        body: Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Form(
                    key: _formKey,
                    child: Stack(children: [
                      ListView(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                          ))),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: Colors.green,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          buildFormField(
                              initialValue: "alex",
                              labelText: "Овог",
                              keyBoardType: TextInputType.text,
                              savedValue: firstname,
                              errorText: "овог хоосон байна!"),
                          buildFormField(
                            initialValue: "дашмягмар",
                            labelText: "Нэр",
                            keyBoardType: TextInputType.text,
                            savedValue: lastname,
                            errorText: "Нэр хоосон байна!",
                          ),
                          buildFormField(
                            initialValue: "cybordashaa@gmal.com",
                            labelText: "И-мэйл",
                            keyBoardType: TextInputType.emailAddress,
                            savedValue: email,
                            errorText: "И-мэйл хоосон байна!",
                          ),
                          buildFormField(
                            initialValue: "89142559",
                            labelText: "Утасны дугаар",
                            keyBoardType: TextInputType.phone,
                            savedValue: phone,
                            errorText: "Утасны дугаар хоосон байна!",
                          ),
                          buildFormField(
                            initialValue:
                                "Монгол улс, Улаанбаатар СүхБаатар Дүүрэг 56-р хороо",
                            labelText: "Хаяг",
                            keyBoardType: TextInputType.streetAddress,
                            savedValue: address,
                            isError: false,
                            maxLines: 4,
                          ),
                          // SizedBox(
                          //   height: 35,
                          // )
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            decoration: BoxDecoration(color: Colors.white),
                            child:
                                // OutlineButton(
                                //   padding: EdgeInsets.symmetric(horizontal: 50),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(20)),
                                //   onPressed: () {},
                                //   child: Text("ЦУЦЛАХ",
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           letterSpacing: 2.2,
                                //           color: Colors.black87)),
                                // ),
                                ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }
                                },
                                color: kPrimaryColor,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "Хадгалах",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ))
                    ])))));
  }

  Widget buildFormField({
    String initialValue,
    String labelText,
    String errorText,
    String savedValue,
    TextInputType keyBoardType,
    int maxLines = 1,
    bool isError = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        right: 30,
        left: 30,
      ),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        style: TextStyle(fontSize: 13),
        keyboardType: keyBoardType,
        onSaved: (newValue) => savedValue = newValue,
        onChanged: (value) {
          if (isError) {
            if (value.isNotEmpty) {
              removeError(error: errorText);
            }
          }
          return null;
        },
        validator: (value) {
          if (isError) {
            if (value.isEmpty) {
              return errorText;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kTextColor),
          ),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16),
          hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
