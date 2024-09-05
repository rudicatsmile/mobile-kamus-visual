class PesertaDtks {
  PesertaDtks({
    this.idt,
    this.tahun,
    this.bulan,
    this.tahap,
    this.batch,
    this.gelombang,
    this.thnblnSumber,
    this.nik,
    this.nokk,
    this.nama,    
    this.alamatDomisili,
    this.kodeRT,
    this.nikSurveyor,
    this.status,
    this.idPenghentian,
    this.survey,
    this.pengesahan,
    this.nomor,
    this.pkh,
    this.bnpt,
    this.pbi,
    this.fis,
    this.pmk,
    this.snd,
    this.alb,
    this.pes,    
    this.pencatat,
    this.recorded,
  });
  

  int? idt;
  String? tahun;
  String? bulan;
  String? tahap;
  String? batch;
  String? gelombang;
  String? thnblnSumber;
  String? nik;
  String? nokk;
  String? nama;
  String? alamatDomisili;
  String? kodeRT;
  String? nikSurveyor;
  String? status;
  String? idPenghentian;
  String? survey;
  String? pengesahan;
  String? nomor;
  String? pkh;
  String? bnpt;
  String? pbi;
  String? fis;
  String? pmk;
  String? snd;
  String? alb;
  String? pes;
  String? pencatat;
  String? recorded;
  

  factory PesertaDtks.fromJson(Map<String, dynamic> json) => PesertaDtks(
        idt: json["IDT"] != null
            ? int.parse(json["IDT"].toString())
            : null,
        tahun: json["tahun"],
        bulan: json["bulan"],
        tahap: json["tahap"],
        batch: json["kode_batch"],
        gelombang: json["gelombang"],
        thnblnSumber: json["thnblnSumber"],
        nik: json["nik"],
        nokk: json["nokk"],
        nama: json["nama"],
        alamatDomisili: json["alamatDomisili"],
        kodeRT: json["kodeRT"],
        nikSurveyor: json["nik_surveyor"],
        status: json["status"],
        idPenghentian: json["idPenghentian"],
        survey: json["survey"],
        pengesahan: json["pengesahan"],
        nomor: json["nomor"],
        pkh: json["PKH"],
        bnpt: json["BPNT"],
        pbi: json["PBI"],
        fis: json["FIS"],
        pmk: json["PMK"],
        snd: json["SND"],
        alb: json["ALB"],
        pes: json["PES"],        
        pencatat: json["pencatat"],
        recorded: json["recorded"],
      );

  Map<String, dynamic> toJson() => {       
        "idt": idt,        
        "tahun": tahun,
        "bulan": bulan,
        "tahap": tahap,
        "kode_batch": batch,
        "gelombang": gelombang,
        "thnblnSumber": thnblnSumber,
        "nik": nik,
        "nokk": nokk,
        "nama": nama,
        "alamatDomisili": alamatDomisili,
        "kodeRT": kodeRT,
        "nik_surveyor": nikSurveyor,
        "status": status,
        "idPenghentian": idPenghentian,
        "survey": survey,
        "pengesahan": pengesahan,
        "nomor": nomor, 
        "PKH": pkh,
        "BPNT": bnpt,
        "PBI": pbi,
        "FIS": fis,
        "PMK": pmk,
        "SND": snd,
        "ALB": alb,
        "PES": pes,       
        "pencatat": pencatat,
        "recorded": recorded,
      };
}
