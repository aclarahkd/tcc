import 'package:flutter/material.dart';
import 'agenda2.dart';
import 'sobre.dart';
import 'inicio.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';

class Tela6Agenda extends StatefulWidget {
  const Tela6Agenda({super.key});

  @override
  State<Tela6Agenda> createState() => _Tela6AgendaState();
}

class _Tela6AgendaState extends State<Tela6Agenda> {
  final List<Map<String, String>> viagens = [
    {'titulo': 'Jaguariúna + Pedreira',       'data': '28/06',             'imagem': 'imagens/jaguariuna.png'},
    {'titulo': 'Ibitinga + Passeio de Barco', 'data': '24 a 27/07',       'imagem': 'imagens/ibitinga.png'},
    {'titulo': 'Festa do Morango',             'data': '14 a 17 de Agosto','imagem': 'imagens/morango.png'},
    {'titulo': 'Zoo Itatiba',                  'data': '27/09',             'imagem': 'imagens/zooitatiba.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header verde ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: const Color(0xFF6DBAAA),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onSelected: (value) {
                      if (value == 'editar') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const TelaConfiguracoes()));
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
            ),

            // ── Menu ─────────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _itemMenu(Icons.home,           'Início'),
                  _itemMenu(Icons.card_travel,    'Pacotes'),
                  _itemMenu(Icons.local_offer,    'Promoções'),
                  _itemMenu(Icons.calendar_month, 'Agenda'),
                  _itemMenu(Icons.groups,         'Sobre'),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text('Programação de viagens e passeios 2026',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF222222))),
                      const SizedBox(height: 24),
                      for (var viagem in viagens)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildCardViagem(viagem),
                        ),
                      const SizedBox(height: 80),
                    ],
                  ),
                  Positioned(
                    right: 20, bottom: 25,
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xFF6DBAAA),
                      elevation: 2,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Tela6_5())),
                      child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemMenu(IconData icone, String titulo) {
    final bool ativo = titulo == 'Agenda';
    return GestureDetector(
      onTap: () {
        if (titulo == 'Início') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela3()));
        } else if (titulo == 'Pacotes') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPacotes()));
        } else if (titulo == 'Promoções') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPromocoes()));
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
              color: ativo ? const Color(0xFF2C5F5A) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 22, color: ativo ? Colors.white : Colors.black54),
          ),
          const SizedBox(height: 6),
          Text(titulo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCardViagem(Map<String, String> viagem) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(viagem['imagem']!, width: 65, height: 65, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(viagem['titulo']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(viagem['data']!, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
