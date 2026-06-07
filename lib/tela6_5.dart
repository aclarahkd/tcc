import 'package:flutter/material.dart';
import 'tela6.dart';
import 'tela7.dart';

class Tela6_5 extends StatefulWidget {
  const Tela6_5({super.key});

  @override
  State<Tela6_5> createState() => _Tela6_5State();
}

class _Tela6_5State extends State<Tela6_5> {
  final List<Map<String, String>> viagens = [
    {
      'titulo': 'Foz, Paraguai e Argentina',
      'data': '18-22/11',
      'imagem': 'imagens/fozpa.png',
    },
    {
      'titulo': 'Natal Iluminado - Poços de caldas',
      'data': '27-29/11',
      'imagem': 'imagens/natal.png',
    },
    {
      'titulo': 'Petrópolis - RJ',
      'data': 'Data não definida',
      'imagem': 'imagens/petropolis.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildMenu(),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...viagens.map((viagem) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildViagemCard(
                                viagem['titulo']!,
                                viagem['data']!,
                                viagem['imagem']!,
                              ),
                            )),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  // Botão de seta para voltar
                  Positioned(
                    right: 24,
                    bottom: 32,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6DBAAA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                          size: 32,
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
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xFF6DBAAA)),
      child: Align(
        alignment: Alignment.centerRight,
        child: PopupMenuButton(
          onSelected: (value) {
            if (value == 'sair') {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
          icon: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'sair',
              child: Text('Sair da conta'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu() {
    final itens = [
      {'icone': Icons.card_travel,    'titulo': 'Pacotes'},
      {'icone': Icons.local_offer,    'titulo': 'Promoções'},
      {'icone': Icons.calendar_today, 'titulo': 'Agenda'},
      {'icone': Icons.groups,         'titulo': 'Sobre'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itens.map((item) {
          return _buildNavItem(
            item['icone'] as IconData,
            item['titulo'] as String,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    // Agenda está ativa pois esta tela é parte da Agenda
    final bool ativo = label == 'Agenda';

    return GestureDetector(
      onTap: () {
        if (label == 'Sobre') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Tela7()),
          );
        } else if (label == 'Agenda') {
          // Volta para a tela6 (primeira página da agenda)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Tela6Agenda()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ativo
                  ? const Color(0xFF2C5F5A)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: ativo ? Colors.white : Colors.black54,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViagemCard(String titulo, String data, String imagemPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagemPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
