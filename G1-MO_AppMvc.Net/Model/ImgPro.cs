using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class ImgPro
    {
        public string IdImg { get; set; }
        public string IdPro { get; set; }
        public string LinkImg { get; set; }

        public virtual Product IdProNavigation { get; set; }
    }
}
