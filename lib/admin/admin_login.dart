import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/admin/add_wallpaper.dart';
import 'package:wallpaper/core/app_colors.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> gKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Stack(children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20, left: 14, right: 14),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        AppColors.info,
                        AppColors.primary.withOpacity(0.9),
                      ]),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Form(
                    key: gKey,
                    child: Column(
                      children: [
                        Text(
                          "Admin Login",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            height: MediaQuery.of(context).size.height / 2.1,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  padding: EdgeInsets.only(
                                      left: 10, bottom: 5, top: 5),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                ),
                                TextFormField(
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter the username';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "username",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)))),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                    controller: passController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter the password';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)))),
                                SizedBox(
                                  height: 35,
                                ),
                                InkWell(
                                  onTap: () {
                                    loginAdmin();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    width:
                                        MediaQuery.of(context).size.width / 0.7,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      "login",
                                      style: TextStyle(
                                          fontSize: 20, color: AppColors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ])));
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admins").get().then((snanpshot) {
      snanpshot.docs.forEach((res) {
        if (res.data()['id'] != usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.accent,
              content: Text("Your id not correct")));
        }

        if (res.data()['password'] != passController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.accent,
              content: Text("Your password not correct")));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddWallpaper()));
        }
      });
    });
  }
}
