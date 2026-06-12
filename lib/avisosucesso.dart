import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda2.dart';
import 'sobre.dart';
import 'inicio.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';

/// Tela 3 do fluxo "Avise-me": confirmação de que o e-mail foi
/// validado com sucesso e o aviso será enviado.
class AvisoSucesso extends StatelessWidget {
  const AvisoSucesso({super.key});

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Validação concluída\ncom sucesso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 29, 96),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Botão Voltar para tela inicial
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Volta até a tela inicial (Início), removendo
                          // todas as telas do fluxo "Avise-me" da pilha.
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const Tela3()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D4263),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Voltar para tela inicial',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
