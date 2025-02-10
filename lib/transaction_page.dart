import 'package:flutter/material.dart';
import 'transaction_model.dart'; // Impor model Transaction

class TransactionScreen extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String itemDescription;

  const TransactionScreen({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
  }) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Transaction> transactions = [];
  String?
      selectedPaymentMethod; // Variabel untuk menyimpan metode pembayaran yang dipilih
  String? voucherCode; // Variabel untuk menyimpan kode voucher
  double discount = 0.0; // Variabel untuk menyimpan diskon

  @override
  void initState() {
    super.initState();
    // Tambahkan transaksi awal
    transactions.add(Transaction(
      itemName: widget.itemName,
      itemPrice: widget.itemPrice,
      itemDescription: widget.itemDescription,
      quantity: 1, // Set kuantitas awal
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showSelectTourDialog(
                  context); // Tampilkan dialog untuk memilih wisata
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(transactions[index].itemName),
                      subtitle: Text(
                          'Harga: ${transactions[index].itemPrice} x ${transactions[index].quantity}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTransaction(index);
                        },
                      ),
                      onTap: () {
                        _showEditTransactionDialog(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPaymentOption(Icons.account_balance_wallet, 'E-Wallet'),
                _buildPaymentOption(Icons.credit_card, 'Kartu Kredit'),
                _buildPaymentOption(Icons.money, 'Tunai'),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Kode Voucher (jika ada)'),
              onChanged: (value) {
                setState(() {
                  voucherCode = value; // Simpan kode voucher
                });
              },
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                _applyVoucher(); // Terapkan voucher
              },
              child: const Text('Terapkan Voucher'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showPaymentDialog(context);
              },
              child: const Text('Bayar Sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method; // Set metode pembayaran yang dipilih
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: selectedPaymentMethod == method ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 4.0),
          Text(
            method,
            style: TextStyle(
              color:
                  selectedPaymentMethod == method ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectTourDialog(BuildContext context) {
    // Daftar nama wisata
    final List<String> itemNames = [
      'Pasir Putih',
      'Pantai Pangandaran',
      'Pangandaran Sunset',
      'Pantai Batu Hiu',
      'Pantai Batu Karas',
      'Pantai Madasari',
      'Cagar alam Pangandaran',
    ];

    // Daftar harga untuk setiap item
    final List<String> itemPrices = [
      'Rp 50.000',
      'Rp 75.000',
      'Rp 100.000',
      'Rp 60.000',
      'Rp 80.000',
      'Rp 70.000',
      'Rp 40.000',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Wisata'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: itemNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(itemNames[index]),
                  subtitle: Text(itemPrices[index]),
                  onTap: () {
                    // Tambahkan transaksi otomatis menggunakan informasi dari item yang dipilih
                    setState(() {
                      transactions.add(Transaction(
                        itemName: itemNames[index],
                        itemPrice: itemPrices[index],
                        itemDescription:
                            'Deskripsi untuk ${itemNames[index]}', // Anda bisa menambahkan deskripsi yang sesuai
                        quantity: 1, // Set kuantitas awal
                      ));
                    });
                    Navigator.of(context).pop(); // Tutup dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${itemNames[index]} ditambahkan ke keranjang')),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTransactionDialog(BuildContext context, int index) {
    final TextEditingController nameController =
        TextEditingController(text: transactions[index].itemName);
    final TextEditingController priceController =
        TextEditingController(text: transactions[index].itemPrice);
    final TextEditingController descriptionController =
        TextEditingController(text: transactions[index].itemDescription);

    // Menyimpan nilai kuantitas saat ini
    double currentQuantity = transactions[index].quantity.toDouble();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Transaksi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Item'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              const SizedBox(height: 16.0),
              Text(
                  'Kuantitas: ${currentQuantity.toInt()}'), // Menampilkan kuantitas saat ini
              Slider(
                value: currentQuantity,
                min: 1,
                max: 10,
                divisions: 9, // Membagi slider menjadi 9 bagian (1-10)
                label: currentQuantity.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    currentQuantity = value; // Update nilai kuantitas
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Update transaksi
                setState(() {
                  transactions[index] = Transaction(
                    itemName: nameController.text,
                    itemPrice: priceController.text,
                    itemDescription: descriptionController.text,
                    quantity: currentQuantity.toInt(), // Mengatur kuantitas
                  );
                });
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index); // Hapus transaksi
    });
  }

  void _applyVoucher() {
    // Logika untuk menerapkan voucher diskon
    if (voucherCode == 'DISKON10') {
      setState(() {
        discount = 0.1; // Diskon 10%
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voucher berhasil diterapkan!')),
      );
    } else {
      setState(() {
        discount = 0.0; // Tidak ada diskon
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voucher tidak valid!')),
      );
    }
  }

  void _showPaymentDialog(BuildContext context) {
    if (selectedPaymentMethod == null) {
      // Tampilkan pesan jika metode pembayaran belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih metode pembayaran')),
      );
      return;
    }

    // Hitung total harga setelah diskon
    double totalPrice = 0.0;
    for (var transaction in transactions) {
      double price = double.tryParse(transaction.itemPrice
              .replaceAll('Rp ', '')
              .replaceAll('.', '')) ??
          0.0;
      totalPrice += price * transaction.quantity;
    }
    totalPrice -= totalPrice * discount; // Terapkan diskon

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pembayaran Berhasil'),
          content: Text(
              'Pembayaran Anda menggunakan $selectedPaymentMethod telah berhasil diproses.\nTotal yang harus dibayar: Rp ${totalPrice.toStringAsFixed(2)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
