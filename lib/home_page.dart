import 'package:flutter/material.dart';
import 'package:uts_flutter/ProfileScreen.dart';
import 'transaction_page.dart'; // Impor TransactionScreen
import 'transaction_model.dart'; // Impor model Transaction

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen() // Pastikan Anda memiliki ProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Wisata Pangandaran'),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Navigasi ke halaman transaksi
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionScreen(
                        itemName: 'Keranjang', // Placeholder, bisa disesuaikan
                        itemPrice: '0', // Placeholder, bisa disesuaikan
                        itemDescription:
                            'Keranjang Belanja Anda', // Placeholder, bisa disesuaikan
                      )),
            );
          },
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget _buildBackgroundImage() {
    return const Image(
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      image: AssetImage('assets/Background1.jpg'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  // Daftar nama untuk ditampilkan di GridView
  final List<String> itemNames = [
    'Pasir Putih',
    'Pantai Pangandaran',
    'Pangandaran Sunset',
    'Pantai Batu Hiu',
    'Pantai Batu Karas',
    'Pantai Madasari',
    'Cagar alam Pangandaran',
  ];

  // Daftar gambar yang sesuai dengan nama tempat wisata
  final List<String> itemImages = [
    'assets/Suasana-di-pasir-putih-pantai-barat-Pangandaran-Minggu-13112022.jpg',
    'assets/8cb117b8d35823f828eb8c5a5165a9cc (1).jpg',
    'assets/5db5653fe4ccf.jpg',
    'assets/Batu-Hiu-Pangandaran-tempat-selfie.jpg',
    'assets/potret-pesona-pantai-batukaras-pangandaran-662-l.jpg',
    'assets/pantai-madasari-dari.jpg',
    'assets/IMG_20230519_170217-scaled.jpg',
  ];

  // Daftar keterangan untuk setiap item
  final List<String> itemDescriptions = [
    'Pasir Putih adalah pantai yang terkenal dengan pasirnya yang putih dan halus.',
    'Pantai Pangandaran adalah salah satu pantai terpopuler di Jawa Barat.',
    'Pangandaran Sunset menawarkan pemandangan matahari terbenam yang menakjubkan.',
    'Pantai Batu Hiu terkenal dengan batu karangnya yang unik.',
    'Pantai Batu Karas adalah tempat yang ideal untuk berselancar.',
    'Pantai Madasari adalah pantai yang tenang dan cocok untuk bersantai.',
    'Cagar alam Pangandaran adalah tempat yang kaya akan flora dan fauna.',
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

  @override
  Widget build(BuildContext context) {
    // Filter item berdasarkan pencarian
    final filteredItemNames = itemNames
        .where(
            (name) => name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          // TextField untuk pencarian di AppBar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari tempat wisata...',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update kata kunci pencarian
                });
              },
            ),
          ),
          // GridView horizontal
          Container(
            height: 150,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Hanya satu kolom
                childAspectRatio: 0.8, // Rasio aspek untuk item
                crossAxisSpacing: 4.0, // Jarak horizontal antar item
                mainAxisSpacing: 4.0, // Jarak vertikal antar item
              ),
              itemCount: filteredItemNames
                  .length, // Jumlah item berdasarkan daftar nama
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman Transaksi dengan informasi item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionScreen(
                          itemName: filteredItemNames[index],
                          itemPrice: itemPrices[
                              itemNames.indexOf(filteredItemNames[index])],
                          itemDescription: itemDescriptions[
                              itemNames.indexOf(filteredItemNames[index])],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(
                        4.0), // Mengurangi margin untuk item
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            itemImages[itemNames.indexOf(filteredItemNames[
                                index])], // Menampilkan gambar
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              4.0), // Mengurangi padding untuk teks
                          child: Column(
                            children: [
                              Text(filteredItemNames[
                                  index]), // Menampilkan nama item
                              Text(
                                  itemPrices[itemNames
                                      .indexOf(filteredItemNames[index])],
                                  style: TextStyle(
                                      fontWeight: FontWeight
                                          .bold)), // Menampilkan harga
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // GridView vertikal
          GridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada GridView ini
            shrinkWrap:
                true, // Mengatur ukuran GridView agar sesuai dengan konten
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Jumlah kolom untuk GridView vertikal
              childAspectRatio: 0.9, // Rasio aspek untuk item
              crossAxisSpacing: 4.0, // Jarak horizontal antar item
              mainAxisSpacing: 5.0, // Jarak vertikal antar item
            ),
            itemCount:
                filteredItemNames.length, // Jumlah item berdasarkan daftar nama
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman Transaksi dengan informasi item
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionScreen(
                        itemName: filteredItemNames[index],
                        itemPrice: itemPrices[
                            itemNames.indexOf(filteredItemNames[index])],
                        itemDescription: itemDescriptions[
                            itemNames.indexOf(filteredItemNames[index])],
                      ),
                    ),
                  );
                },
                child: Card(
                  margin:
                      const EdgeInsets.all(4.0), // Mengurangi margin untuk item
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          itemImages[itemNames.indexOf(
                              filteredItemNames[index])], // Menampilkan gambar
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            4.0), // Mengurangi padding untuk teks
                        child: Column(
                          children: [
                            Text(filteredItemNames[
                                index]), // Menampilkan nama item
                            Text(
                                itemPrices[itemNames
                                    .indexOf(filteredItemNames[index])],
                                style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold)), // Menampilkan harga
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
