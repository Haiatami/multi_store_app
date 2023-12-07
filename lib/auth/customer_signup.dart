import 'package:flutter/material.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeaderLabel(
                    headerLabel: 'Sign Up',
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 40,
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print('pick image from camera');
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print('pick image from camera');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Full Name',
                        hintText: 'Enter Full Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Email Address',
                        hintText: 'Enter Your Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                      ),
                    ),
                  ),
                  HaveAccount(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Material(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(25),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Already have account ?',
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Log In',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class AuthHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const AuthHeaderLabel({
    Key? key,
    required this.headerLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
            icon: const Icon(
              Icons.home_work,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter Full Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.purple,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.deepPurpleAccent,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(25),
  ),
);
