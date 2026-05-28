import 'package:flutter/material.dart';

void main() {
  runApp(const SafeVanApp());
}

class SafeVanApp extends StatelessWidget {
  const SafeVanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeVan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,

              children: [

                const SizedBox(height: 20),

                // LOGO
                Center(
                  child: Column(
                    children: [

                      Container(
                        height: 100,
                        width: 100,

                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:
                          BorderRadius.circular(25),
                        ),

                        child: const Icon(
                          Icons.directions_bus,
                          size: 60,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "SafeVan",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ROLE BOX
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius:
                    BorderRadius.circular(15),
                  ),

                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: const [

                      Row(
                        children: [

                          Icon(
                            Icons.people,
                            color: Colors.blue,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Signing in as Parent",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // PHONE FIELD
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,

                  decoration: InputDecoration(
                    hintText: "Phone Number",

                    prefixIcon:
                    const Icon(Icons.phone),

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // PASSWORD FIELD
                TextField(
                  controller: passwordController,
                  obscureText: true,

                  decoration: InputDecoration(
                    hintText: "Password",

                    prefixIcon:
                    const Icon(Icons.lock),

                    suffixIcon: const Icon(
                      Icons.visibility_off,
                    ),

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),

                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // GOOGLE BUTTON
                OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 35,
                    color: Colors.red,
                  ),

                  label: const Text(
                    "Login with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    minimumSize:
                    const Size(double.infinity, 60),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Forgot Your Password?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: const [

                    Text(
                      "Don’t Have an Account? ",
                    ),

                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),

                    SizedBox(width: 8),

                    Text(
                      "Change Language",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}