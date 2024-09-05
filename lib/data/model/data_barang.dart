
class DataBarang {
  final String kdDepo;
  final String nama;
  final String? kdObat;
  final String? hargaBeliDasar;
  final String? markupDasar;
  final String? hargaJualDasar;
  final String? qtyAwal;
  final String? qtyAkhir;
  final String? hargaBeliToko;
  final String? hargaJualToko;
  final String? expiredDate;
  final String? asalUsul;
  int jumlah = 0; // Jumlah yang akan dipesan

  DataBarang({
    required this.kdDepo,
    required this.nama,
    this.kdObat,
    this.hargaBeliDasar,
    this.markupDasar,
    this.hargaJualDasar,
    this.qtyAwal,
    this.qtyAkhir,
    this.hargaBeliToko,
    this.hargaJualToko,
    this.expiredDate,
    this.asalUsul,
  });

  factory DataBarang.fromJson(Map<String, dynamic> json) {
    return DataBarang(
      kdDepo: json['KdDepo'],
      nama: json['Nama'],
      kdObat: json['Kd_obat'],
      hargaBeliDasar: json['Harga_Beli_Dasar'],
      markupDasar: json['Markup_Dasar'],
      hargaJualDasar: json['harga_Jual_Dasar'],
      qtyAwal: json['QTY_Awal'],
      qtyAkhir: json['QTY_Akhir'],
      hargaBeliToko: json['Harga_Beli_Toko'],
      hargaJualToko: json['Harga_Jual_Toko'],
      expiredDate: json['ExpiredDate'],
      asalUsul: json['AsalUsul'],
    );
  }
}
