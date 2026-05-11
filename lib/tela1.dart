import 'package:flutter/material.dart';
import 'tela2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _navigateToRegister() {
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
            // ================= PARTE SUPERIOR =================
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

            // ================= PARTE INFERIOR =================
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
                        // ================= EMAIL =================
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(
                            hintText: 'Email',

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

                        // ================= SENHA =================
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,

                          decoration: InputDecoration(
                            hintText: 'Senha',

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

                        // ================= BOTÃO =================
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

                        // ================= CADASTRO =================
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
