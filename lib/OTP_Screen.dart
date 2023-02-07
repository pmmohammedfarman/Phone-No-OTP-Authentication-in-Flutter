import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'home.dart';

class OTPScreen extends StatefulWidget {
  final String phn;

  const OTPScreen({Key? key, required this.phn}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
 @override
  /*void initState() {
    super.initState();
    _listenOTP();
  }*/
  bool me = true;
 final FirebaseAuth _auth = FirebaseAuth.instance;
 String l = "";
 String otps = "";







 @override
  Widget build(BuildContext context) {

    if(me)
      {
        loginWithPhone(widget.phn);

      }


    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(top: 180),
                  child: Icon(
                    Icons.sms_outlined,
                    size: 60,
                    color: Colors.white,
                  )),
              const Text(
                "Sit back & Relax while we verify your  ",
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "mobile number",
                style: TextStyle(color: Colors.white),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              const Text(
                "(Enter the OTP below in case if we fail to detect the ",
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "SMS automatically)",
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 35),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //color: Colors.white,

                        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2,),borderRadius: BorderRadius.circular(10)),

                        //padding: const EdgeInsets.all(3),
                        child: PinFieldAutoFill(

                          codeLength: 6,
                          onCodeChanged: (val) {
                            if(val!=null && val.length>=6)
                              {
                                otps = val.toString();

                              }
                            print(val);

                          },

                        ),
                      ),
                      // PinFieldAutoFill(
                      //   //currentCode: codevalue,
                      //   codeLength: 4,
                      //   onCodeChanged: (code){
                      //     print(code);
                      //     setState(() {
                      //       //codevalue=code.toString();
                      //     });
                      //   },
                      // ),
                      /*Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2,),borderRadius: BorderRadius.circular(10)),

                      ),
                      Padding(padding: EdgeInsets.all(3)),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2,),borderRadius: BorderRadius.circular(10)),
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2,),borderRadius: BorderRadius.circular(10)),
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2,),borderRadius: BorderRadius.circular(10)),
                      ),*/
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 160,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    if(otps.length>=0)
                      {
                        verifyOTP(otps,l);

                      }

                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Please wait for OTP",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              const Text(
                "Remainig Time for OTP expiry",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
 void loginWithPhone(String phoneNumber) async {
   // TextEditingController phoneController = TextEditingController(text: widget.phn);
   /*TextEditingController otpController = TextEditingController();

   FirebaseAuth auth = FirebaseAuth.instance;

   bool otpVisibility = false;

   String verificationID = "";

   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
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
       //setState(() {});
     },
     codeAutoRetrievalTimeout: (String verificationId) {

     },
   );
   //   final signcode = await SmsAutoFill().getAppSignature;
   // print(signcode);*/
   final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) {
     _auth.signInWithCredential(credential);
     print("Verified");
   };

   final PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception) {
     print('${exception.message}');
   };

  /* final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) {
     print("Code sent to $phoneNumber");
   };*/
   final PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken]){
     print("Code sent to $phoneNumber");
     l = verificationId;

   };

   final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
     print("Time out");
   };

   await _auth.verifyPhoneNumber(
     phoneNumber: phoneNumber,
     timeout: const Duration(seconds: 60),
     verificationCompleted: verificationCompleted,
     verificationFailed: verificationFailed,
     codeSent: codeSent,
     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
   );
   me = false;
 }

  void verifyOTP(smsCode, verificationId) async {
   // TextEditingController otpController = TextEditingController();

   // FirebaseAuth auth = FirebaseAuth.instance;

   // bool otpVisibility = false;

    String verificationID = verificationId;
    AuthCredential credentials = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,

    );

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: smsCode);

     _auth.signInWithCredential(credential).then((UserCredential userCredential) {
      print("You are logged in successfully");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyHome()));

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

  void _listenOTP() async {
    await SmsAutoFill().listenForCode();
  }
}
