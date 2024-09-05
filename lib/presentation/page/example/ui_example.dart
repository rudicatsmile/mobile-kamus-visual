import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orderItems = [
    {'name': 'Ayam Bakar', 'price': 28000, 'image': 'assets/images/camera.png', 'quantity': 1},
    {'name': 'Pecel Ayam', 'price': 25000, 'image': 'assets/images/icon.png', 'quantity': 2},
    // ... tambahkan item lainnya
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = orderItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Saya'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alamat Pengiriman
            _buildAddressContainer(),

            // Daftar Pesanan
            Expanded( // Menggunakan Expanded agar ListView mengisi ruang yang tersedia
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  return _buildOrderItem(orderItems[index]);
                },
              ),
            ),

            // Rincian Pesanan
            SizedBox(height: 20),
            Text('Rincian Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            ListTile(
              title: Text('Total Harga'),
              trailing: Text('Rp. ${totalPrice.toStringAsFixed(0)}'), // Format harga
            ),
            ListTile(
              title: Text('Biaya Pengiriman'),
              trailing: Text('Rp. 10.000'), // Ganti dengan biaya pengiriman yang sesuai
            ),
            ListTile(
              title: Text('Total Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('Rp. ${(totalPrice + 10000).toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            // Tombol Proses Pesanan
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
              child: Text('Proses Pesanan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressContainer() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: ListTile(
      leading: Icon(Icons.location_on, color: Colors.green), // Icon lokasi berwarna hijau
      title: Text('Alamat Pengiriman', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        'Jalan Kampung Harapan No 18\nKec. Mlati, Kab Sleman, Yogyakarta',
        style: TextStyle(fontSize: 14), // Ukuran font lebih kecil untuk subtitle
      ),
      trailing: TextButton(
        onPressed: () {
          // Tambahkan logika untuk mengubah alamat pengiriman di sini
        },
        child: Text('Ubah', style: TextStyle(color: Colors.blue)), // Teks "Ubah" berwarna biru
      ),
    ),
  );
}


  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Card(
      child: ListTile(
        leading: Image.asset(item['image']),
        title: Text(item['name']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Rp. ${item['price'].toStringAsFixed(0)}'),
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                // Logika untuk mengurangi jumlah pesanan
              },
              icon: Icon(Icons.remove),
            ),
            Text('${item['quantity']}'), // Menampilkan jumlah pesanan
            IconButton(
              onPressed: () {
                // Logika untuk menambah jumlah pesanan
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
