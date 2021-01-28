import 'package:flutter/material.dart';
import 'package:ira_app/screens/profile_screen/profile_edit/edit_profile.dart';
import '../profile_edit/register_number_edit.dart';
import '../profile_edit/change_password.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool value = true;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          title: Text('Тохиргоо'),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Color(0xFFF5F6F9),
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: ListTile(
                    title: Text('Хувийн мэдээлэл',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  title: Text('Бүртгэл засах',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54)),
                  leading: SizedBox(
                      height: 25, width: 30, child: Icon(Icons.account_circle)),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Text(
              //     "Нууцлал",
              //     style: TextStyle(fontSize: 16, fontFamily: 'Roboto-Regular'),
              //   ),
              // ),
              Card(
                color: Color(0xFFF5F6F9),
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: ListTile(
                    title: Text('Нууцлал',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  title: Text('нууц үг солих',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54)),
                  leading: SizedBox(
                      height: 25,
                      width: 30,
                      child: Icon(
                        Icons.lock_rounded,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangePasswordProfile()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  title: Text('Регистрийн дугаар солих',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54)),
                  leading: SizedBox(
                      height: 25, width: 30, child: Icon(Icons.info_rounded)),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditRegister()));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
