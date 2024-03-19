using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace App.Model
{
	public class ProProItems
	{
		public Product products { get; set; }
		public ProductItem productItems { get; set; }

		public ImgPro imgPros { get; set; }
		public IFormFile imgFiles { get; set; }

	}
}