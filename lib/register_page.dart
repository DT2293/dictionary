import 'package:dictionary/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  void _returnLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _register() {
    // Thêm logic đăng ký ở đây
    // Sau khi đăng ký thành công, điều hướng về trang đăng nhập
    _returnLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,color: Colors.blue),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Coming soon'),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity, // Make the button stretch horizontally
              height: 50, // Set a fixed height for the button
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Slightly rounded corners
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Register'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Make the button stretch horizontally
              height: 50, // Set a fixed height for the button
              child: ElevatedButton(
                onPressed: _returnLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Slightly rounded corners
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Return to Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
