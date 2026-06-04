import 'package:flutter/material.dart';
import 'package:tcc/tela6.dart';// ajuste os imports conforme sua estrutura

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

                    _buildFotoCard(),

                    const SizedBox(height: 24),

                    _buildSobreCard(),

                    const SizedBox(height: 24),

                    _buildContatoCard(),

                    const SizedBox(height: 32),

                    const Center(
                      child: Text(
                        '"O melhor caminho para o seu destino!"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        '@ccturismosjc',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
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
                Navigator.pop(context);
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
      {'icone': Icons.card_travel,      'titulo': 'Pacotes'},
      {'icone': Icons.local_offer,      'titulo': 'Promoções'},
      {'icone': Icons.calendar_month,   'titulo': 'Agenda'},
      {'icone': Icons.groups,           'titulo': 'Sobre'},
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
          Navigator.push(
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

  Widget _buildFotoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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
                color: const Color(0xFF6DBAAA).withOpacity(0.3),
                child: const Center(
                  child: Icon(Icons.people, size: 80, color: Color(0xFF6DBAAA)),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 14,
              child: _buildNameTag('Cidinha'),
            ),
            Positioned(
              top: 12,
              right: 14,
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
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        nome,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Color(0xFF222222),
        ),
      ),
    );
  }

  Widget _buildSobreCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Text(
        'A C&C Turismo é uma agência que está há mais 10 anos no mercado '
        'com o objetivo de levar pessoas para realizarem seus sonhos.',
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFF333333),
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildContatoCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entre em contato',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 14),
          _buildContatoItem(Icons.phone, '(12) 99999-9999'),
          const SizedBox(height: 10),
          _buildContatoItem(Icons.email_outlined, 'ccturismo@email.com'),
          const SizedBox(height: 10),
          _buildContatoItem(Icons.photo_camera_outlined, '@ccturismosjc'),
        ],
      ),
    );
  }

  Widget _buildContatoItem(IconData icone, String texto) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF6DBAAA).withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icone, color: const Color(0xFF2C5F5A), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          texto,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF444444),
          ),
        ),
      ],
    );
  }
}