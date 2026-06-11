import 'package:flutter/material.dart';
import 'inicio.dart';
import 'agenda.dart';
import 'sobre.dart';
import 'tela_pacotes.dart';

class TelaPromocoes extends StatefulWidget {
  const TelaPromocoes({super.key});

  @override
  State<TelaPromocoes> createState() => _TelaPromocoesState();
}

class _TelaPromocoesState extends State<TelaPromocoes> {
  final List<Map<String, String>> promocoes = [
    {
      'titulo': 'Holambra - São Paulo',
      'origem': 'Saindo de São José dos Campos',
      'preco': 'A partir de R\$300 por pessoa',
      'parcelas': '5X de R\$60',
      'imagem': 'imagens/holambra.jpg',
    },
    {
      'titulo': 'Ibitinga - São Paulo',
      'origem': 'Saindo de São José dos Campos',
      'preco': 'A partir de R\$1050 por pessoa',
      'parcelas': '5X de R\$210',
      'imagem': 'imagens/ibitinga.png',
    },
    {
      'titulo': 'Festa do Morango - Atibaia',
      'origem': 'Saindo de São José dos Campos',
      'preco': 'A partir de R\$600 por pessoa',
      'parcelas': '5X de R\$120',
      'imagem': 'imagens/morango.png',
    },
  ];

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
                      'Pacotes com ótimas promoções!',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A)),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: promocoes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.52,
                      ),
                      itemBuilder: (context, index) =>
                          _buildCard(promocoes[index]),
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
              PopupMenuItem(value: 'sair', child: Text('Sair da conta')),
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itens.map((item) {
          return _itemMenu(item['icone'] as IconData, item['titulo'] as String);
        }).toList(),
      ),
    );
  }

  Widget _itemMenu(IconData icone, String titulo) {
    final bool ativo = titulo == 'Promoções';

    return GestureDetector(
      onTap: () {
        if (titulo == 'Início') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const Tela3()));
        } else if (titulo == 'Pacotes') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const TelaPacotes()));
        } else if (titulo == 'Agenda') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const Tela6Agenda()));
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
              color: ativo ? const Color(0xFF2C5F5A) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 22,
                color: ativo ? Colors.white : Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(titulo,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, String> promo) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              promo['imagem']!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 120,
                color: const Color(0xFF6DBAAA).withOpacity(0.3),
                child: const Center(
                    child: Icon(Icons.image, color: Colors.white, size: 40)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(promo['titulo']!,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text(promo['origem']!,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6DBAAA)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.directions_bus,
                        size: 18, color: Color(0xFF2C5F5A)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(promo['preco']!,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A))),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Ida e volta',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A))),
                const SizedBox(height: 2),
                Text(promo['parcelas']!,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C5F5A))),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6DBAAA),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    child: const Text('Compre no app',
                        style: TextStyle(fontSize: 11)),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat,
                        size: 16, color: Color(0xFF2C5F5A)),
                    label: const Text('Fale com a gente',
                        style: TextStyle(fontSize: 11, color: Color(0xFF2C5F5A))),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      side: const BorderSide(color: Color(0xFF6DBAAA)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
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
