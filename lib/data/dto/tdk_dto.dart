
import 'package:tdksozluk/application/models/tdk_models.dart';

class MaddeDto {
  final String? maddeId;
  final String? kac;
  final String? kelimeNo;
  final String? cesit;
  final String? anlamGor;
  final String? onTaki;
  final String? onTakiHtml;
  final String madde;
  final String? maddeHtml;
  final String? cesitSay;
  final String? anlamSay;
  final String? taki;
  final String? cogulMu;
  final String? ozelMi;
  final String? egikMi;
  final String? lisanKodu;
  final String? lisan;
  final String? telaffuzHtml;
  final String? lisanHtml;
  final String? telaffuz;
  final String? birlesikler;
  final String? font;
  final String? maddeDuz;
  final String? gosterimTarihi;
  final List<AnlamDto> anlamlarListe;

  const MaddeDto({
    this.maddeId,
    this.kac,
    this.kelimeNo,
    this.cesit,
    this.anlamGor,
    this.onTaki,
    this.onTakiHtml,
    required this.madde,
    this.maddeHtml,
    this.cesitSay,
    this.anlamSay,
    this.taki,
    this.cogulMu,
    this.ozelMi,
    this.egikMi,
    this.lisanKodu,
    this.lisan,
    this.telaffuzHtml,
    this.lisanHtml,
    this.telaffuz,
    this.birlesikler,
    this.font,
    this.maddeDuz,
    this.gosterimTarihi,
    required this.anlamlarListe,
  });

  factory MaddeDto.fromJson(Map<String, dynamic> json) => MaddeDto(
    maddeId: json["madde_id"] as String?,
    kac: json["kac"] as String?,
    kelimeNo: json["kelime_no"] as String?,
    cesit: json["cesit"] as String?,
    anlamGor: json["anlam_gor"] as String?,
    onTaki: json["on_taki"] as String?,
    onTakiHtml: json["on_taki_html"] as String?,
    madde: json["madde"] as String,
    maddeHtml: json["madde_html"] as String?,
    cesitSay: json["cesit_say"] as String?,
    anlamSay: json["anlam_say"] as String?,
    taki: json["taki"] as String?,
    cogulMu: json["cogul_mu"] as String?,
    ozelMi: json["ozel_mi"] as String?,
    egikMi: json["egik_mi"] as String?,
    lisanKodu: json["lisan_kodu"] as String?,
    lisan: json["lisan"] as String?,
    telaffuzHtml: json["telaffuz_html"] as String?,
    lisanHtml: json["lisan_html"] as String?,
    telaffuz: json["telaffuz"] as String?,
    birlesikler: json["birlesikler"] as String?,
    font: json["font"] as String?,
    maddeDuz: json["madde_duz"] as String?,
    gosterimTarihi: json["gosterim_tarihi"] as String?,
    anlamlarListe: (json["anlamlarListe"] as List<dynamic>?)
        ?.map((x) => AnlamDto.fromJson(x as Map<String, dynamic>)) // AnlamDto
        .toList() ??
        [],
  );
  Madde toMadde() {
    return Madde(
      madde: madde,
      anlamlarListe: anlamlarListe.map((e) => e.toAnlam()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "madde_id": maddeId,
    "kac": kac,
    "kelime_no": kelimeNo,
    "cesit": cesit,
    "anlam_gor": anlamGor,
    "on_taki": onTaki,
    "on_taki_html": onTakiHtml,
    "madde": madde,
    "madde_html": maddeHtml,
    "cesit_say": cesitSay,
    "anlam_say": anlamSay,
    "taki": taki,
    "cogul_mu": cogulMu,
    "ozel_mi": ozelMi,
    "egik_mi": egikMi,
    "lisan_kodu": lisanKodu,
    "lisan": lisan,
    "telaffuz_html": telaffuzHtml,
    "lisan_html": lisanHtml,
    "telaffuz": telaffuz,
    "birlesikler": birlesikler,
    "font": font,
    "madde_duz": maddeDuz,
    "gosterim_tarihi": gosterimTarihi,
    "anlamlarListe": List<dynamic>.from(anlamlarListe.map((x) => x.toJson())),
  };
}

class AnlamDto {
  final String? anlamId;
  final String? maddeId;
  final String? anlamSira;
  final String? fiil;
  final String? tipkes;
  final String anlam;
  final String? anlamHtml;
  final String? gos;
  final String? gosKelime;
  final String? gosKultur;
  final List<OrnekDto> orneklerListe;
  final List<OzellikDto> ozelliklerListe;

  const AnlamDto({
    this.anlamId,
    this.maddeId,
    this.anlamSira,
    this.fiil,
    this.tipkes,
    required this.anlam,
    this.anlamHtml,
    this.gos,
    this.gosKelime,
    this.gosKultur,
    required this.orneklerListe,
    required this.ozelliklerListe,
  });

  factory AnlamDto.fromJson(Map<String, dynamic> json) {
    final String parsedAnlam = json["anlam"] as String? ?? '';
    final List<dynamic>? rawOrneklerList = json["orneklerListe"];
    final List<OrnekDto> parsedOrneklerListe = rawOrneklerList != null
        ? List<OrnekDto>.from(rawOrneklerList.map((x) => OrnekDto.fromJson(x as Map<String, dynamic>))) // OrnekDto
        : [];
    final List<dynamic>? rawOzelliklerList = json["ozelliklerListe"];
    final List<OzellikDto> parsedOzelliklerListe = rawOzelliklerList != null
        ? List<OzellikDto>.from(rawOzelliklerList.map((x) => OzellikDto.fromJson(x as Map<String, dynamic>))) // OzellikDto
        : [];
    return AnlamDto(
      anlamId: json["anlam_id"] as String?,
      maddeId: json["madde_id"] as String?,
      anlamSira: json["anlam_sira"] as String?,
      fiil: json["fiil"] as String?,
      tipkes: json["tipkes"] as String?,
      anlam: parsedAnlam,
      anlamHtml: json["anlam_html"] as String?,
      gos: json["gos"] as String?,
      gosKelime: json["gos_kelime"] as String?,
      gosKultur: json["gos_kultur"] as String?,
      orneklerListe: parsedOrneklerListe,
      ozelliklerListe: parsedOzelliklerListe,
    );
  }
  Anlam toAnlam() {
    return Anlam(anlam: anlam);
  }

  Map<String, dynamic> toJson() => {
    "anlam_id": anlamId,
    "madde_id": maddeId,
    "anlam_sira": anlamSira,
    "fiil": fiil,
    "tipkes": tipkes,
    "anlam": anlam,
    "anlam_html": anlamHtml,
    "gos": gos,
    "gos_kelime": gosKelime,
    "gos_kultur": gosKultur,
    "orneklerListe": List<dynamic>.from(orneklerListe.map((x) => x.toJson())),
    "ozelliklerListe": List<dynamic>.from(ozelliklerListe.map((x) => x.toJson())),
  };
}

class OrnekDto {
  final String? ornekId;
  final String? anlamId;
  final String? ornekSira;
  final String ornek;
  final String? kac;
  final String? yazarId;
  final String? yazarVd;
  final List<YazarDto> yazar;

  const OrnekDto({
    this.ornekId,
    this.anlamId,
    this.ornekSira,
    required this.ornek,
    this.kac,
    this.yazarId,
    this.yazarVd,
    required this.yazar,
  });

  factory OrnekDto.fromJson(Map<String, dynamic> json) {
    final String parsedOrnek = json["ornek"] as String? ?? '';
    final List<dynamic>? rawYazarList = json["yazar"];
    final List<YazarDto> parsedYazarList = rawYazarList != null
        ? List<YazarDto>.from(rawYazarList.map((x) => YazarDto.fromJson(x as Map<String, dynamic>))) // YazarDto
        : [];
    return OrnekDto(
      ornekId: json["ornek_id"] as String?,
      anlamId: json["anlam_id"] as String?,
      ornekSira: json["ornek_sira"] as String?,
      ornek: parsedOrnek,
      kac: json["kac"] as String?,
      yazarId: json["yazar_id"] as String?,
      yazarVd: json["yazar_vd"] as String?,
      yazar: parsedYazarList,
    );
  }

  Map<String, dynamic> toJson() => {
    "ornek_id": ornekId,
    "anlam_id": anlamId,
    "ornek_sira": ornekSira,
    "ornek": ornek,
    "kac": kac,
    "yazar_id": yazarId,
    "yazar_vd": yazarVd,
    "yazar": List<dynamic>.from(yazar.map((x) => x.toJson())),
  };
}

class YazarDto {
  final String? yazarId;
  final String tamAdi;
  final String? kisaAdi;
  final String? ekno;

  const YazarDto({
    this.yazarId,
    required this.tamAdi,
    this.kisaAdi,
    this.ekno,
  });

  factory YazarDto.fromJson(Map<String, dynamic> json) => YazarDto(
    yazarId: json["yazar_id"] as String?,
    tamAdi: json["tam_adi"] as String? ?? '',
    kisaAdi: json["kisa_adi"] as String?,
    ekno: json["ekno"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "yazar_id": yazarId,
    "tam_adi": tamAdi,
    "kisa_adi": kisaAdi,
    "ekno": ekno,
  };
}

class OzellikDto {
  final String? ozellikId;
  final String? tur;
  final String tamAdi;
  final String? kisaAdi;
  final String? ekno;

  const OzellikDto({
    this.ozellikId,
    this.tur,
    required this.tamAdi,
    this.kisaAdi,
    this.ekno,
  });

  factory OzellikDto.fromJson(Map<String, dynamic> json) => OzellikDto(
    ozellikId: json["ozellik_id"] as String?,
    tur: json["tur"] as String?,
    tamAdi: json["tam_adi"] as String? ?? '',
    kisaAdi: json["kisa_adi"] as String?,
    ekno: json["ekno"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "ozellik_id": ozellikId,
    "tur": tur,
    "tam_adi": tamAdi,
    "kisa_adi": kisaAdi,
    "ekno": ekno,
  };
}