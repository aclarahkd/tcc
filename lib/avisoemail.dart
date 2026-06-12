import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda2.dart';
import 'sobre.dart';
import 'inicio.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';
import 'avisoverificar.dart';

/// Tela 1 do fluxo "Avise-me": confirma o e-mail (e senha) do usuário
/// para envio das informações sobre o pacote.
class AvisoEmail extends StatefulWidget {
  /// E-mail já cadastrado na conta do usuário (preenchido automaticamente).
  final String emailDaConta;

  const AvisoEmail({super.key, this.emailDaConta = ''});

  @override
  State<AvisoEmail> createState() => _AvisoEmailState();
}

class _AvisoEmailState extends State<AvisoEmail> {
  late final TextEditingController _emailController;
  final TextEditingController _senhaController = TextEditingController();
  bool _mostrarSenha = false;

  @override
  void initState() {
    super.initState();
    // Pré-preenche com o e-mail da conta do usuário logado.
    _emailController = TextEditingController(text: widget.emailDaConta);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _concluir() {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o e-mail da sua conta')),
      );
      return;
    }
    if (_senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe sua senha')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AvisoVerificar(email: _emailController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildMenu(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informe seu email',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 29, 96),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Para receber informações sobre o pacote desejado',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Card cinza com os campos
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          // Campo Email — confirma o e-mail da conta
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 78, 187, 165),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Campo Senha — confirma identidade do dono da conta
                          TextField(
                            controller: _senhaController,
                            obscureText: !_mostrarSenha,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 78, 187, 165),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _mostrarSenha ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () => setState(() => _mostrarSenha = !_mostrarSenha),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Botão Concluir
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _concluir,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2D4263),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Concluir',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header verde ──────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: const Color.fromARGB(255, 78, 187, 165),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onSelected: (value) {
              if (value == 'editar') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaConfiguracoes()));
              } else if (value == 'sair') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'editar', child: Text('Editar perfil')),
              PopupMenuItem(value: 'sair',   child: Text('Sair da conta')),
            ],
          ),
        ],
      ),
    );
  }

  // ── Menu ──────────────────────────────────────────────────────────────
  Widget _buildMenu(BuildContext context) {
    final itens = [
      {'icone': Icons.card_travel,    'titulo': 'Pacotes'},
      {'icone': Icons.local_offer,    'titulo': 'Promoções'},
      {'icone': Icons.calendar_month, 'titulo': 'Agenda'},
      {'icone': Icons.groups,         'titulo': 'Sobre'},
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itens.map((item) =>
            _itemMenu(context, item['icone'] as IconData, item['titulo'] as String)).toList(),
      ),
    );
  }

  Widget _itemMenu(BuildContext context, IconData icone, String titulo) {
    return GestureDetector(
      onTap: () {
        if (titulo == 'Pacotes') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPacotes()));
        } else if (titulo == 'Promoções') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPromocoes()));
        } else if (titulo == 'Agenda') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela6Agenda()));
        } else if (titulo == 'Sobre') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela7()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 22, color: Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(titulo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 12, 29, 96))),
        ],
      ),
    );
  }
}
