
﻿using System.ComponentModel.DataAnnotations;

namespace App.Model
{
    public class ProJoinCat
    {
        [Key]
        public string AccID { get; set; }
        public string ProName { get; set; }
        public string Des { get; set; }

        [Display(Name ="Name Of Category")]
       public string CateName { get; set; }

    }
}



