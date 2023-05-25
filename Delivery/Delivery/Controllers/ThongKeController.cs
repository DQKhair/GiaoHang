using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Delivery.Models;

namespace Delivery.Controllers
{
    public class ThongKeController : Controller
    {
        GiaoHangEntities db = new GiaoHangEntities();
        // GET: ThongKe
        public ActionResult Index()
        {
            ViewBag.Year = new SelectList(db.ThongKe_LayNam(), "Nam");
            ViewBag.Month = new SelectList(db.ThongKe_LayThang(), "Thang");
            return View();
        }

        public JsonResult GetChart(int year, int month)
        {
            var result = db.ThongKe_DaNhan(year, month).ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}