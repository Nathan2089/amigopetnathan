import 'package:flutter/material.dart';
import '../models/caregiver.dart';
import '../styles/app_styles.dart';

class CaregiverDetailPage extends StatefulWidget {
  final Caregiver caregiver;

  const CaregiverDetailPage({super.key, required this.caregiver});

  @override
  State<CaregiverDetailPage> createState() => _CaregiverDetailPageState();
}

class _CaregiverDetailPageState extends State<CaregiverDetailPage> {
  String _selectedService = 'Não selecionado';

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Agendamento'),
        content: Text('Deseja cancelar o agendamento com ${widget.caregiver.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Voltar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Agendamento cancelado.'), backgroundColor: AppStyles.errorColor),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppStyles.errorColor, foregroundColor: Colors.white),
            child: const Text('Sim, Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showServiceDialog() {
    showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Selecione o Tipo de Serviço'),
        children: ['Passeio', 'Hospedagem', 'Banho e tosa']
            .map((service) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, service),
                  child: Padding(padding: const EdgeInsets.all(8.0), child: Text(service)),
                ))
            .toList(),
      ),
    ).then((value) {
      if (value != null && mounted) {
        setState(() => _selectedService = value);
      }
    });
  }

  void _showMoreOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share, color: Colors.blue),
              title: const Text('Compartilhar perfil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.report, color: AppStyles.errorColor),
              title: const Text('Denunciar perfil'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.caregiver.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppStyles.primaryColor.withAlpha(25),
                child: Text(
                  widget.caregiver.name.substring(0, 2).toUpperCase(),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppStyles.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text(widget.caregiver.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            Center(child: Text(widget.caregiver.primaryService, style: const TextStyle(color: AppStyles.secondaryColor, fontWeight: FontWeight.bold))),
            const SizedBox(height: 16),
            const Text('Sobre mim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.caregiver.bio, style: const TextStyle(fontSize: 15, height: 1.5)),
            const Divider(height: 32),
            Text('Preço: R\$ ${widget.caregiver.pricePerHour.toStringAsFixed(2)}/h', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Serviço Atual: $_selectedService', style: const TextStyle(fontSize: 16, color: Colors.blueGrey)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _showServiceDialog,
              icon: const Icon(Icons.room_service),
              label: const Text('Tipo de serviço'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _showMoreOptionsBottomSheet,
              icon: const Icon(Icons.more_horiz),
              label: const Text('Mais opções'),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: _showCancelDialog,
              icon: const Icon(Icons.cancel, color: AppStyles.errorColor),
              label: const Text('Cancelar agendamento', style: TextStyle(color: AppStyles.errorColor, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
