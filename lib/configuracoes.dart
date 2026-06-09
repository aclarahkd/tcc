import 'package:flutter/material.dart';
import 'editarperfil.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool notificacoesAtivas = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header verde ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: const Color(0xFF6DBAAA),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão voltar
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  // Três pontinhos
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onSelected: (value) {
                      if (value == 'editar') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TelaEditarPerfil()),
                        );
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                          value: 'editar', child: Text('Editar perfil')),
                    ],
                  ),
                ],
              ),
            ),

            // ── Conteúdo ──────────────────────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  // Notificações
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notificações',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Receber notificações do app',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        ),
                        Switch(
                          value: notificacoesAtivas,
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF2D4263),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade400,
                          trackOutlineColor:
                              WidgetStateProperty.all(Colors.transparent),
                          onChanged: (val) {
                            setState(() => notificacoesAtivas = val);
                          },
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, color: Color(0xFFE0E0E0)),

                  const SizedBox(height: 20),

                  // Editar perfil
                  _buildOpcao(
                    icone: Icons.account_circle,
                    titulo: 'Editar perfil',
                    subtitulo: 'Troque suas informações',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TelaEditarPerfil()),
                      );
                    },
                  ),

                  const SizedBox(height: 4),

                  // Sair
                  _buildOpcao(
                    icone: Icons.arrow_back_ios_new,
                    titulo: 'Sair',
                    subtitulo: 'Fazer logout de sua conta',
                    onTap: () {
                      Navigator.of(context)
                          .popUntil((route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcao({
    required IconData icone,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Icon(icone, size: 28, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Text(subtitulo,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
