import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login dan Registrasi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

// Dashboard
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading:
            false, // Untuk menghilangkan tombol back jika ini halaman utama setelah login
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat Datang di Dashboard!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Anda bisa menambahkan logika logout di sini
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ), // Kembali ke halaman login
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        // Logika Login
        print('Login Email: ${_emailController.text}');
        print('Login Password: ${_passwordController.text}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        /* JANGAN ADA BARIS KODE SNACKBAR LOGIN DI SINI */
      } else {
        // Logika Registrasi
        if (_passwordController.text == _confirmPasswordController.text) {
          print('Register Email: ${_emailController.text}');
          print('Register Password: ${_passwordController.text}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
          /* JANGAN ADA BARIS KODE SNACKBAR REGISTRASI (JIKA DINAVIGASI LANGSUNG) DI SINI */
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password dan Konfirmasi Password tidak cocok!'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Registrasi')),
      body: Center(
        // Tambahkan Center widget di sini
        child: SizedBox(
          // Tambahkan SizedBox untuk mengatur lebar
          width: 300.0, // Atur lebar maksimum yang Anda inginkan
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Masukkan email yang valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  if (!_isLogin) ...[
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _passwordController.text) {
                          return 'Konfirmasi password tidak cocok';
                        }
                        return null;
                      },
                    ),
                  ],
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(_isLogin ? 'Login' : 'Daftar'),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: _toggleAuthMode,
                    child: Text(
                      _isLogin
                          ? 'Belum punya akun? Daftar di sini.'
                          : 'Sudah punya akun? Login di sini.',
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
