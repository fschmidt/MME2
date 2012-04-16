

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.core.Container;

class BindableProperty
{
	/*
	 * generated bindable wrapper for property maskContainer (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'maskContainer' moved to '_730108171maskContainer'
	 */

    [Bindable(event="propertyChange")]
    public function get maskContainer():mx.core.Container
    {
        return this._730108171maskContainer;
    }

    public function set maskContainer(value:mx.core.Container):void
    {
    	var oldValue:Object = this._730108171maskContainer;
        if (oldValue !== value)
        {
            this._730108171maskContainer = value;
           if (this.hasEventListener("propertyChange"))
               this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maskContainer", oldValue, value));
        }
    }



}
