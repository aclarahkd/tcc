import 'package:flutter/material.dart';
import 'tela3.dart';
import 'tela6.dart';

class Tela7 extends StatefulWidget {
  const Tela7({super.key});

  @override
  State<Tela7> createState() => _Tela7State();
}

class _Tela7State extends State<Tela7> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildMenu(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quem somos nós?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildRetrato(),

                    const SizedBox(height: 32),

                    Center(
                      child: Column(
                        children: const [
                          Text(
                            '"O melhor caminho para o seu destino!"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '@ccturismosjc',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: const Color(0xFF6DBAAA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onSelected: (value) {
              if (value == 'sair') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'sair',
                child: Text('Sair da conta'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    final itens = [
      {'icone': Icons.home,           'titulo': 'Início'},
      {'icone': Icons.card_travel,    'titulo': 'Pacotes'},
      {'icone': Icons.local_offer,    'titulo': 'Promoções'},
      {'icone': Icons.calendar_month, 'titulo': 'Agenda'},
      {'icone': Icons.groups,         'titulo': 'Sobre'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itens.map((item) {
          return _itemMenu(
            item['icone'] as IconData,
            item['titulo'] as String,
          );
        }).toList(),
      ),
    );
  }

  Widget _itemMenu(IconData icone, String titulo) {
    final bool ativo = titulo == 'Sobre';

    return GestureDetector(
      onTap: () {
        if (titulo == 'Início') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Tela3()),
          );
        } else if (titulo == 'Agenda') {
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ativo
                  ? const Color(0xFF2C5F5A)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icone,
              size: 22,
              color: ativo ? Colors.white : Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetrato() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF6DBAAA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft:  Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 210,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'imagens/cidinha_conrado.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF4DA898),
                      child: const Center(
                        child: Icon(
                          Icons.photo,
                          size: 72,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 12,
                    child: _buildNameTag('Cidinha'),
                  ),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: _buildNameTag('Conrado'),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'A C&C Turismo é uma agência que está há mais 10 anos no mercado '
              'com o objetivo de levar pessoas para realizarem seus sonhos.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameTag(String nome) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF2C5F5A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        nome,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}
