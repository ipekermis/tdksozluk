class Madde {
  final String madde;
  final List<Anlam> anlamlarListe;

  const Madde({
    required this.madde,
    required this.anlamlarListe,
  });

  factory Madde.fromJson(Map<String, dynamic> json) {
    return Madde(
      madde: json['madde'] ?? '',
      anlamlarListe: (json['anlamlarListe'] as List<dynamic>?)
          ?.map((e) => Anlam.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'madde': madde,
      'anlamlarListe': anlamlarListe.map((e) => e.toJson()).toList(),
    };
  }
}
class Anlam {
  final String anlam;

  const Anlam({
    required this.anlam,
  });

  factory Anlam.fromJson(Map<String, dynamic> json) {
    return Anlam(
      anlam: json['anlam'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anlam': anlam,
    };
  }
}