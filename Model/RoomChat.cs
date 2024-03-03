using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class RoomChat
    {
        public RoomChat()
        {
            Messages = new HashSet<Message>();
        }

        public string IdRoom { get; set; }
        public string RoomName { get; set; }
        public string IdAcc { get; set; }

        public virtual User IdAccNavigation { get; set; }
        public virtual ICollection<Message> Messages { get; set; }
    }
}
