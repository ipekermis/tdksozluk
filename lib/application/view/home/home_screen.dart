

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tdksozluk/application/repository/tdk_repository.dart';

import '../../models/tdk_models.dart';
import 'home_contoller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TDKRepository _tdkRepository = TDKRepository();

  // 'Ezel' kelimesinin future'ını burada tutacağız
  late Future<Madde?> _ezelMaddeFuture;

  @override
  void initState() {
    super.initState();

    _ezelMaddeFuture = _tdkRepository.getMaddeItem('ezel');
  }
  Future<Madde?> _getHistoryMaddeFuture(String word) {

    return  _tdkRepository.getMaddeItem(word);
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
              height: 180,
              decoration: BoxDecoration(
                color: Color(0xFFCC2041),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {

                        },
                      ),SizedBox(width: 95,),
                      Text(
                        "SÖZLÜK",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: homeController.textController,
                    //onChanged: (value) => homeController.onTextChanged(),
                    onSubmitted:
                        (value) => homeController.onSubmit(value, context),
                    decoration: InputDecoration(
                      hintText: 'Sözlük’te Ara...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      suffixIcon: Icon(Icons.mic, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (context.watch<HomeController>().searchHistory.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(color: Colors.white),
              height: 650,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 20,
                          ), // Saat ikonu
                          const SizedBox(width: 8),
                          const Text(
                            "SON ARAMALAR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                      onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              "GEÇMİŞE GİT",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xA7E8EEFF),
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,

                        itemCount:
                            homeController.searchHistory.length > 4
                                ? 4
                                : homeController.searchHistory.length,
                        itemBuilder: (context, index) {

                          final word = homeController.searchHistory[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.circle,
                                  color: Color(0xFFCC2041),
                                  size: 8,
                                ),
                                title: Text(
                                  word,
                                  overflow: TextOverflow.ellipsis,
                                ),subtitle: FutureBuilder<Madde?>(
                                future: _getHistoryMaddeFuture(word),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text(
                                      'Yüklenemedi',
                                      style: TextStyle(fontSize: 13, color: Color(0xFFCC2041)),
                                    );
                                  } else if (snapshot.data == null) {
                                    return const Text(
                                      'Yüklenemedi',
                                      style: TextStyle(fontSize: 13, color: Colors.grey),
                                    );
                                  } else {
                                    final Madde madde = snapshot.data!;
                                    String meaningText = madde.anlamlarListe.isNotEmpty
                                        ? madde.anlamlarListe.first.ozelliklerListe![0].tamAdi
                                        : '';

                                    return Text(
                                      meaningText,
                                      style: const TextStyle(fontSize: 13, color: Colors.grey),

                                    );
                                  }
                                },
                              ),
                                onTap: () {

                                  homeController.onSubmit(word, context);
                                },
                                trailing: IconButton(
                                  icon: Icon(
                                    homeController.isFavorite(word) ? Icons.star : Icons.star_border,
                                    color: homeController.isFavorite(word) ? Colors.yellow[700] : Colors.grey,
                                  ),
                                  onPressed: () {
                                    homeController.toggleFavorite(word);
                                  },
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,

                                ),
                              ),
                              if (index !=
                                  3)
                                Divider(height: 1, thickness: 0.8),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [

                      Icon(Icons.circle, color: Color(0xFFCC2041), size: 8),
                      const SizedBox(width: 8),

                      Text(
                        "BİR KELİME",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<Madde?>(
                            future: _ezelMaddeFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    'Ezel kelimesi yüklenirken bir hata oluştu: ${snapshot.error.toString()}',
                                  ),
                                );
                              } else if (snapshot.data == null) {
                                return const Center(
                                  child: Text(
                                    '\'Ezel\' kelimesi bulunamadı veya yüklenemedi.',
                                  ),
                                );
                              } else {
                                final Madde madde = snapshot.data!;
                                final Anlam anlam = madde.anlamlarListe[0];

                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      madde.madde,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),


                                    if (madde.lisan != null &&
                                        madde.lisan!.isNotEmpty)
                                      Text(
                                        '(${madde.lisan} kökenli)',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                      ),



                                    Padding(

                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 4.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                            if (anlam.ozelliklerListe != null &&
                                                anlam.ozelliklerListe!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                                                child: Text("${anlam.anlamSira}. ${anlam.ozelliklerListe![0].tamAdi}"
                                                  ,
                                                  style:  TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    color: Color(0xFFCC2041),
                                                  ),
                                                ),
                                              ),
                                            Text(
                                              ' ${anlam.anlam}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),

                                            if (anlam.orneklerListe != null &&
                                                anlam
                                                    .orneklerListe!
                                                    .isNotEmpty)
                                              ...anlam.orneklerListe!
                                                  .map(
                                                    (ornek) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            left: 16.0,
                                                            top: 2.0,
                                                          ),
                                                      child: Text(
                                                        '  - ${ornek.ornek}${' (${ornek.yazar!.first.tamAdi})' }',
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle
                                                                  .italic,
                                                          color:
                                                              Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),

                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      )
                                    ,
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: Color(0xFFCC2041),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {
          // Navigasyon işlemleri
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa',backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Kayıtlı',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Geçmiş'),
        ],
      ),
    );
  }
}
