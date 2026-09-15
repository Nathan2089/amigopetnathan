import 'package:flutter/material.dart';
import '../models/caregiver.dart';
import '../styles/app_styles.dart';
import 'caregiver_detail_page.dart';

class CaregiverListPage extends StatefulWidget {
  const CaregiverListPage({super.key});

  @override
  State<CaregiverListPage> createState() => _CaregiverListPageState();
}

class _CaregiverListPageState extends State<CaregiverListPage> {
  final List<Caregiver> _caregivers = [
    const Caregiver(
      name: 'Mariana Silva',
      location: 'Copacabana, Rio de Janeiro',
      rating: 4.9,
      bio: 'Apaixonada por cães e gatos! Ofereço passeios diários de 1h e hospedagem domiciliar com muito carinho.',
      primaryService: 'Hospedagem & Passeio',
      pricePerHour: 45.0,
      distance: 0.8,
    ),
    const Caregiver(
      name: 'Rodrigo Santos',
      location: 'Vila Mariana, São Paulo',
      rating: 4.8,
      bio: 'Especialista em comportamento canino certificado. Ofereço banho e tosa em domicílio.',
      primaryService: 'Passeio Educativo',
      pricePerHour: 50.0,
      distance: 1.2,
    ),
    const Caregiver(
      name: 'Ana Costa',
      location: 'Savassi, Belo Horizonte',
      rating: 5.0,
      bio: 'Estudante de Veterinária de último ano. Cuido do seu pet idoso com aplicação de medicação.',
      primaryService: 'Hospedagem & Cuidados',
      pricePerHour: 60.0,
      distance: 0.5,
    ),
    const Caregiver(
      name: 'Lucas Oliveira',
      location: 'Bom Fim, Porto Alegre',
      rating: 4.7,
      bio: 'Espaço amplo com quintal telado e seguro. Brincadeiras e enriquecimento ambiental.',
      primaryService: 'Hospedagem & Creche',
      pricePerHour: 40.0,
      distance: 2.1,
    ),
    const Caregiver(
      name: 'Beatriz Souza',
      location: 'Gonzaga, Santos',
      rating: 4.9,
      bio: 'Passeadora experiente de cães de grande porte e cat-sitting focado.',
      primaryService: 'Passeio & Cat Sitting',
      pricePerHour: 35.0,
      distance: 1.5,
    ),
  ];

  String _currentSort = 'Mais próximos';

  void _sortCaregivers() {
    setState(() {
      if (_currentSort == 'Mais próximos') {
        _caregivers.sort((a, b) => a.distance.compareTo(b.distance));
      } else if (_currentSort == 'Melhor avaliados') {
        _caregivers.sort((a, b) => b.rating.compareTo(a.rating));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _sortCaregivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: const Text('AmigoPet — Cuidadores'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (String value) {
              _currentSort = value;
              _sortCaregivers();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ordenado por: $value')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem(value: 'Mais próximos', child: Text('Mais próximos')),
              const PopupMenuItem(value: 'Melhor avaliados', child: Text('Melhor avaliados')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _caregivers.length,
        itemBuilder: (context, index) {
          final caregiver = _caregivers[index];
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CaregiverDetailPage(caregiver: caregiver)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppStyles.primaryColor.withAlpha(25),
                      child: Text(
                        caregiver.name.substring(0, 2).toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppStyles.primaryColor),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(caregiver.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(caregiver.primaryService, style: const TextStyle(color: AppStyles.secondaryColor, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('${caregiver.location} (${caregiver.distance} km)', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            Text(caregiver.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('R\$ ${caregiver.pricePerHour.toInt()}/h', style: const TextStyle(color: AppStyles.successColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppStyles.primaryColor),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: AppStyles.primaryColor)),
            accountName: Text('Tutor AmigoPet'),
            accountEmail: Text('tutor@amigopet.com.br'),
          ),
          ListTile(
            leading: const Icon(Icons.pets, color: AppStyles.primaryColor),
            title: const Text('Cuidadores'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Meus agendamentos'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
