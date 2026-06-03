import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C&C Turismo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF2E7D32),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    _PacotesScreen(),
    _PromocoesScreen(),
    _AgendaScreen(),
    _SobreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: _TopTabBar(
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}

// tabela

class _TopTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _TopTabBar({required this.selectedIndex, required this.onTap});

  static const _tabs = [
    (icon: Icons.work_outline,             label: 'Pacotes'),
    (icon: Icons.directions_bus_outlined,  label: 'Promoções'),
    (icon: Icons.calendar_month_outlined,  label: 'Agenda'),
    (icon: Icons.people_outline,           label: 'Sobre'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_tabs.length, (i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF2E7D32).withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _tabs[i].icon,
                    color: selected ? const Color(0xFF2E7D32) : Colors.black45,
                    size: 26,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _tabs[i].label,
                    style: TextStyle(
                      fontSize: 11,
                      color: selected ? const Color(0xFF2E7D32) : Colors.black45,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Telas 

class _PacotesScreen extends StatelessWidget {
  const _PacotesScreen();
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Pacotes', style: TextStyle(fontSize: 20, color: Colors.black54)),
      );
}

class _PromocoesScreen extends StatelessWidget {
  const _PromocoesScreen();
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Promoções', style: TextStyle(fontSize: 20, color: Colors.black54)),
      );
}

class _AgendaScreen extends StatelessWidget {
  const _AgendaScreen();
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Agenda', style: TextStyle(fontSize: 20, color: Colors.black54)),
      );
}

class _SobreScreen extends StatelessWidget {
  const _SobreScreen();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Quem somos nós?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/cidinha_conrado.png',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 220,
                      color: const Color(0xFF5B8A5B),
                      child: const Center(
                        child: Icon(Icons.people, size: 80, color: Colors.white54),
                      ),
                    ),
                  ),
                  _label('Cidinha', top: 12, left: 16),
                  _label('Conrado', top: 12, right: 16),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white.withOpacity(0.92),
                      child: const Text(
                        'A C&C Turismo é uma agência que está há mais 10 anos no '
                        'mercado com o objetivo de levar pessoas para realizarem seus sonhos.',
                        style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '"O melhor caminho para o seu destino!"',
              style: TextStyle(
                fontSize: 13,
                color: Colors.green.shade700,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              '@ccturismosjc',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _label(String text, {double? top, double? left, double? right}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}