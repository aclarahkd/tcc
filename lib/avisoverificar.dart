import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda2.dart';
import 'sobre.dart';
import 'inicio.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';
import 'avisosucesso.dart';

/// Tela 2 do fluxo "Avise-me": digitação do código de verificação
/// enviado para o e-mail informado na etapa anterior.
class AvisoVerificar extends StatefulWidget {
  final String email;

  const AvisoVerificar({super.key, required this.email});

  @override
  State<AvisoVerificar> createState() => _AvisoVerificarState();
}

class _AvisoVerificarState extends State<AvisoVerificar> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _verificar() {
    final codigo = _controllers.map((c) => c.text).join();
    if (codigo.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite o código completo')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AvisoSucesso()),
    );
  }

  void _reenviarCodigo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Código reenviado para ${widget.email}')),
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
                      'Verifique seu e-mail',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 29, 96),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Uma mensagem foi enviada para o e-mail selecionado.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Card cinza
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Digite o código enviado',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 4 caixas do código
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (i) {
                              return SizedBox(
                                width: 60,
                                height: 60,
                                child: TextField(
                                  controller: _controllers[i],
                                  focusNode: _focusNodes[i],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: const Color.fromARGB(255, 78, 187, 165),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && i < 3) {
                                      _focusNodes[i + 1].requestFocus();
                                    } else if (value.isEmpty && i > 0) {
                                      _focusNodes[i - 1].requestFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 24),

                          // Botão Verificar
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _verificar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2D4263),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Verificar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Reenviar código
                          GestureDetector(
                            onTap: _reenviarCodigo,
                            child: const Text(
                              'Reenviar o código',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
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
