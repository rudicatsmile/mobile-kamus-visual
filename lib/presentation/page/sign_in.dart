// import 'package:antrianapprsud/constants.dart';
// import 'package:antrianapprsud/controllers/sign_in_login_controller.dart';
// import 'package:antrianapprsud/entities/antrian_model.dart';
// import 'package:antrianapprsud/entities/dbhelper.dart';
// import 'package:antrianapprsud/entities/detail_antrian_model.dart';
// import 'package:antrianapprsud/entities/get_one_pasien_model.dart';
// import 'package:antrianapprsud/entities/pasien_model.dart';
// import 'package:antrianapprsud/screens/home.dart';
// import 'package:antrianapprsud/services/api_service.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/source/source_user.dart';
// import '../find_dtks.dart';
import '../profile_page.dart';
import 'register_page.dart';

// import '../Queue/formInputDataSosial.dart';

class SignInLogin extends StatefulWidget {
  const SignInLogin();

  @override
  State<SignInLogin> createState() => _SignInLoginState();
}

class _SignInLoginState extends State<SignInLogin> {
  Color? myColor;
  Size? mediaSize;
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  void login() async {
    bool success = await SourceUser.login(
      idController.text,
      passwordController.text,
    );
    if (success) {
      //DInfo.dialogSuccess(context, 'Login Success');
      // DInfo.closeDialog(context, actionAfterClose: () {
      //   DMethod.printTitle('Level User', cUser.data.level ?? '');
      //   if (cUser.data.level == 'Employee' &&
      //       controllerPassword.text == '123456') {
      //     //changePassword();
      //     Get.off(() => const DashboardPage());
      //   } else {
      //     Get.off(() => const DashboardPage());
      //   }
      // });
      // Get.off(() => const DashboardPage());
      //DInfo.closeDialog(context,);
      //  Get.off(() => const DashboardPage());
      Get.off(() => ProfilePage());
    } else {
      DInfo.dialogError(context, 'Login failed');
      DInfo.closeDialog(context);
    }
  }

  // final SignInLoginController loginC = Get.put(SignInLoginController());
  TextEditingController nikController = new TextEditingController();
  // PostResultGetOnePasien? postResultGetOnePasien = null;

  //Validator input text
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          color: myColor,
          image: DecorationImage(
            image: const AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor!.withOpacity(0.9), BlendMode.dstATop),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ]),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize!.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icon/icon.png",
            width: 400.0,
            height: 80.0,
          ),
          const Text(
            "Visual Dictionary",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize!.width,
      child: Card(
        color: Colors.white70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selamat Datang",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Aplikasi Visual Dictionary Onine"),
        const SizedBox(height: 60),
        // _buildGreyText("Masukan NIK disini"),
        _buildInputField(idController),
        const SizedBox(height: 40),
        // _buildGreyText("Password"),
        _buildInputField(passwordController,isPassword: true),
        // const SizedBox(height: 20),
        // _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 60),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black87),
    );
  }

  Widget _buildInputField(TextEditingController controller, {isPassword = false}) {
    // return TextField(
    //   controller: controller,
    //   decoration: InputDecoration(
    //     suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
    //   ),
    //   obscureText: isPassword,
    // );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all()),
      child: TextFormField(
        // keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Tidak boleh kosong';
          }
          // int? calories = int.tryParse(value);

          // if (calories == null || calories <= 0) {
          //   return 'Silahkan isi dengan angka';
          // }

          // if (calories.toString().length < 16) {
          //   return 'Format NIK 16 angka.';
          // }

          return null;
        },
        controller: controller,
        decoration: const InputDecoration(
            // fillColor: Colors.blueAccent,
            hintText: "Silahkan di isi",
            //suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () => login(),
          // onPressed: () {
          //   if (_formKey.currentState!.validate()) {
          //     var aa = 1;
          //     if (aa==1) {
          //     // if (loginC.isLoading.isFalse) {
          //       DMethod.printTitle('CEK LOGIN:  ', ' CEK 0 => onpressed');
              
          //       //getOnePasien(context);
          //       // loginC.getDetailDataCOntroller(context);
          //     } else {
          //       DMethod.printTitle('CEK LOGIN:  ', ' CEK 0 => not onpressed');
          //     }
          //   }
          // },
          // {
          //   debugPrint("Email : ${idController.text}");
          //   debugPrint("Password : ${passwordController.text}");
          // },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 15,
            shadowColor: myColor,
            minimumSize: const Size.fromHeight(60),
          ),
          child:  Text(
            //loginC.isLoading.isFalse ? "Login" : "Loading ....",
            "Login",
            style:  TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
           //_buildGreyText("Pendaftaran pasien baru"),

           InkWell(
               onTap: () {
                 // Navigator.push(
                 //   context,
                 //   MaterialPageRoute(builder: (context) {
                 //     return FormInputDataSosial();
                 //   }),
                 // );
                 Get.to(const RegisterPage());
               },
               child: const Text(
                 "Pendaftaran",
                 style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                     fontSize: 17),
               )),

          // const SizedBox(height: 10),
          //  Row(
          //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //    children: [
          //      Tab(icon: Image.asset("assets/images/facebook.png")),
          //      Tab(icon: Image.asset("assets/images/twitter.png")),
          //      Tab(icon: Image.asset("assets/images/github.png")),
          //    ],
          //  )
        ],
      ),
    );
  }

  

  void showMessage(context, String dTitle, String dMessage) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dTitle),
      content: Text(dMessage),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
