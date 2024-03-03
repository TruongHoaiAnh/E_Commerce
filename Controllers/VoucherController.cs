using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AspNetCoreHero.ToastNotification.Abstractions;
using App.Model;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using PagedList.Core;

namespace App.Controllers
{

    public class VoucherController : Controller
    {
        private readonly ECommerceContext _context;
        public INotyfService _Inotiyfyservice { get; }

        public VoucherController(ECommerceContext context, INotyfService notyfService)
        {
            _context = context;
            _Inotiyfyservice = notyfService;
        }

        public IActionResult Index(int? page)
        {
            // IEnumerable<Voucher> listVC = _context.Vouchers.ToList();
            // return View(listVC);
            var pageNumber = page == null || page <= 0 ? 1 : page.Value;
            var pageSize = 10;
            var lsVoucher = _context.Vouchers.AsNoTracking()
                .OrderByDescending(x => x.StartDate);
            PagedList<Voucher> models = new PagedList<Voucher>(lsVoucher,pageNumber,pageSize);
            ViewBag.CurrentPage = pageNumber;
            return View(models);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Create(Voucher obj)
        {
            if (ModelState.IsValid)
            {
                //VoucherId tự tăng
                obj.VoucherId = GenerateVoucherId();
                //Mã voucher
                if (obj.PromotionCode == null)
                {
                    obj.PromotionCode = randomVoucherCode(obj.PromotionName);
                }
                //set gia tri mặc định của trạng thái sử dụng là đã kích hoạt
                if (obj.UsageStatus == 0)
                {
                    obj.UsageStatus = 1;
                }
                //set gia tri mặc định của trạng thái xóa là đã chưa xóa
                if (obj.DeleteStatus == null)
                {
                    obj.DeleteStatus = false;
                }
                _context.Add(obj);
                _context.SaveChanges();
                 _Inotiyfyservice.Success("Add Voucher Successfully", 2);
                return RedirectToAction("Index");
            }
            return View();
        }


        // public IActionResult Edit(string id)
        // {
        //     var obj = _context.Vouchers.Find(id);
        //     if (obj == null)
        //         return NotFound();
        //     return View(obj);
        // }

        // [HttpPost]
        // public IActionResult Edit(Voucher obj)
        // {
        //     if (ModelState.IsValid)
        //     {
        //         _context.Vouchers.Update(obj);
        //         _context.SaveChanges();
        //         return RedirectToAction("Index");

        //     }
        //     return View();
        // }

        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var voucher = await _context.Vouchers.FindAsync(id);
            if (voucher == null)
            {
                return NotFound();
            }
            return View(voucher);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("VoucherId,UsageStatus,PromotionName,DiscountType,PromotionCode,DiscountAmount,Quantity,MaxiValue,MinValue,StartDate,EndDate,DeleteStatus")] Voucher voucher)
        {
            if (id != voucher.VoucherId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(voucher);
                    await _context.SaveChangesAsync();
                     _Inotiyfyservice.Success("Update Voucher Successfully", 2);
                    return RedirectToAction(nameof(Index));
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!VoucherExists(voucher.VoucherId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }

            }
            return View(voucher);
        }

        private bool VoucherExists(string id)
        {
            return _context.Vouchers.Any(e => e.VoucherId == id);
        }

        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var voucher = await _context.Vouchers.FirstOrDefaultAsync(m => m.VoucherId == id);
            if (voucher == null)
            {
                return NotFound();
            }

            return View(voucher);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var voucher = await _context.Vouchers.FindAsync(id);
            voucher.DeleteStatus = true;
            await _context.SaveChangesAsync();
             _Inotiyfyservice.Success("Delete Voucher Successfully", 2);
            return RedirectToAction(nameof(Index));
        }


        // Hàm để tạo VoucherId
        private string GenerateVoucherId()
        {
            // Generate a new unique VoucherId
            string id = "VC";
            var lastVoucher = _context.Vouchers.OrderByDescending(v => v.VoucherId).FirstOrDefault();

            if (lastVoucher == null)
            {
                return id + "000001";
            }
            else
            {
                int k = Convert.ToInt32(lastVoucher.VoucherId.Substring(2)) + 1;
                //Nếu giá trị số nguyên có ít hơn 6 chữ số, nó sẽ được đặt thêm các số 0 ở đầu
                return id + k.ToString("D6");
            }
        }


        //Tạo random mã voucher
        private string randomVoucherCode(string promotionName)
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var stringChars = new char[6];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }

            var finalString = promotionName + "_" + new String(stringChars);
            return finalString;
        }







    }
}