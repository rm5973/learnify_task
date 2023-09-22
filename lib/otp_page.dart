import 'package:flutter/material.dart';
import 'package:learnify_task/Login_page.dart';

class OTPVerificationPage extends StatelessWidget {
  final String phoneNumber;
  final String countryCode;
  OTPVerificationPage({required this.phoneNumber, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OTPVerificationForm(
        phoneNumber1: phoneNumber,
        countryCode1: countryCode,
      ),
    );
  }
}

class OTPVerificationForm extends StatefulWidget {
  final String phoneNumber1;
  final String countryCode1;

  OTPVerificationForm({required this.phoneNumber1, required this.countryCode1});
  @override
  _OTPVerificationFormState createState() => _OTPVerificationFormState();
}

class _OTPVerificationFormState extends State<OTPVerificationForm> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();

  Color _borderColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    _otpController1.addListener(() {
      if (_otpController1.text.length == 1) {
        _focusNode1.unfocus();
        FocusScope.of(context).requestFocus(_focusNode2);
      }
    });

    _otpController2.addListener(() {
      if (_otpController2.text.length == 1) {
        _focusNode2.unfocus();
        FocusScope.of(context).requestFocus(_focusNode3);
      }
    });

    _otpController3.addListener(() {
      if (_otpController3.text.length == 1) {
        _focusNode3.unfocus();
        FocusScope.of(context).requestFocus(_focusNode4);
      }
    });
  }

  void _verifyOTP() {
    String otp = _otpController1.text +
        _otpController2.text +
        _otpController3.text +
        _otpController4.text;

    if (otp == '1234') {
      setState(() {
        _borderColor = Colors.green;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Your details have been submitted.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Future.delayed(Duration(seconds: 2), () {
                    // Reset the border color
                    setState(() {
                      _borderColor = Colors.transparent;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginPage(),
                      ),
                    );
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _borderColor = Colors.red;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please enter a valid OTP.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = screenWidth * 0.8;
    double imageHeight = MediaQuery.of(context).size.height * 0.4;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              'Enter OTP',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    0.3 * imageWidth), // 30% round corners
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), // 5% transparency
                    BlendMode.srcOver,
                  ),
                  child: Image.asset(
                    'images/photo1.png', // Replace with your asset image path
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'sucessfully otp sent to  ${widget.countryCode1} ${widget.phoneNumber1}',
              style: TextStyle(fontSize: 18, color: (Colors.grey)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildOTPDigitField(_otpController1, _focusNode1),
                _buildOTPDigitField(_otpController2, _focusNode2),
                _buildOTPDigitField(_otpController3, _focusNode3),
                _buildOTPDigitField(_otpController4, _focusNode4),
              ],
            ),
            SizedBox(height: 40),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                onPressed: _verifyOTP,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    alignment: Alignment.center,
                    child: Text('Verify OTP')),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
                width: MediaQuery.of(context).size.width *
                    0.5, // Match the button width
                child: Text(
                  'By signing up you agree to our terms and conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildOTPDigitField(
      TextEditingController controller, FocusNode focusNode) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counter: Offstage(),
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
