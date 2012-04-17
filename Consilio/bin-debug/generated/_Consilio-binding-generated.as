

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.containers.Panel;

class BindableProperty
{
	/*
	 * generated bindable wrapper for property mainPanel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'mainPanel' moved to '_265437237mainPanel'
	 */

    [Bindable(event="propertyChange")]
    public function get mainPanel():mx.containers.Panel
    {
        return this._265437237mainPanel;
    }

    public function set mainPanel(value:mx.containers.Panel):void
    {
    	var oldValue:Object = this._265437237mainPanel;
        if (oldValue !== value)
        {
            this._265437237mainPanel = value;
           if (this.hasEventListener("propertyChange"))
               this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mainPanel", oldValue, value));
        }
    }



}
