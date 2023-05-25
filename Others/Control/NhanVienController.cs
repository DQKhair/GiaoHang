using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GiaoHang.Controllers
{
    public class NhanVienController : BaseController
    {
        // GET: NhanVien
        public ActionResult DanhSach()
        {
            Response.Write("OK");
            ViewBag.DanhSachNhanVien =  database.NhanVien_DanhSach().ToList();
            return View();
        }

        public ActionResult Them()
        {

            return View();
        }

        [HttpPost]
        public ActionResult Them(CreateNhanVien info)
        {
            int result = (int)database.NhanVien_Them(info.TenNhanVien, info.NgaySinh, info.Email, info.SoDienThoai, info.AnhDaiDien, info.ChucVu).Single();
            if(result == -1)
            {
                ViewBag.Result = "Lỗi khi thêm nhân viên !";
            }
            else
            {
                ViewBag.Result = $"Thêm thành công nhân viên, mã {result}.";
            }           
            return View();
        }
    }
}