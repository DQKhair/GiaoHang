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
    public class DHsController : BaseController
    {
        private GiaoHangEntities db = new GiaoHangEntities();
        // Hiển thị danh sách đơn hàng chưa nhận
        public ActionResult Index()
        {
            var list_DonHang = db.DonHang_GetListDonHang(1);
            return View(list_DonHang.ToList());
        }

        // : Hiển thị chi tiết đơn hàng chưa nhận
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

        // : Hiển thị chi tiết nhận đơn hàng
        public ActionResult NhanDon(int? id)
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

        // : Xử lý chi tiết nhận đơn hàng
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult NhanDon(int id)
        {
            if (ModelState.IsValid)
            {
            var login_Session = (Account_Session_Result)Session[Common.CommonConstants.NGUOI_DUNG];
            db.DonHang_XacNhanDon(id, login_Session.MaNhanVien);
            }
            return RedirectToAction("index");
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
