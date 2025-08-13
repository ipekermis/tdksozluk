class Madde {
  final String madde;
  final String? lisan; // Yeni: Lisan bilgisi eklendi
  final String? telaffuz; // Yeni: Telaffuz bilgisi eklendi
  final List<Anlam> anlamlarListe;

  const Madde({
    required this.madde,
    this.lisan,
    this.telaffuz, // Constructor'a eklendi
    required this.anlamlarListe,
  });

// FromJson metodu burada gerekli değil, MaddeDto'dan dönüştüreceğiz
}
class Anlam {
  final String anlam;
  final String? anlamSira;
  // Bu listeler null olabilir, bu yüzden '?' koyuyoruz
  final List<Ornek>? orneklerListe; // Artık 'required' değil, nullable
  final List<Ozellik>? ozelliklerListe; // Artık 'required' değil, nullable

  const Anlam({
    required this.anlam,
    this.anlamSira,
    this.orneklerListe, // 'required' kaldırıldı
    this.ozelliklerListe, // 'required' kaldırıldı
  });
}

class Ornek {
  final String ornek;
  final List<Yazar> yazar; // Yeni: Yazar bilgisi eklendi

  const Ornek({
    required this.ornek,
    required this.yazar,
  });
}

class Yazar {
  final String tamAdi; // Tam adı kullanacağız

  const Yazar({
    required this.tamAdi,
  });
}

class Ozellik {
  final String tamAdi; // Tam adı kullanacağız

  const Ozellik({
    required this.tamAdi,
  });
}