

class UserSession {
  final int maNhanVien;
  final String? tenNhanVien;
  final DateTime? ngaySinh;
  final String? email;
  final String? soDienThoai;
  final int? chucVu;
  final bool? trangThai;
  final int? khuVucHoatDong;
  final String tenTaiKhoan;

  const UserSession(
      {required this.maNhanVien,
      required this.tenNhanVien,
      this.ngaySinh,
      this.email,
      this.soDienThoai,
      this.chucVu,
      this.trangThai,
      this.khuVucHoatDong,
      required this.tenTaiKhoan});
  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
        maNhanVien: json['MaNhanVien'],
        tenNhanVien: json['TenNhanVien'],
        ngaySinh: DateTime.parse(json['NgaySinh']),
        email: json['Email'],
        soDienThoai: json['SoDienThoai'],
        chucVu: json['ChucVu'],
        trangThai: json['TrangThai'],
        khuVucHoatDong: json['KhuVucHoatDong'],
        tenTaiKhoan: json['TenTaiKhoan']
    );
  }
}
