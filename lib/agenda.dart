import 'package:flutter/material.dart';
import 'package:tcc/betocinfo.dart';
import 'sobre.dart';
import 'inicio.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';
import 'jaguariunainfo.dart';
import 'ibitingainfo.dart';
import 'morangoinfo.dart';
import 'zooitatibainfo.dart';
import 'fozinfo.dart';
import 'natalpocosinfo.dart';
import 'petropolisinfo.dart';

class Tela6Agenda extends StatefulWidget {
  const Tela6Agenda({super.key});

  @override
  State<Tela6Agenda> createState() => _Tela6AgendaState();
}

class _Tela6AgendaState extends State<Tela6Agenda> {

  // ── Todas as viagens unificadas (agenda + agenda2) ────────────────────
  final List<Map<String, dynamic>> viagens = [
    {
      'titulo': 'Jaguariúna + Pedreira',
      'data': '28/06/26',
      'imagem': 'imagens/jaguariuna.png',
      'tela': const DetalheJaguariuna(),
    },
    {
      'titulo': 'Beto Carrero World, Balneário Camboriú e Curitiba',
      'data': '8 a 12/07/26',
      'imagem': 'imagens/betocarrero.jpg',
      'tela': const DetalheBetoCarrero(),
    },
    {
      'titulo': 'Ibitinga + Passeio de Barco',
      'data': '24 a 27/07/26',
      'imagem': 'imagens/ibitinga.png',
      'tela': const DetalheIbitinga(),
    },
    {
      'titulo': 'Festa do Morango',
      'data': '17/08/26',
      'imagem': 'imagens/morango.png',
      'tela': const DetalheFestaDoMorango(),
    },
    {
      'titulo': 'Zoo Itatiba',
      'data': '27/09/26',
      'imagem': 'imagens/zooitatiba.png',
      'tela': const DetalheZooItatiba(),
    },
    {
      'titulo': 'Foz, Paraguai e Argentina',
      'data': '18-22/11/26',
      'imagem': 'imagens/fozpa.png',
      'tela': const DetalheFoz(),
    },
    {
      'titulo': 'Natal Iluminado - Poços de Caldas',
      'data': '27-29/11/26',
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
      backgroundColor: const Color(0xFFF8F8F8),
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

            // ── Lista unificada com scroll ────────────────────────────────
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Programação de viagens e passeios 2026',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...viagens.map((viagem) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildCardViagem(viagem),
                      )),
                  const SizedBox(height: 20),
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const Tela3()));
        } else if (titulo == 'Pacotes') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const TelaPacotes()));
        } else if (titulo == 'Promoções') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const TelaPromocoes()));
        } else if (titulo == 'Sobre') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const Tela7()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: ativo
                  ? const Color.fromARGB(255, 12, 29, 96)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 22,
                color: ativo ? Colors.white : Colors.black54),
          ),
          const SizedBox(height: 6),
          Text(titulo,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCardViagem(Map<String, dynamic> viagem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => viagem['tela'] as Widget),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                viagem['imagem'],
                width: 65, height: 65,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viagem['titulo'],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(viagem['data'],
                      style: TextStyle(
                          fontSize: 13, color: Colors.grey.shade600)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Color.fromARGB(255, 78, 187, 165)),
          ],
        ),
      ),
    );
  }
}