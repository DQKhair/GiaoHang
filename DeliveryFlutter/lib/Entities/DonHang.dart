class DonHang {
  final int maDonHang;
  final String? tu;
  final String? nguoiGui;
  final String? sdtNguoiGui;
  final String nguoiNhan;
  final String diaChiNguoiNhan;
  final String diaChiPhuong;
  final String diaChiQuan;
  final String diaChiThanhPho;
  final String sdtNguoiNhan;
  final String? ghiChu;
  int? maTrangThai;
  String? tenTrangThai;

  DonHang({
    required this.maDonHang,
    this.tu,
    this.nguoiGui,
    this.sdtNguoiGui,
    required this.nguoiNhan,
    required this.diaChiNguoiNhan,
    required this.diaChiPhuong,
    required this.diaChiQuan,
    required this.diaChiThanhPho,
    required this.sdtNguoiNhan,
    this.ghiChu,
    this.maTrangThai,
    this.tenTrangThai,
  });

  factory DonHang.fromJson(Map<String, dynamic> json) {
    return DonHang(
        maDonHang: json["MaDonHang"],
        tu: json["Tu"],
        nguoiGui: json["NguoiGui"],
        sdtNguoiGui: json["SdtNguoiGui"],
        nguoiNhan: json["NguoiNhan"],
        diaChiNguoiNhan: json["DiaChiNguoiNhan"],
        diaChiPhuong: json["DiaChiPhuong"],
        diaChiQuan: json["DiaChiQuan"],
        diaChiThanhPho: json["DiaChiThanhPho"],
        sdtNguoiNhan: json["Sdt"],
        ghiChu: json["GhiChu"],
        maTrangThai : json["TrangThai"],
        tenTrangThai: json["TenTrangThai"]);
  }
}
