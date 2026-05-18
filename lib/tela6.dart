import 'package:flutter/material.dart';
import 'tela6_5.dart';

class Tela6Agenda extends StatefulWidget {
  const Tela6Agenda({super.key});

  @override
  State<Tela6Agenda> createState() => _Tela6AgendaState();
}

class _Tela6AgendaState extends State<Tela6Agenda> {

  // viagens da tela
  final List<Map<String, String>> viagens = [
    {
      'titulo': 'Jaguariúna + Pedreira',
      'data': '28/6',
      'imagem': 'imagens/viagem1.jpg',
    },
    {
      'titulo': 'Ibitinga + Passeio de barco',
      'data': '24-27/07',
      'imagem': 'imagens/viagem2.jpg',
    },
    {
      'titulo': 'Festa do morango',
      'data': '14 a 17 de agosto',
      'imagem': 'imagens/viagem3.jpg',
    },
    {
      'titulo': 'ZOO Itatiba',
      'data': '27/09',
      'imagem': 'imagens/viagem4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      body: SafeArea(
        child: Column(
          children: [

            // parte verde de cima
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF6DBAAA),

              child: Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 28,
                  ),
                  onSelected: (value) {
                    if (value == 'sair') {
                      Navigator.pop(context);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'sair',
                      child: Text('Sair da conta'),
                    ),
                  ],
                ),
              ),
            ),

            // menu com os icones
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemMenu(Icons.card_travel, 'Pacotes'),
                  itemMenu(Icons.local_offer, 'Promoções'),
                  itemMenu(Icons.calendar_today, 'Agenda'),
                  itemMenu(Icons.groups, 'Sobre'),
                ],
              ),
            ),

            // conteúdo da tela
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // titulo
                        const Text(
                          'Programação viagens e passeios para 2026!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // cards das viagens
                        ...viagens.map(
                          (viagem) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: cardViagem(
                              viagem['titulo']!,
                              viagem['data']!,
                              viagem['imagem']!,
                            ),
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),

                  // botão pra abrir mais viagens
                  Positioned(
                    bottom: 30,
                    right: 24,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Tela6_5(),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6DBAAA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.expand_more,
                          color: Colors.white,
                          size: 35,
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

      // botão verde de confirmar
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6DBAAA),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ação confirmada'),
            ),
          );
        },
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget itemMenu(IconData icone, String texto) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF2C5F5A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icone,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          texto,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget cardViagem(String titulo, String data, String imagem) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          // imagem da viagem
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagem),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // nome e data
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