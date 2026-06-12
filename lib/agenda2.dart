import 'package:flutter/material.dart';
import 'inicio.dart';
import 'agenda.dart';
import 'sobre.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';
import 'fozinfo.dart';
import 'natalpocosinfo.dart';
import 'petropolisinfo.dart';

class Tela6_5 extends StatefulWidget {
  const Tela6_5({super.key});

  @override
  State<Tela6_5> createState() => _Tela6_5State();
}

class _Tela6_5State extends State<Tela6_5> {

  final List<Map<String, dynamic>> viagens = [
    {
      'titulo': 'Foz, Paraguai e Argentina',
      'data': '18-22/11',
      'imagem': 'imagens/fozpa.png',
      'tela': const DetalheFoz(),
    },
    {
      'titulo': 'Natal Iluminado - Poços de Caldas',
      'data': '27-29/11',
      'imagem': 'imagens/natal.png',
      'tela': const DetalheNatalPocos(),
    },
    {
      'titulo': 'Petrópolis - RJ',
      'data': 'Data não definida',
      'imagem': 'imagens/petropolis.png',
      'tela': const DetalhePetropolis(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header verde ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: const Color.fromARGB(255, 78, 187, 165),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home,           'Início'),
                  _buildNavItem(Icons.card_travel,    'Pacotes'),
                  _buildNavItem(Icons.local_offer,    'Promoções'),
                  _buildNavItem(Icons.calendar_today, 'Agenda'),
                  _buildNavItem(Icons.groups,         'Sobre'),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Programação viagens e passeios para 2026!',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                        ),
                        const SizedBox(height: 24),
                        ...viagens.map((v) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildViagemCard(v),
                            )),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 24, bottom: 32,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 56, height: 56,
                        decoration: const BoxDecoration(color: Color.fromARGB(255, 78, 187, 165), shape: BoxShape.circle),
                        child: const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 32),
                      ),
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

  Widget _buildNavItem(IconData icon, String label) {
    final bool ativo = label == 'Agenda';
    return GestureDetector(
      onTap: () {
        if (label == 'Início') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela3()));
        } else if (label == 'Pacotes') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPacotes()));
        } else if (label == 'Promoções') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPromocoes()));
        } else if (label == 'Agenda') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela6Agenda()));
        } else if (label == 'Sobre') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela7()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: ativo ? const Color.fromARGB(255, 12, 29, 96) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 22, color: ativo ? Colors.white : Colors.black54),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF374151))),
        ],
      ),
    );
  }

  Widget _buildViagemCard(Map<String, dynamic> viagem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => viagem['tela'] as Widget),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(viagem['imagem']), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viagem['titulo'],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                  const SizedBox(height: 4),
                  Text(viagem['data'],
                      style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color.fromARGB(255, 78, 187, 165)),
          ],
        ),
      ),
    );
  }
}
