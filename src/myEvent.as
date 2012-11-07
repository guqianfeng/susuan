package src
{
    import flash.events.*;

    public class myEvent extends Event
    {
        public var params:Object;
		public static const KEY_DOWN:String = "KEY_DOWN";//事件到
		
        public function myEvent(param1:String, param2:Object = null)
        {
            super(param1);
            this.params = param2;
        }

        override public function toString() : String
        {
            return formatToString("myEvent", "type", "bubbles", "cancelable", "eventPhase", "params");
        }

        override public function clone() : Event
        {
            return new myEvent(this.type, this.params);
        }
	}
}