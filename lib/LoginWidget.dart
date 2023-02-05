import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_sms/flutter_sms.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatefulWidget {
  final String phn;
  const LoginWidget({Key? key, required this.phn}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {



  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";


  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController(text: widget.phn);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.phone,
            ),

            Visibility(child: TextField(
              controller: otpController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),visible: otpVisibility,),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if(otpVisibility){
                    verifyOTP();
                  }
                  else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    // TextEditingController phoneController = TextEditingController(text: widget.phn);

    auth.verifyPhoneNumber(
      phoneNumber: widget.phn,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHome()));

        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  void verifyOTP() async {

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value){
      print("You are logged in successfully");
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHome()));

      /* Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );*/
    });
  }
}