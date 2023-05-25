using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Delivery.Models;

namespace Delivery.Controllers
{
    public class DH_DaNhanController : BaseController
    {
        private GiaoHangEntities db = new GiaoHangEntities();

        // GET: hiển thị danh sách đơn hàng đã nhận
        public ActionResult Index()
        {
            //ViewBag.donHang_DaNhan
            var dH_DaNhan = db.DonHang_GetListDonHang(2);
            return View(dH_DaNhan.ToList());
        }

        // GET: chi tiết đơn hàng đã nhận
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang_Find_detail_Result dH = db.DonHang_Find_detail(id).SingleOrDefault();
            if (dH == null)
            {
                return HttpNotFound();
            }
            return View(dH);
        }

        //// : Chi tiết đơn hàng cần phân phối
        public ActionResult PhanPhoi(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang_Find_detail_Result dH_PhanPhoi = db.DonHang_Find_detail(id).SingleOrDefault();
            ViewBag.MaNhanVien = new SelectList(db.DonHang_PhanPhoiSelectList_KhuVuc_NhanVien(dH_PhanPhoi.DiaChiQuan),"MaNhanVien", "TenNhanVien");
            if (dH_PhanPhoi == null)
            {
                return HttpNotFound();
            }
            return View(dH_PhanPhoi);
        }

        //// POST: Xử lý phân phối đơn hàng đã nhận
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PhanPhoi(int id,int MaNhanVien)
        {
            if (ModelState.IsValid)
            {
                var login_Session = (Account_Session_Result)Session[Common.CommonConstants.NGUOI_DUNG];
                db.DonHang_PhanPhoi(id, login_Session.MaNhanVien, MaNhanVien);
            }

            return RedirectToAction("index");
        }
        //list phân phối
        public ActionResult DanhSachPhanPhoiDonHang()
        {
            var ListDonHangPhanPhoi = db.DonHang_GetListDonHang(3);
            return View(ListDonHangPhanPhoi.ToList());
        }
        // chi tiết phân phối
        public ActionResult Details_PhanPhoi(int ? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang_Find_detail_Result dH = db.DonHang_Find_detail(id).SingleOrDefault();
            if (dH == null)
            {
                return HttpNotFound();
            }
            return View(dH);
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
