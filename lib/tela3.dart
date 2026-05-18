import 'package:flutter/material.dart';
import 'tela6.dart';

class Tela3 extends StatefulWidget {
  const Tela3({super.key});

  @override
 State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {

  // lista das imagem
  List<String> imagens = [
    'imagens/foto1.jpg',
    'imagens/foto2.jpg',
    'imagens/foto3.jpg',
  ];

  // controla qual foto ta aparecendo
  int fotoAtual = 0;

  // controla o texto da pesquisa
  TextEditingController pesquisaController = TextEditingController();

  void proximaFoto() {

    // passa pra prox foto
    setState(() {

      fotoAtual++;

      if (fotoAtual >= imagens.length) {
        fotoAtual = 0;
      }
    });
  }

  void pesquisarIA() {

    // pega oq o cara digitou
    String texto = pesquisaController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pesquisando: $texto'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            // parte verde de cima
Container(
  width: double.infinity,

  padding: const EdgeInsets.all(16),

  decoration: const BoxDecoration(
    color: Color(0xFF6DBAAA),
  ),

  child: Align(
    alignment: Alignment.centerRight,

    child: PopupMenuButton(

      // quando clicar na opcao
      onSelected: (value) {

        // se clicar em sair
        if (value == 'sair') {

          // volta pro login
          Navigator.pop(context);
        }
      },

      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
        size: 28,
      ),

      itemBuilder: (context) => [

        // opcao sair
        const PopupMenuItem(
          value: 'sair',
          child: Text('Sair da conta'),
        ),
      ],
    ),
  ),
),

            // botoes la
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),

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

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),

              child: Text(
                'Pesquise seu destino ideal:',

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // barra da ia
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(
                  color: const Color(0xFF6DBAAA),
                  borderRadius: BorderRadius.circular(25),
                ),

                child: Row(
                  children: [

                    // campo pra digitar
                    Expanded(
                      child: TextField(
                        controller: pesquisaController,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: const InputDecoration(
                          hintText: 'Utilize IA para lhe auxiliar',

                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),

                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // botao pesquisar
                    IconButton(
                      onPressed: pesquisarIA,

                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Nossa galeria',

              style: TextStyle(
                fontFamily: 'Brush Script MT',
                fontSize: 36,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),

              child: Text(
                'Compartilhando nossos momentos com você!',

                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // area das foto
            Expanded(
              child: Stack(
                children: [

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.asset(
                        imagens[fotoAtual],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // botao da prox foto
                  Positioned(
                    right: 32,
                    top: 0,
                    bottom: 0,

                    child: Center(
                      child: GestureDetector(
                        onTap: proximaFoto,

                        child: Container(
                          width: 32,
                          height: 32,

                          decoration: const BoxDecoration(
                            color: Color(0xFF6DBAAA),
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),

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

            const Padding(
              padding: EdgeInsets.only(bottom: 24),

              child: Text(
                '@ccturismosjc',

                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
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

        if (label == 'Agenda') {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Tela6Agenda(),
            ),
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
              color: const Color(0xFF2C5F5A),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            label,

            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}