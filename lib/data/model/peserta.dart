class Peserta {
  Peserta({
    this.idt,
    this.nik,
    this.nokk,
    this.nama,
    this.jenisKelamin,
    this.tempatLahir,
    this.tanggalLahir,
    this.provinsiKtp,
    this.kabupatenKtp,
    this.kecamatanKtp,
    this.kelurahanKtp,
    this.alamatKtp,
    this.rtrwKtp,
    this.alamatDomisili,
    this.kodeRW,
    this.kodeRT,
    this.agama,
    this.stakaw,
    this.pekerjaan,
    this.kewarganegaraan,
    this.memo,
    this.status,
    this.statusPengajuan,
    this.photo,
    this.jenisPmks,
    this.jenisTanggungan,
    this.pencatat,
    this.recorded,
  });

  int? idt;
  String? nik;
  String? nokk;
  String? nama;
  String? jenisKelamin;
  String? tempatLahir;
  String? tanggalLahir;
  String? provinsiKtp;
  String? kabupatenKtp;
  String? kecamatanKtp;
  String? kelurahanKtp;
  String? alamatKtp;
  String? rtrwKtp;
  String? alamatDomisili;
  String? kodeRW;
  String? kodeRT;
  String? agama;
  String? stakaw;
  String? pekerjaan;
  String? kewarganegaraan;
  String? memo;
  String? status;
  String? statusPengajuan;  
  String? photo;
  String? jenisPmks;
  String? jenisTanggungan;
  String? pencatat;
  String? recorded;

  factory Peserta.fromJson(Map<String, dynamic> json) => Peserta(
        idt: json["IDT"] != null
            ? int.parse(json["IDT"].toString())
            : null,
        nik: json["nik"],
        nokk: json["nokk"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        tempatLahir: json["tempatLahir"],
        tanggalLahir: json["tanggalLahir"],
        provinsiKtp: json["provinsiKtp"],
        kabupatenKtp: json["kabupatenKtp"],
        kecamatanKtp: json["kecamatanKtp"],
        kelurahanKtp: json["kelurahanKtp"],
        alamatKtp: json["alamatKtp"],
        rtrwKtp: json["rtrwKtp"],
        alamatDomisili: json["alamatDomisili"],
        kodeRW: json["kodeRW"],
        kodeRT: json["kodeRT"],
        agama: json["agama"],
        stakaw: json["stakaw"],
        pekerjaan: json["pekerjaan"],
        kewarganegaraan: json["kewarganegaraan"],
        memo: json["memo"],
        status: json["status"],
        statusPengajuan: json["status_pengajuan"],
        photo: json["photo"],
        jenisPmks: json["jenisPmks"],
        jenisTanggungan: json["jenisTanggungan"],
        pencatat: json["pencatat"],
        recorded: json["recorded"],
      );

  Map<String, dynamic> toJson() => {       
        "idt": idt,
        "nik": nik,
        "nokk": nokk,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "tempatLahir": tempatLahir,
        "tanggalLahir": tanggalLahir,
        "provinsiKtp": provinsiKtp,
        "kabupatenKtp": kabupatenKtp,
        "kecamatanKtp": kecamatanKtp,
        "kelurahanKtp": kelurahanKtp,
        "alamatKtp": alamatKtp,
        "rtrwKtp": rtrwKtp,
        "alamatDomisili": alamatDomisili,
        "kodeRW": kodeRW,
        "kodeRT": kodeRT,
        "agama": agama,
        "stakaw": stakaw,
        "pekerjaan": pekerjaan,
        "kewarganegaraan": kewarganegaraan,
        "memo": memo,
        "status": status,
        "status_pengajuan": statusPengajuan,
        "photo": photo,
        "jenisPmks": jenisPmks,
        "jenisTanggungan": jenisTanggungan,
        "pencatat": pencatat,
        "recorded": recorded,
      };
}
