import 'package:flutter/material.dart';
import 'tela2.dart';
import 'tela3.dart'; // tela que vai depois do login

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // controladores dos bagulho
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // pra mostrar a senha
  bool mostrarSenha = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {

    // verifica se os campos tao certo
    if (_formKey.currentState!.validate()) {

      // vai pra proxima tela
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Tela3(),
        ),
      );
    }
  }

  void _navigateToRegister() {

    // vai pra tela de cadastro
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tela2()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFD4E8ED),

      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              flex: 4,

              child: Container(
                width: double.infinity,
                color: const Color(0xFFD4E8ED),

                child: Center(
                  child: Image.asset(
                    'imagens/logo.png',
                    height: 300,
                    width: 390,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [

                        // campo email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(
                            hintText: 'Email',

                            prefixIcon: const Icon(Icons.email),

                            filled: true,
                            fillColor: const Color(0xFF7FC4A8),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),

                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu email';
                            }

                            if (!value.contains('@')) {
                              return 'Por favor, insira um email válido';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // campo senha
                        TextFormField(
                          controller: _passwordController,

                          obscureText: !mostrarSenha,

                          decoration: InputDecoration(
                            hintText: 'Senha',

                            prefixIcon: const Icon(Icons.lock),

                            // botao do olho la
                            suffixIcon: IconButton(

                              onPressed: () {

                                setState(() {
                                  mostrarSenha = !mostrarSenha;
                                });
                              },

                              icon: Icon(
                                mostrarSenha
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),

                            filled: true,
                            fillColor: const Color(0xFF7FC4A8),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),

                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }

                            if (value.length < 6) {
                              return 'A senha deve ter pelo menos 6 caracteres';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: _handleLogin,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E5C8A),

                              foregroundColor: Colors.white,

                              padding: const EdgeInsets.symmetric(vertical: 16),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),

                              elevation: 3,
                            ),

                            child: const Text(
                              'Concluir',

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            const Text('Não tem uma conta? '),

                            GestureDetector(
                              onTap: _navigateToRegister,

                              child: const Text(
                                'Cadastre-se',

                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}