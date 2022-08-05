import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '/screens/home.dart';
import 'package:flutter/material.dart';
import '/services/user.dart';
import '/screens/login.dart';
import '/models/user.dart';
import '/providers/user.dart';
import '/helpers/constants.dart';
import 'package:myuber2/widgets/header_widget.dart';

import 'dart:async';


import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';





class LoginScreens extends StatelessWidget {
//   UserModel _userModel;

// //  getter
//   UserModel get userModel => _userModel;
//   UserServices _userServices = UserServices();


    UserServices _userServices = UserServices();
    // UserProvider saveDeviceToken = UserProvider();

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String verificationId;
  String code;
//         FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseUser user = await _auth.currentUser();
  
FirebaseAuth _auth = FirebaseAuth.instance;

    reloadUserModel()async{
      print("reloadUserModel");
      final FirebaseUser user = await _auth.currentUser();
    _userModel = await _userServices.getUserById(user.uid);
    print(_userModel.id);
    return _userModel;

    
    
  }


Future<void> phoneLog(BuildContext context) async {
      UserProvider saveDeviceToken = Provider.of<UserProvider>(context, listen: false);
  final FirebaseUser user = await _auth.currentUser();
  if(user!=null){

    print("user!=null");
    print(user.uid);

    // await saveDeviceToken.saveDeviceToken();
    //     String deviceToken = await fcm.getToken();
    // print(deviceToken);
    // print("deviceToken");
    // if(deviceToken != null){
    //   _userServices.addDeviceToken(
    //       userId: user.uid,
    //       token: deviceToken
    //   );
    // }
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MyHomePage()
                        ));

}else{
  print("user is null");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginScreens()
                        ));
  
}
}
  

  Future<bool> loginUser(String phone, BuildContext context) async{
 
    FirebaseAuth _auth = FirebaseAuth.instance;

    // AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: this.code);

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;


          if(user != null){
             print("verificationCompleted=============================================================");
              print(user);
            
            print(user);

            Navigator.push(context, MaterialPageRoute(
              
              builder: (context) => LoginScreen()
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          this.verificationId = verificationId;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      this.code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: this.code);

                      AuthResult result = await _auth.signInWithCredential(credential);

                      FirebaseUser user = result.user;
                      var x=result.user.uid;
                      var y=result.user;
                     

                      if(user != null){
                        print("code sent=============================================================");
                        inspect(user);
                        print(x);
                                  _userServices.createUser(
          id: result.user.uid,
          name: ".",
          email: ".",
          phone: ".",
        );

                String deviceToken = await fcm.getToken();
    print(deviceToken);
    print("deviceToken");
    if(deviceToken != null){
      _userServices.addDeviceToken(
          userId: user.uid,
          token: deviceToken
      );
    }
                       
                        
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MyHomePage()
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }
  
@override
Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          HeaderWidget(height: mQ.height * 0.5),
          SizedBox(
            height: mQ.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Hello, nice to meet you!",
                  style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: mQ.height * 0.01),
                Text(
                  "Get moving with Green Taxi",
                  style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mQ.height * 0.05,
          ),
          Card(
            margin: EdgeInsets.only(left: 20, right: 20),
            elevation: 6.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(
                children: <Widget>[

                  Expanded(
                      flex: 2,
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your mobile number",
                          hintStyle: TextStyle(
                            color: Color(0xff303030),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onSubmitted: (e) {
                          Navigator.of(context).pushNamed(OtpPage.routeName);
                        },
                        keyboardType: TextInputType.number,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mQ.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'By creating an account, you agree to our',
                    style: TextStyle(
                      color: Color(0xff303030),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: ' Terms of Service',
                    style: TextStyle(
                      color: Color(0xff303030),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      color: Color(0xff303030),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xff303030),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  
}


















//   @override
//   Widget build(BuildContext context) {
     
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(32),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

//                   SizedBox(height: 16,),

//                   TextFormField(
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             borderSide: BorderSide(color: Colors.grey[200])
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             borderSide: BorderSide(color: Colors.grey[300])
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[100],
//                         hintText: "Mobile Number"

//                     ),
//                     controller: _phoneController,
//                   ),

//                   SizedBox(height: 16,),


//                   Container(
//                     width: double.infinity,
//                     child: FlatButton(
//                       child: Text("LOGIN"),
//                       textColor: Colors.white,
//                       padding: EdgeInsets.all(16),
//                       onPressed: () {
//                         final phone = _phoneController.text.trim();
//                         print(phone);

//                         loginUser(phone, context);

//                       },
//                       color: Colors.blue,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }

 
// }