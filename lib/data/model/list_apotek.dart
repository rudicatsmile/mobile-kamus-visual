class ListApotek {
  ListApotek({
    this.idt,
    this.kode,
    this.deskripsi,
    this.cabang,
    this.alamat,
    this.pimpinan,
    this.telpon,
    this.whatsapp,
    this.kdPro,
    this.kdKab,    
    this.kdKec,
    this.noIzin,
    this.noRekening,
    this.tglDaftar,
    this.tglAktif,
    this.omzet,
    this.pencatat,
    this.recorded,
    this.status,
    this.daftarBarang,
  });

  int? idt;
  String? kode;
  String? deskripsi;
  String? cabang;
  String? alamat;
  String? pimpinan;
  String? telpon;
  String? whatsapp;
  String? kdPro;
  String? kdKab;    
  String? kdKec;
  String? noIzin;
  String? noRekening;
  String? tglDaftar;
  String? tglAktif;
  String? omzet; 
  String? pencatat;
  String? recorded;
  String? status;
  String? daftarBarang;


  factory ListApotek.fromJson(Map<String, dynamic> json) => ListApotek(
        idt: json["IDT"] != null
            ? int.parse(json["IDT"].toString())
            : null,
        kode: json["Kode"],
        deskripsi: json["Deskripsi"],
        cabang: json["Cabang"],
        alamat: json["Alamat"],
        pimpinan: json["Pimpinan"],
        telpon: json["Telpon"],
        whatsapp: json["Whatsapp"],
        kdPro: json["KdPro"],
        kdKab: json["KdKab"],
        kdKec: json["KdKec"],
        noIzin: json["NoIzin"],
        noRekening: json["NoRekening"],
        tglDaftar: json["TglDaftar"],
        tglAktif: json["TglAktif"],
        omzet: json["Omzet"],            
        pencatat: json["Pencatat"],
        recorded: json["Recorded"],
        status: json["Status"],
        daftarBarang: json["daftar_barang"],
      );

  Map<String, dynamic> toJson() => {       
        "IDT": idt,        
        "Kode": kode,
        "Deskripsi": deskripsi,
        "Cabang": cabang,
        "Alamat": alamat,
        "Pimpinan": pimpinan,
        "Telpon": telpon,
        "Whatsapp": whatsapp,
        "KdPro": kdPro,
        "KdKab": kdKab,
        "KdKec": kdKec,
        "NoIzin": noIzin,
        "NoRekening": noRekening,
        "TglDaftar": tglDaftar,
        "TglAktif": tglAktif,
        "Omzet": omzet,
        "Pencatat": pencatat,
        "Recorded": recorded,
        "Status": status,
        "daftar_barang": daftarBarang,
      };
}
