import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'configuracoes.dart';

class TelaMudarInformacoes extends StatefulWidget {
  const TelaMudarInformacoes({super.key});

  @override
  State<TelaMudarInformacoes> createState() => _TelaMudarInformacoesState();
}

class _TelaMudarInformacoesState extends State<TelaMudarInformacoes> {
  final _primeiroNomeController = TextEditingController();
  final _sobrenomeController    = TextEditingController();
  final _nascimentoController   = TextEditingController();
  final _emailController        = TextEditingController();
  final _telefoneController     = TextEditingController();
  final _cpfController          = TextEditingController();

  String? _sexoSelecionado;
  String? _tipoTelefoneSelecionado;

  final _cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final _telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final _nascimentoMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _primeiroNomeController.dispose();
    _sobrenomeController.dispose();
    _nascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header verde ─────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              color: const Color(0xFF6DBAAA),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz,
                        color: Colors.white),
                    onSelected: (value) {
                      if (value == 'config') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const TelaConfiguracoes()),
                        );
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                          value: 'config',
                          child: Text('Configurações')),
                    ],
                  ),
                ],
              ),
            ),

            // ── Conteúdo ─────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mudar informações',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // Card cinza com os campos
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _buildCampo(
                            controller: _primeiroNomeController,
                            hint: 'Primeiro nome',
                          ),
                          const SizedBox(height: 12),
                          _buildCampo(
                            controller: _sobrenomeController,
                            hint: 'Sobrenome',
                          ),
                          const SizedBox(height: 12),
                          _buildCampo(
                            controller: _nascimentoController,
                            hint: 'Data de nascimento',
                            keyboardType: TextInputType.number,
                            formatter: _nascimentoMask,
                          ),
                          const SizedBox(height: 12),

                          // Dropdown Sexo
                          _buildDropdown(
                            value: _sexoSelecionado,
                            hint: 'Sexo',
                            items: ['Masculino', 'Feminino', 'Outro'],
                            onChanged: (v) =>
                                setState(() => _sexoSelecionado = v),
                          ),
                          const SizedBox(height: 12),

                          _buildCampo(
                            controller: _emailController,
                            hint: 'E-mail',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),

                          // Dropdown Tipo de telefone
                          _buildDropdown(
                            value: _tipoTelefoneSelecionado,
                            hint: 'Tipo de telefone',
                            items: [
                              'Celular',
                              'Residencial',
                              'Comercial'
                            ],
                            onChanged: (v) => setState(
                                () => _tipoTelefoneSelecionado = v),
                          ),
                          const SizedBox(height: 12),

                          _buildCampo(
                            controller: _telefoneController,
                            hint: 'Telefone',
                            keyboardType: TextInputType.phone,
                            formatter: _telefoneMask,
                          ),
                          const SizedBox(height: 12),

                          _buildCampo(
                            controller: _cpfController,
                            hint: 'CPF',
                            keyboardType: TextInputType.number,
                            formatter: _cpfMask,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Botão Alterar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Informações alteradas!')),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D4263),
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Alterar',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampo({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    dynamic formatter,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formatter != null ? [formatter] : [],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              const BorderSide(color: Color(0xFF6DBAAA), width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style: const TextStyle(
                  color: Colors.black54, fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          style: const TextStyle(color: Colors.black, fontSize: 14),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
