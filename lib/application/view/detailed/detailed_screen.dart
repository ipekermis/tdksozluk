import 'package:flutter/material.dart';
import 'package:tdksozluk/application/models/tdk_models.dart';

class DetailScreen extends StatelessWidget {
  final Madde madde;

  const DetailScreen({super.key, required this.madde});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 40,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFCC2041),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        "Geri",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 69),
                      const Text(
                        "Kelimeler",
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // IconButton kadar boşluk
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Kelime
                  Center(
                    child: Text(
                      madde.madde,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (madde.lisan != null && madde.lisan!.isNotEmpty)
                    Center(
                      child: Text(
                        '(${madde.lisan} kökenli)',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(Icons.volume_up, 'Dinle'),
                      _buildButton(Icons.back_hand, 'El İşareti'),
                      _buildButton(Icons.star_border, 'Kaydet'),
                      _buildButton(Icons.copy, 'Kopyala'),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: const TabBar(
                indicatorColor: Color(0xFFCC2041),
                labelColor: Color(0xFFCC2041),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Açıklama'),
                  Tab(text: 'Birleşik Kelimeler'),
                  Tab(text: 'Atasözleri'),
                ],
              ),
            ),

            if (madde.anlamlarListe.isNotEmpty)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),

                  child: ListView.builder(
                    //shrinkWrap: true,
                    // İçeriği kadar yer kapla
                    //physics: const NeverScrollableScrollPhysics(),
                    // Dış SingleChildScrollView ile çakışmaması için
                    itemCount: madde.anlamlarListe.length,
                    itemBuilder: (context, index) {
                      final Anlam anlam = madde.anlamlarListe[index];

                      return Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${anlam.anlamSira}. '
                                '${anlam.ozelliklerListe != null && anlam.ozelliklerListe!.isNotEmpty ? anlam.ozelliklerListe!.map((o) => o.tamAdi).join(', ') : ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 4.0,
                            ),
                            child: Text(
                              anlam.anlam,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          if (anlam.orneklerListe != null &&
                              anlam.orneklerListe!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    anlam.orneklerListe!
                                        .map(
                                          (ornek) => Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 4.0,
                                            ),
                                            child: Text(
                                              '"${ornek.ornek}" ${ornek.yazar != null && ornek.yazar.isNotEmpty ? '- ${ornek.yazar.first.tamAdi}' : ''}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                          if (index < madde.anlamlarListe.length - 1)
                            const SizedBox(
                              height: 15,
                              child: Divider(height: 1, thickness: 0.8),
                            ),


                        ],
                      );
                    },
                  ),
                ),
              )
            else
              const Center(child: Text('Bu kelime için anlam bulunamadı.')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,

          selectedItemColor: Color(0xFFCC2041),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: 1,


          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              label: 'Kayıtlı',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Geçmiş'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Container(
      width: 60,
      height: 70,
      //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFA51D3D),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, color: Colors.white, size: 28),
          SizedBox(height: 5),

          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
