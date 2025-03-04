import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/states/user/user_bloc.dart';
import 'package:freight_ui/states/user/user_event.dart';
import 'package:freight_ui/ui/widgets/main_back_image.dart';
import 'package:freight_ui/ui/widgets/user_input_field.dart';

part 'sections/user_login.dart';
part 'sections/user_auth_login.dart';
part 'sections/user_sign_up.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _UserLogin()
        ],
      )
    );
  }
}

//
// class SimpleRegisterScreen extends StatefulWidget {
//   /// Callback for when this form is submitted successfully. Parameters are (email, password)
//   final Function(String? email, String? password)? onSubmitted;
//
//   const SimpleRegisterScreen({this.onSubmitted, Key? key}) : super(key: key);
//
//   @override
//   State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
// }
//
// class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
//   late String email, password, confirmPassword;
//   String? emailError, passwordError;
//   Function(String? email, String? password)? get onSubmitted =>
//       widget.onSubmitted;
//
//   @override
//   void initState() {
//     super.initState();
//     email = '';
//     password = '';
//     confirmPassword = '';
//
//     emailError = null;
//     passwordError = null;
//   }
//
//   void resetErrorText() {
//     setState(() {
//       emailError = null;
//       passwordError = null;
//     });
//   }
//
//   bool validate() {
//     resetErrorText();
//
//     RegExp emailExp = RegExp(
//         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
//
//     bool isValid = true;
//     if (email.isEmpty || !emailExp.hasMatch(email)) {
//       setState(() {
//         emailError = 'Email is invalid';
//       });
//       isValid = false;
//     }
//
//     if (password.isEmpty || confirmPassword.isEmpty) {
//       setState(() {
//         passwordError = 'Please enter a password';
//       });
//       isValid = false;
//     }
//     if (password != confirmPassword) {
//       setState(() {
//         passwordError = 'Passwords do not match';
//       });
//       isValid = false;
//     }
//
//     return isValid;
//   }
//
//   void submit() {
//     if (validate()) {
//       if (onSubmitted != null) {
//         onSubmitted!(email, password);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: ListView(
//           children: [
//             SizedBox(height: screenHeight * .12),
//             const Text(
//               'Create Account,',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: screenHeight * .01),
//             Text(
//               'Sign up to get started!',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black.withOpacity(.6),
//               ),
//             ),
//             SizedBox(height: screenHeight * .12),
//             InputField(
//               onChanged: (value) {
//                 setState(() {
//                   email = value;
//                 });
//               },
//               labelText: 'Email',
//               errorText: emailError,
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               autoFocus: true,
//             ),
//             SizedBox(height: screenHeight * .025),
//             InputField(
//               onChanged: (value) {
//                 setState(() {
//                   password = value;
//                 });
//               },
//               labelText: 'Password',
//               errorText: passwordError,
//               obscureText: true,
//               textInputAction: TextInputAction.next,
//             ),
//             SizedBox(height: screenHeight * .025),
//             InputField(
//               onChanged: (value) {
//                 setState(() {
//                   confirmPassword = value;
//                 });
//               },
//               onSubmitted: (value) => submit(),
//               labelText: 'Confirm Password',
//               errorText: passwordError,
//               obscureText: true,
//               textInputAction: TextInputAction.done,
//             ),
//             SizedBox(
//               height: screenHeight * .075,
//             ),
//             FormButton(
//               text: 'Sign Up',
//               onPressed: submit,
//             ),
//             SizedBox(
//               height: screenHeight * .125,
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: RichText(
//                 text: const TextSpan(
//                   text: "I'm already a member, ",
//                   style: TextStyle(color: Colors.black),
//                   children: [
//                     TextSpan(
//                       text: 'Sign In',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FormButton extends StatelessWidget {
//   final String text;
//   final Function? onPressed;
//   const FormButton({this.text = '', this.onPressed, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return ElevatedButton(
//       onPressed: onPressed as void Function()?,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }
//
// class InputField extends StatelessWidget {
//   final String? labelText;
//   final Function(String)? onChanged;
//   final Function(String)? onSubmitted;
//   final String? errorText;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final bool autoFocus;
//   final bool obscureText;
//   const InputField(
//       {this.labelText,
//       this.onChanged,
//       this.onSubmitted,
//       this.errorText,
//       this.keyboardType,
//       this.textInputAction,
//       this.autoFocus = false,
//       this.obscureText = false,
//       Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       autofocus: autoFocus,
//       onChanged: onChanged,
//       onSubmitted: onSubmitted,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: labelText,
//         errorText: errorText,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }
// }