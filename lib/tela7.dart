import 'package:flutter/material.dart';
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

                    // Foto com tags de nome
                    _buildFotoCard(),

                    const SizedBox(height: 20),

                    // Texto sobre a empresa
                    _buildSobreCard(),

                    const SizedBox(height: 32),

                    // Rodapé com slogan e arroba
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

  // ── Header verde com menu ──────────────────────────────────────────────────
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
                // volta até a tela de login (root)
                Navigator.of(context)
                    .popUntil((route) => route.isFirst);
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

  // ── Barra de navegação inferior ────────────────────────────────────────────
  Widget _buildMenu() {
    final itens = [
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
        if (titulo == 'Agenda') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Tela6Agenda()),
          );
        }
        // Pacotes e Promoções: adicione navegação quando as telas existirem
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icone,
              color: ativo ? Colors.white : Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Card com a foto dos proprietários ─────────────────────────────────────
  Widget _buildFotoCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6DBAAA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Image.asset(
              'imagens/cidinha_conrado.png',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 220,
                color: const Color(0xFF6DBAAA).withOpacity(0.4),
                child: const Center(
                  child: Icon(Icons.people, size: 80, color: Colors.white),
                ),
              ),
            ),
            // Tag "Cidinha" — canto superior esquerdo
            Positioned(
              top: 10,
              left: 12,
              child: _buildNameTag('Cidinha'),
            ),
            // Tag "Conrado" — canto superior direito
            Positioned(
              top: 10,
              right: 12,
              child: _buildNameTag('Conrado'),
            ),
          ],
        ),
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

  // ── Card com o texto "sobre" ───────────────────────────────────────────────
  Widget _buildSobreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF6DBAAA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Text(
        'A C&C Turismo é uma agência que está há mais 10 anos no mercado '
        'com o objetivo de levar pessoas para realizarem seus sonhos.',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          height: 1.6,
        ),
      ),
    );
  }
}
