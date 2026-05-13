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
  final TextEditingController _senhaController = TextEditingController();

  String? _sexoSelecionado;
  String? _tipoTelefoneSelecionado;

  bool _mostrarSenha = false;

  // máscaras
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
    _senhaController.dispose();
    super.dispose();
  }

  void _handleCadastro() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_sexoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione o sexo'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_tipoTelefoneSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione o tipo de telefone'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    debugPrint('Cadastro realizado');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sucesso'),
        content: const Text('Cadastro realizado com sucesso!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
            icon: const Icon(
              Icons.more_horiz,
              color: Color.fromARGB(255, 77, 139, 113),
            ),

            onPressed: () {
              showDialog(
                context: context,

                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  title: Row(
                    children: const [
                      Icon(
                        Icons.support_agent,
                        color: Color(0xFF2D4263),
                      ),

                      SizedBox(width: 10),

                      Text(
                        'Suporte',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  content: const Text(
                    'Precisa de ajuda?\n\nEntre em contato com nossa equipe de suporte para receber assistência sobre cadastro, acesso à conta ou dúvidas relacionadas ao aplicativo.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),

                      child: const Text(
                        'Fechar',
                        style: TextStyle(
                          color: Color(0xFF2D4263),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                const SizedBox(height: 20),

                const Text(
                  'Cadastre-se',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                // nome
                _buildTextField(
                  controller: _nomeController,
                  hintText: 'Nome',

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu nome';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // sobrenome
                _buildTextField(
                  controller: _sobrenomeController,
                  hintText: 'Sobrenome',

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu sobrenome';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // nascimento
                _buildTextField(
                  controller: _nascimentoController,
                  hintText: 'Nascimento',
                  keyboardType: TextInputType.number,
                  inputFormatters: [_nascimentoMask],

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua data';
                    }

                    if (value.length < 10) {
                      return 'Data inválida';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // sexo
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

                // email
                _buildTextField(
                  controller: _emailController,
                  hintText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu e-mail';
                    }

                    if (!value.contains('@')) {
                      return 'E-mail inválido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // tipo telefone
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

                // telefone
                _buildTextField(
                  controller: _telefoneController,
                  hintText: 'Telefone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_telefoneMask],

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu telefone';
                    }

                    if (value.length < 15) {
                      return 'Telefone inválido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // cpf
                _buildTextField(
                  controller: _cpfController,
                  hintText: 'CPF',
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfMask],

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu CPF';
                    }

                    if (value.length < 14) {
                      return 'CPF inválido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // senha
                _buildTextField(
                  controller: _senhaController,
                  hintText: 'Senha',
                  obscureText: !_mostrarSenha,

                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarSenha
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),

                    onPressed: () {
                      setState(() {
                        _mostrarSenha = !_mostrarSenha;
                      });
                    },
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite uma senha';
                    }

                    if (value.length < 6) {
                      return 'Mínimo de 6 caracteres';
                    }

                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Use uma letra maiúscula';
                    }

                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                        .hasMatch(value)) {
                      return 'Use um caractere especial';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _handleCadastro,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D4263),

                    padding: const EdgeInsets.symmetric(vertical: 18),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 77, 139, 113),
        borderRadius: BorderRadius.circular(30),
      ),

      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        obscureText: obscureText,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),

        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: const TextStyle(
            color: Color(0xFFEAF4EF),
            fontSize: 16,
          ),

          suffixIcon: suffixIcon,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),

          border: InputBorder.none,

          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
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
        color: const Color.fromARGB(255, 77, 139, 113),
        borderRadius: BorderRadius.circular(30),
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 4,
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,

          hint: Text(
            hintText,

            style: const TextStyle(
              color: Color(0xFFEAF4EF),
              fontSize: 16,
            ),
          ),

          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),

          dropdownColor: const Color.fromARGB(255, 77, 139, 113),

          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),

          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}