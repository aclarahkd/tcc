import 'package:flutter/material.dart';
import 'package:tcc/configuracoes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'agenda.dart';
import 'agenda2.dart';
import 'sobre.dart';
import 'inicio.dart';
import 'tela_pacotes.dart';
import 'tela_promocoes.dart';
import 'configuracoes.dart';
import 'avisoemail.dart';

class DetalheFestaDoMorango extends StatefulWidget {
  const DetalheFestaDoMorango({super.key});

  @override
  State<DetalheFestaDoMorango> createState() => _DetalheFestaDoMorangoState();
}

class _DetalheFestaDoMorangoState extends State<DetalheFestaDoMorango> {
  int _fotoAtual = 0;

  final List<String> _imagens = [
    'imagens/morango.png',
    'imagens/morango2.webp',
    'imagens/morango3.jpg',
    'imagens/morango4.jpg',
  ];

  void _proximaFoto() {
    setState(() => _fotoAtual = (_fotoAtual + 1) % _imagens.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildMenu(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Festa do morango',
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 12, 29, 96))),
                    const SizedBox(height: 4),
                    Text('Agosto em Atibaia',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87)),
                    const SizedBox(height: 16),
                    _buildCarrossel(),
                    const SizedBox(height: 20),
                    Text(
                      'Dezenas de barraquinhas com morangos e muitas delícias à base da fruta, como tortas, pavês, musses. Apresentações de grupos folclóricos japoneses, italianos, alemães etc.',
                      style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    _buildLinkContato(),
                    const SizedBox(height: 28),
                    _buildBotaoAviseme(context),
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

  Widget _buildCarrossel() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            _imagens[_fotoAtual],
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 220,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 187, 165).withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Icon(Icons.image, size: 60, color: Colors.white)),
            ),
          ),
        ),
        Positioned(
          right: 10, top: 0, bottom: 0,
          child: Center(
            child: GestureDetector(
              onTap: _proximaFoto,
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4)],
                ),
                child: const Icon(Icons.chevron_right, color: Colors.black87, size: 24),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10, left: 0, right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_imagens.length, (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _fotoAtual ? 10 : 6,
              height: i == _fotoAtual ? 10 : 6,
              decoration: BoxDecoration(
                color: i == _fotoAtual ? Colors.white : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            )),
          ),
        ),
      ],
    );
  }

  Future<void> _abrirWhatsapp() async {
    final uri = Uri.parse('https://wa.me/5512982818872');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildLinkContato() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 15, color: Colors.black87),
        children: [
          const TextSpan(text: 'Para mais informações, entre em contato conosco '),
          WidgetSpan(
            child: GestureDetector(
              onTap: _abrirWhatsapp,
              child: const Text(
                'clicando aqui.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotaoAviseme(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // TODO: substituir '' pelo e-mail real da conta do usuário logado
              builder: (_) => const AvisoEmail(emailDaConta: ''),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D4263),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: const Text('Avise-me', style: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: const Color.fromARGB(255, 78, 187, 165),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onSelected: (value) {
              if (value == 'editar') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaConfiguracoes()));
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
    );
  }

  Widget _buildMenu(BuildContext context) {
    final itens = [
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
        children: itens.map((item) =>
            _itemMenu(context, item['icone'] as IconData, item['titulo'] as String)).toList(),
      ),
    );
  }

  Widget _itemMenu(BuildContext context, IconData icone, String titulo) {
    final bool ativo = titulo == 'Agenda';
    return GestureDetector(
      onTap: () {
        if (titulo == 'Pacotes') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPacotes()));
        } else if (titulo == 'Promoções') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPromocoes()));
        } else if (titulo == 'Agenda') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Tela6Agenda()));
        } else if (titulo == 'Sobre') {
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 22, color: ativo ? Colors.white : Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(titulo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 12, 29, 96))),
        ],
      ),
    );
  }
}
