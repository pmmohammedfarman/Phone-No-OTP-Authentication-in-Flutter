import 'package:authentication/OTP_Screen.dart';
import 'package:authentication/home.dart';
import 'package:flutter/material.dart';
import 'package:authentication/LoginWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
          home: SignIn(),),

  );
}
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  //final UserCredential userCredential =
  //UserCredential(usernameOrEmail: '', password: '');
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  bool istrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: setUserForm()
    );

  }
  Widget setUserForm() {
    return Stack(children: <Widget>[
      // Background with gradient
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red, Colors.blue])),
          height: MediaQuery.of(context).size.height * 0.3
      ),
      //Above card
      Card(

        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
        ),
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
        child: Column(children:<Widget> [
          Center(
            child: Text("Welcome",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:  Theme
                .of(context)
                .colorScheme
                .primary,),),
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Phone Number",style: TextStyle(color: Colors.pink,fontSize: 14),)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                // ),
                // onTap: ()async{
                //   DateTime?pickeddate=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                //   if(pickeddate!=null){
                //     setState((){
                //
                //       _controller1.text=DateFormat.yMMMMEEEEd().format(pickeddate);
                //     });
                //   }
                // },
              ),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Name",style: TextStyle(color: Colors.pink,fontSize: 14),)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              autofocus: true,
              controller: _controller1,
              decoration: const InputDecoration(
                hintText: "Name",

                // ),
                // onTap: ()async{
                //   DateTime?pickeddate=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                //   if(pickeddate!=null){
                //     setState((){
                //
                //       _controller1.text=DateFormat.yMMMMEEEEd().format(pickeddate);
                //     });
                //   }
                // },
              ),),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color:Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),

              child: TextButton(onPressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => OTPScreen(phn: _controller.text,)));
              },child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),

            ),
          )

        ],),
      ),
      // Positioned to take only AppBar size
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: AppBar(
          // Add AppBar here only
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: Text("OYA Basket",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
        ),
      ),

    ]);
  }


}



