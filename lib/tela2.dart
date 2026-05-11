import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  String? _sexoSelecionado;
  String? _tipoTelefoneSelecionado;

  // Máscaras de formatação
  final _cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _nascimentoMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _nascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  void _handleCadastro() {
    // Validar campos obrigatórios
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validar dropdowns
    if (_sexoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione o sexo'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_tipoTelefoneSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione o tipo de telefone'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Processar o cadastro
    print('=== DADOS DO CADASTRO ===');
    print('Nome: ${_nomeController.text}');
    print('Sobrenome: ${_sobrenomeController.text}');
    print('Nascimento: ${_nascimentoController.text}');
    print('Sexo: $_sexoSelecionado');
    print('E-mail: ${_emailController.text}');
    print('Tipo de telefone: $_tipoTelefoneSelecionado');
    print('Telefone: ${_telefoneController.text}');
    print('CPF: ${_cpfController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );

    // Voltar para a tela de login após 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Color(0xFF6B9080)),
            onPressed: () {
              // Ação do menu
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Menu'),
                  content: const Text('Opções adicionais'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Cadastre-se',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // ================= NOME =================
                _buildTextField(
                  controller: _nomeController,
                  hintText: 'Nome',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ================= SOBRENOME =================
                _buildTextField(
                  controller: _sobrenomeController,
                  hintText: 'Sobrenome',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu sobrenome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ================= NASCIMENTO =================
                _buildTextField(
                  controller: _nascimentoController,
                  hintText: 'Nascimento',
                  keyboardType: TextInputType.number,
                  inputFormatters: [_nascimentoMask],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    if (value.length < 10) {
                      return 'Data inválida (DD/MM/AAAA)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ================= SEXO =================
                _buildDropdownField(
                  value: _sexoSelecionado,
                  hintText: 'Sexo',
                  items: ['Masculino', 'Feminino', 'Outro'],
                  onChanged: (value) {
                    setState(() {
                      _sexoSelecionado = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // ================= E-MAIL =================
                _buildTextField(
                  controller: _emailController,
                  hintText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ================= TIPO DE TELEFONE =================
                _buildDropdownField(
                  value: _tipoTelefoneSelecionado,
                  hintText: 'Tipo de telefone',
                  items: ['Celular', 'Residencial', 'Comercial'],
                  onChanged: (value) {
                    setState(() {
                      _tipoTelefoneSelecionado = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // ================= TELEFONE =================
                _buildTextField(
                  controller: _telefoneController,
                  hintText: 'Telefone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_telefoneMask],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu telefone';
                    }
                    if (value.length < 15) {
                      return 'Telefone inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ================= CPF =================
                _buildTextField(
                  controller: _cpfController,
                  hintText: 'CPF',
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfMask],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CPF';
                    }
                    if (value.length < 14) {
                      return 'CPF inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // ================= BOTÃO CONCLUIR =================
                ElevatedButton(
                  onPressed: _handleCadastro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D4263),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Concluir',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    List<MaskTextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6B9080),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        style: const TextStyle(color: Color(0xFF2D4A3E), fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF2D4A3E), fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6B9080),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hintText,
            style: const TextStyle(color: Color(0xFF2D4A3E), fontSize: 16),
          ),
          icon: const Icon(Icons.check, color: Color(0xFF2D4A3E)),
          dropdownColor: const Color(0xFF6B9080),
          style: const TextStyle(color: Color(0xFF2D4A3E), fontSize: 16),
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
