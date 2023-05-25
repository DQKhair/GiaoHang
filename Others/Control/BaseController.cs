using GiaoHang.Models;
using System.Web.Mvc;


namespace GiaoHang.Controllers
{
    public class BaseController : Controller
    {
       protected GiaoHangEntities database = new GiaoHangEntities();
    }
}