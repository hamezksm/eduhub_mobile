// import 'package:eduhub_mobile/screens/onboarding_screen.dart';
import 'package:eduhub_mobile/firebase_options.dart';
import 'package:eduhub_mobile/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: const Text('Login'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/images/eduhub_logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('Login to continue using the app'),
                            const SizedBox(height: 20),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  // labelText: 'Email',
                                  hintText: 'Enter your email',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                autocorrect: false,
                                controller: _passwordController,
                                obscureText: !_passwordVisible,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  // labelText: 'Password',
                                  hintText: 'Enter your password',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: const Text(
                                    'Forgot Password?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue,
                                ),
                                foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white,
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50),
                                ),
                                maximumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                var emailAddress = _emailController.toString();
                                var password = _passwordController.toString();

                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Logging you in...'),
                                    ),
                                  );
                                  
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: emailAddress,
                                      password: password,
                                    );

                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => OnBoarding(
                                              welcomeMessage: 'logged in',
                                            )),
                                      ),
                                    );

                                    _emailController.clear();
                                    _passwordController.clear();
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      print('No user found with that email');
                                    } else if (e.code == 'wrong-password') {
                                      print('Wrong password provided for that user');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
