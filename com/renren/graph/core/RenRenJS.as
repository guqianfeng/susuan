package com.renren.graph.core
{
	import flash.external.ExternalInterface;
	
	public class RenRenJS
	{
		public static const NS:String = "RenRenJSBridge";
		
		public function RenRenJS() {
			try {
				if( ExternalInterface.available ) {
					ExternalInterface.call( script_js );					
					ExternalInterface.call( "RenRenJSBridge.setSWFObjectID", ExternalInterface.objectID );
					ExternalInterface.call( "RenRenJSBridge.init" );
				}
			} catch( error:Error ) {}
		}
		
		public function isReady():Boolean {
			if( ExternalInterface.available ) {
				return ExternalInterface.call( "RenRenJSBridge.isReady");
			}
			return false;
		}
		
		private const script_js:XML =
			<script>
				<![CDATA[
					function() {
			
						RenRenJSBridge = {
							isReady: function() {
			　					if (typeof Renren == "undefined") {
									return false;
			　　				}
								return true;
							},
			
							swfObjectID: null,
			
							setSWFObjectID: function(swfObjectID) {																
								RenRenJSBridge.swfObjectID = swfObjectID;
							},
			
							getSwf: function() {								
								return document.getElementById( RenRenJSBridge.swfObjectID );								
							},
							
							init: function() {
								Renren.init();
							},
							
							ui: function(params, widgetId) {
								cb = function(response) { RenRenJSBridge.getSwf().handleUI(response, widgetId); };
								Renren.ui(params, cb);
							}
						};
					}
				]]>
			</script>;
	}
}