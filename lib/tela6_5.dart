import 'package:flutter/material.dart';
import 'tela7.dart';
class Tela6_5 extends StatefulWidget {
  const Tela6_5({super.key});

  @override
  State<Tela6_5> createState() => _Tela6_5State();
}

class _Tela6_5State extends State<Tela6_5> {
  bool mostrarMenu = false;

  // Lista de viagens da segunda página
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
            // Header verde
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF6DBAAA),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'sair') {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 28,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'sair',
                      child: Text('Sair da conta'),
                    ),
                  ],
                ),
              ),
            ),

            // Ícones de navegação
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFF3F4F6),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.card_travel, 'Pacotes'),
                  _buildNavItem(Icons.local_offer, 'Promoções'),
                  _buildNavItem(Icons.calendar_today, 'Agenda'),
                  _buildNavItem(Icons.groups, 'Sobre'),
                ],
              ),
            ),

            // Conteúdo principal
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título
                        const Text(
                          'Programação viagens e passeios para 2026!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Lista de viagens
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

                  // Botão de seta para voltar (seta para cima)
                  Positioned(
                    right: 24,
                    bottom: 32,
                    child: GestureDetector(
                      onTap: () {
                        // Volta para a tela 6
                        Navigator.pop(context);
                      },
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

 Widget _buildNavItem(IconData icon, String label) {
  return GestureDetector(
    onTap: () {
      if (label == 'Sobre') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const Tela7(),
          ),
        );
      }

      if (label == 'Agenda') {
        // Já está na tela de agenda
      }

      // Adicione outras navegações aqui
      // if (label == 'Pacotes') { ... }
      // if (label == 'Promoções') { ... }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF2C5F5A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
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
          // Imagem circular
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

          // Texto
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