class ListMerchant {
  ListMerchant({
    this.kodeObat,
    this.namaObat,
    this.qtyAwal,
    this.qtyAkhir,
    this.hargaBeli,
    this.hargaJual,
    this.expired,
    this.kodeMerchant,
    this.namaMerchant,
    this.kodeKecamatan,
    this.namaKecamatan,
    this.kodeKabupaten,
    this.namaKabupaten,
    this.kodePropinsi,    
    this.namaPropinsi,
    this.alamat,   
  });

  String? kodeObat;
  String? namaObat;
  String? qtyAwal;
  String? qtyAkhir;
  String? hargaBeli;
  String? hargaJual;
  String? expired;
  String? kodeMerchant;
  String? namaMerchant;
  String? kodeKecamatan;
  String? namaKecamatan;
  String? kodeKabupaten;
  String? namaKabupaten;
  String? kodePropinsi;    
  String? namaPropinsi;
  String? alamat;
 

  factory ListMerchant.fromJson(Map<String, dynamic> json) => ListMerchant(        
        kodeObat: json["kode_obat"],
        namaObat: json["nama_obat"],
        qtyAwal: json["qty_awal"],
        qtyAkhir: json["qty_akhir"],
        hargaBeli: json["harga_beli"],
        hargaJual: json["harga_jual"],
        expired: json["expired"],
        kodeMerchant: json["kode_merchant"],
        namaMerchant: json["nama_merchant"],
        kodeKecamatan: json["kode_kecamatan"],
        namaKecamatan: json["nama_kecamatan"],
        kodeKabupaten: json["kode_kabupaten"],
        namaKabupaten: json["nama_kabupaten"],
        kodePropinsi: json["kode_propinsi"],
        namaPropinsi: json["nama_propinsi"],            
        alamat: json["alamat"],
       
      );

  Map<String, dynamic> toJson() => {       
        "kode_obat": kodeObat,
        "nama_obat": namaObat,
        "qty_awal": qtyAwal,
        "qtyAkhir": qtyAkhir,
        "harga_beli": hargaBeli,
        "harga_jual": hargaJual,
        "expired": expired,
        "kode_merchant": kodeMerchant,
        "nama_merchant": namaMerchant,
        "kode_kecamatan": kodeKecamatan,
        "nama_kecamatan": namaKecamatan,
        "kode_kabupaten": kodeKabupaten,
        "nama_kabupaten": namaKabupaten,
        "kode_propinsi": kodePropinsi,
        "nama_propinsi": namaPropinsi,
        "Pencatat": alamat,
       
      };
}
