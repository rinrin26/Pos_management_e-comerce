import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/profile.jpg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rinrin Karmila',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'rinrin@gmail.com',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pesanan Saya',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _orderStatusItemWidget(Icons.pending, 'Belum Bayar'),
                      _orderStatusItemWidget(Icons.local_shipping, 'Dikemas'),
                      _orderStatusItemWidget(
                          Icons.local_shipping_outlined, 'Dikirim'),
                      _orderStatusItemWidget(
                          Icons.rate_review, 'Beri Penilaian'),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _menuItemWidget(Icons.history, 'Terakhir Dilihat'),
                  _menuItemWidget(Icons.card_giftcard, 'Voucher Saya'),
                  _menuItemWidget(Icons.book, 'Katalog Saya'),
                  _menuItemWidget(Icons.favorite, 'Favorite Saya'),
                  _menuItemWidget(Icons.help_outline, 'Pusat Bantuan'),
                  _menuItemWidget(Icons.settings, 'Pengaturan Akun'),
                  _menuItemWidget(Icons.chat, 'Chat dengan CS'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderStatusItemWidget(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.grey.shade800,),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _menuItemWidget(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
      },
    );
  }
}
