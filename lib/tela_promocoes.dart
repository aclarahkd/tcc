import 'package:flutter/material.dart';
import 'inicio.dart';
import 'agenda.dart';
import 'sobre.dart';
import 'tela_pacotes.dart';
import 'configuracoes.dart';

class TelaPromocoes extends StatefulWidget {
  const TelaPromocoes({super.key});

  @override
  State<TelaPromocoes> createState() => _TelaPromocoesState();
}


class _TelaPromocoesState extends State<TelaPromocoes> {
  final List<Map<String, String>> promocoes = [
    {'titulo': 'Holambra - SP',  'origem': 'Saindo de São José dos Campos', 'preco': 'A partir de R\$190 por pessoa',  'parcelas': '2X de R\$95 sem juros',  'imagem': 'imagens/holambra.jpg'},
    {'titulo': 'Ibitinga + Barco',  'origem': 'Saindo de São José dos Campos', 'preco': 'A partir de R\$1050 por pessoa', 'parcelas': '3X de R\$350 sem juros',  'imagem': 'imagens/ibitinga.png'},
    {'titulo': 'Festa do Morango',  'origem': 'Saindo de São José dos Campos', 'preco': 'A partir de R\$100 por pessoa',  'parcelas': '2x de R\$50 sem juros',  'imagem': 'imagens/morango.png'},
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
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  color: const Color.fromARGB(255, 78, 187, 165),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        'imagens/logo.png',
        height: 90,
        fit: BoxFit.contain,
      ),

      PopupMenuButton<String>(
        icon: const Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
        onSelected: (value) {
          if (value == 'editar') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TelaConfiguracoes(),
              ),
            );
          } else if (value == 'sair') {
            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: 'editar',
            child: Text('Editar perfil'),
          ),
          PopupMenuItem(
            value: 'sair',
            child: Text('Sair da conta'),
          ),
        ],
      ),
    ],
  ),
),

// ── Menu ─────────────────────────────────────────────────────
Container(
  padding: const EdgeInsets.symmetric(vertical: 16),
  color: Colors.white,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _itemMenu(Icons.home, 'Início'),
      _itemMenu(Icons.card_travel, 'Pacotes'),
      _itemMenu(Icons.local_offer, 'Promoções'),
      _itemMenu(Icons.calendar_month, 'Agenda'),
      _itemMenu(Icons.groups, 'Sobre'),
    ],
  ),
),
            Expanded(
              
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pacotes com ótimas promoções!',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: promocoes.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.52),
                      itemBuilder: (context, index) => _buildCard(promocoes[index]),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _itemMenu(IconData icone, String titulo) {
  final bool ativo = titulo == 'Promoções';

  return GestureDetector(
    onTap: () {
      if (titulo == 'Início') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Tela3()),
        );
      } else if (titulo == 'Pacotes') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TelaPacotes()),
        );
      } else if (titulo == 'Agenda') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Tela6Agenda()),
        );
      } else if (titulo == 'Sobre') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Tela7()),
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
                ? const Color.fromARGB(255, 12, 29, 96)
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icone,
            size: 22,
            color: ativo ? Colors.white : Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
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
  Widget _buildCard(Map<String, String> p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(p['imagem']!, height: 120, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 120,
                    color: const Color.fromARGB(255, 78, 187, 165).withOpacity(0.3),
                    child: const Center(child: Icon(Icons.image, color: Colors.white, size: 40)))),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['titulo']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text(p['origem']!, style: const TextStyle(fontSize: 11, color: Color.fromARGB(255, 78, 187, 165)), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.directions_bus, size: 18, color: Color.fromARGB(255, 12, 29, 96)),
                  const SizedBox(width: 6),
                  Expanded(child: Text(p['preco']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)))),
                ]),
                const SizedBox(height: 8),
                const Text('Ida e volta', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 2),
                Text(p['parcelas']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 12, 29, 96))),
                const SizedBox(height: 10),

                SizedBox(width: double.infinity,
                  child: OutlinedButton.icon(onPressed: () {},
                    icon: const Icon(Icons.chat, size: 16, color: Color.fromARGB(255, 12, 29, 96)),
                    label: const Text('Fale com a gente', style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 12, 29, 96))),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8),
                        side: const BorderSide(color: Color.fromARGB(255, 78, 187, 165)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  _itemmenu(IconData home, String s) {}
}
