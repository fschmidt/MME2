






package
{
import mx.core.IFlexModuleFactory;
import mx.binding.ArrayElementWatcher;
import mx.binding.FunctionReturnWatcher;
import mx.binding.IWatcherSetupUtil2;
import mx.binding.PropertyWatcher;
import mx.binding.RepeaterComponentWatcher;
import mx.binding.RepeaterItemWatcher;
import mx.binding.StaticPropertyWatcher;
import mx.binding.XMLWatcher;
import mx.binding.Watcher;

[ExcludeClass]
public class _application_ConsilioWatcherSetupUtil
    implements mx.binding.IWatcherSetupUtil2
{
    public function _application_ConsilioWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import application.Consilio;
        (application.Consilio).watcherSetupUtil = new _application_ConsilioWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          staticPropertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.UIComponentDescriptor;
        import mx.containers.Panel;
        import mx.core.IFlexModuleFactory;
        import application.ConsilioApp;
        import mx.binding.BindingManager;
        import mx.core.DeferredInstanceFromClass;
        import __AS3__.vec.Vector;
        import mx.core.IDeferredInstance;
        import mx.binding.IBindingClient;
        import mx.core.IPropertyChangeNotifier;
        import flash.events.IEventDispatcher;
        import mx.core.ClassFactory;
        import mx.core.IFactory;
        import flash.display.DisplayObject;
        import mx.core.Container;
        import mx.core.mx_internal;
        import mx.core.DeferredInstanceFromFunction;
        import mx.core.UIComponent;
        import flash.events.EventDispatcher;
        import flash.events.Event;
        import spark.components.Button;

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("maskContainer",
                                                                             {
                propertyChange: true
            }
,
                                                                         // writeWatcherListeners id=0 size=1
        [
        bindings[0]
        ]
,
                                                                 propertyGetter
);


        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





    }
}

}
