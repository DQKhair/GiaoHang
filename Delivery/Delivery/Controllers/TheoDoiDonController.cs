using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Net;
using Delivery.Models;

namespace Delivery.Controllers
{
    public class TheoDoiDonController : BaseController
    {
        GiaoHangEntities db = new GiaoHangEntities();
        // GET: TheoDoiDon
        public ActionResult Index(string searchString)
        {
            if (!String.IsNullOrEmpty(searchString))
            {
                searchString = searchString.ToLower();
                var listDHSearch = db.DonHang_TimKiemTheoTenNG(searchString);
                return View(listDHSearch.ToList());
            }

            var listDH = db.DonHang_TimKiemTheoTenNG(null);
            return View(listDH.ToList());
        }
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
    }
}