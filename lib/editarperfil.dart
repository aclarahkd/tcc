import 'package:flutter/material.dart';
import 'mudarinfo.dart';
import 'configuracoes.dart';

class TelaEditarPerfil extends StatefulWidget {
  const TelaEditarPerfil({super.key});

  @override
  State<TelaEditarPerfil> createState() => _TelaEditarPerfilState();
}

class _TelaEditarPerfilState extends State<TelaEditarPerfil> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Controla se o bottom sheet de foto está aberto
  bool _mostrarOpcoesFoto = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleOpcoesFoto() {
    setState(() => _mostrarOpcoesFoto = !_mostrarOpcoesFoto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ── Header verde ─────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  color: const Color.fromARGB(255, 78, 187, 165),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz,
                            color: Colors.white),
                        onSelected: (value) {
                          if (value == 'config') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const TelaConfiguracoes()),
                            );
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                              value: 'config',
                              child: Text('Configurações')),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Conteúdo ──────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        const Text(
                          'Editar perfil',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 24),

                        // Avatar com botão +
                        GestureDetector(
                          onTap: _toggleOpcoesFoto,
                          child: Stack(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBDBDBD),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person,
                                    size: 60, color: Colors.white),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 78, 187, 165),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add,
                                      size: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Campo Nome
                        _buildCampo(
                          controller: _nomeController,
                          hint: 'Nome',
                        ),

                        const SizedBox(height: 16),

                        // Campo Email
                        _buildCampo(
                          controller: _emailController,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Botão Trocar informações pessoais
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const TelaMudarInformacoes()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Trocar informações pessoais',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Botão Salvar alterações
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Alterações salvas!')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D4263),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Salvar alterações',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Bottom sheet de foto (aparece quando clica no +) ─────────
            if (_mostrarOpcoesFoto)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {}, // impede fechar ao clicar dentro
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildOpcaoFoto(
                          icone: Icons.camera_alt_outlined,
                          titulo: 'Tirar foto',
                          onTap: () =>
                              setState(() => _mostrarOpcoesFoto = false),
                        ),
                        const SizedBox(height: 16),
                        _buildOpcaoFoto(
                          icone: Icons.image_outlined,
                          titulo: 'Carregar foto',
                          onTap: () =>
                              setState(() => _mostrarOpcoesFoto = false),
                        ),
                        const SizedBox(height: 16),
                        _buildOpcaoFoto(
                          icone: Icons.remove_red_eye_outlined,
                          titulo: 'Visualizar foto',
                          onTap: () =>
                              setState(() => _mostrarOpcoesFoto = false),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),

            // Fundo escuro ao abrir opções de foto
            if (_mostrarOpcoesFoto)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _mostrarOpcoesFoto = false),
                  child: Container(color: Colors.transparent),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampo({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 78, 187, 165), width: 2),
        ),
      ),
    );
  }

  Widget _buildOpcaoFoto({
    required IconData icone,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icone, size: 28, color: Colors.black87),
          const SizedBox(width: 16),
          Text(titulo,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }
}
