using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class Message
    {
        public string IdMessage { get; set; }
        public string Content { get; set; }
        public DateTime Timestamp { get; set; }
        public string FromIdAcc { get; set; }
        public string ToRoomId { get; set; }

        public virtual RoomChat ToRoom { get; set; }
    }
}
