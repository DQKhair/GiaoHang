var config = require('./databaseConfig');
const sql = require('mssql');

async function dangnhapshiper(user,pass){
    try {
        console.log('Đang xử lí đăng nhập...')
        console.log('Tài khoản: '+user+'\n Mật khẩu: '+pass)
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('user', sql.VarChar, user)
        .input('pass',sql.VarChar,pass)
        .query("exec TaiKhoan_DangNhap_Shiper @user,@pass");
        var taikhoan = result.recordsets[0][0];
        console.log('Kết quả: '+taikhoan)
        return taikhoan;
    }
    catch (error) {
        console.log(error);
    }
}

async function lay_Danh_Sach_Don_Hang_Can_Giao(id){
    try {
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('id', sql.Int, id)
        .query("exec sp_Shiper_Don_Hang_Can_Giao @id");
        var donhang = result.recordsets[0];
        return donhang;
    }
    catch (error) {
        console.log(error);
    }
}

async function lay_Thong_Tin_Don_Hang(id){
    try {
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('id', sql.Int, id)
        .query("exec sp_Shiper_Thong_Tin_Don_Hang @id");
        var donhang = result.recordsets[0][0];
        return donhang;
    }
    catch (error) {
        console.log(error);
    }
}

async function xac_Nhan_Da_Lay_Don_Hang(id){
    try {
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('id', sql.Int, id)
        .query("exec sp_Xac_Nhan_Da_Lay_Hang @id");
        var donhang = result.recordsets[0][0];
        return donhang;
    }
    catch (error) {
        console.log(error);
    }
}
async function xac_Nhan_Dang_Giao_Hang(id){
    try {
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('id', sql.Int, id)
        .query("exec sp_Xac_Nhan_Dang_Giao_Hang @id");
        var donhang = result.recordsets[0][0];
        return donhang;
    }
    catch (error) {
        console.log(error);
    }
}
async function xac_Nhan_Da_Giao_Hang(id){
    try {
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('id', sql.Int, id)
        .query("exec sp_Xac_Nhan_Da_Giao_Hang @id");
        var donhang = result.recordsets[0][0];
        return donhang;
    }
    catch (error) {
        console.log(error);
    }
}






module.exports = {
    dangnhapshiper:dangnhapshiper,
    lay_Danh_Sach_Don_Hang_Can_Giao:lay_Danh_Sach_Don_Hang_Can_Giao,
    lay_Thong_Tin_Don_Hang:lay_Thong_Tin_Don_Hang,
    xac_Nhan_Da_Lay_Don_Hang:xac_Nhan_Da_Lay_Don_Hang,
    xac_Nhan_Da_Giao_Hang:xac_Nhan_Da_Giao_Hang,
    xac_Nhan_Dang_Giao_Hang:xac_Nhan_Dang_Giao_Hang,
}