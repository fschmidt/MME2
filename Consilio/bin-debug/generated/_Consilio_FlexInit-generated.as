package {
import flash.display.DisplayObject;
import flash.utils.*;
import mx.core.IFlexModuleFactory;
import mx.styles.IStyleManager2;
import mx.events.Request;
import mx.styles.StyleManagerImpl;
import mx.managers.systemClasses.ChildManager;
import mx.core.TextFieldFactory; TextFieldFactory;
import flash.system.*
import spark.accessibility.TextBaseAccImpl;
import mx.accessibility.PanelAccImpl;
import mx.accessibility.ButtonAccImpl;
import mx.accessibility.UIComponentAccProps;
import spark.accessibility.ButtonBaseAccImpl;
import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import mx.managers.SystemManagerGlobals;
import mx.resources.ResourceManager;
import mx.utils.ObjectProxy;
import mx.effects.EffectManager;
import mx.core.mx_internal;
[ResourceBundle("components")]
[ResourceBundle("containers")]
[ResourceBundle("core")]
[ResourceBundle("effects")]
[ResourceBundle("layout")]
[ResourceBundle("skins")]
[ResourceBundle("styles")]

[Mixin]
public class _Consilio_FlexInit
{
   public function _Consilio_FlexInit()
   {
       super();
   }
   public static function init(fbs:IFlexModuleFactory):void
   {
       new ChildManager(fbs);
       var styleManager:IStyleManager2;
       styleManager = new StyleManagerImpl(fbs);
       EffectManager.mx_internal::registerEffectTrigger("addedEffect", "added");
       EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete");
       EffectManager.mx_internal::registerEffectTrigger("focusInEffect", "focusIn");
       EffectManager.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut");
       EffectManager.mx_internal::registerEffectTrigger("hideEffect", "hide");
       EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown");
       EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp");
       EffectManager.mx_internal::registerEffectTrigger("moveEffect", "move");
       EffectManager.mx_internal::registerEffectTrigger("removedEffect", "removed");
       EffectManager.mx_internal::registerEffectTrigger("resizeEffect", "resize");
       EffectManager.mx_internal::registerEffectTrigger("resizeEndEffect", "resizeEnd");
       EffectManager.mx_internal::registerEffectTrigger("resizeStartEffect", "resizeStart");
       EffectManager.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut");
       EffectManager.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver");
       EffectManager.mx_internal::registerEffectTrigger("showEffect", "show");
       // trace("Flex accessibility startup: " + Capabilities.hasAccessibility);
       if (Capabilities.hasAccessibility) {
          spark.accessibility.TextBaseAccImpl.enableAccessibility();
          mx.accessibility.PanelAccImpl.enableAccessibility();
          mx.accessibility.ButtonAccImpl.enableAccessibility();
          mx.accessibility.UIComponentAccProps.enableAccessibility();
          spark.accessibility.ButtonBaseAccImpl.enableAccessibility();
       }
       // mx.utils.ObjectProxy
       try 
       { 
           if (flash.net.getClassByAlias("flex.messaging.io.ObjectProxy") != mx.utils.ObjectProxy) 
           { 
               flash.net.registerClassAlias("flex.messaging.io.ObjectProxy", mx.utils.ObjectProxy); 
               if (fbs != SystemManagerGlobals.topLevelSystemManagers[0]) 
               { 
                   trace(ResourceManager.getInstance().getString( "core", 
                         "remoteClassMemoryLeak",
                         ["mx.utils.ObjectProxy","Consilio","_Consilio_FlexInit"]));
               } 
           } 
       } 
       catch (e:Error) 
       { 
           flash.net.registerClassAlias("flex.messaging.io.ObjectProxy", mx.utils.ObjectProxy); 
           if (fbs != SystemManagerGlobals.topLevelSystemManagers[0]) 
           { 
               trace(ResourceManager.getInstance().getString( "core", 
                     "remoteClassMemoryLeak",
                     ["mx.utils.ObjectProxy","Consilio","_Consilio_FlexInit"]));
           } 
       } 

       var styleNames:Array = ["lineHeight", "unfocusedTextSelectionColor", "kerning", "showErrorSkin", "textRollOverColor", "digitCase", "inactiveTextSelectionColor", "listAutoPadding", "justificationRule", "textDecoration", "showErrorTip", "dominantBaseline", "fontThickness", "trackingRight", "textShadowColor", "blockProgression", "leadingModel", "listStylePosition", "textAlignLast", "textShadowAlpha", "textAlpha", "letterSpacing", "chromeColor", "rollOverColor", "fontSize", "focusedTextSelectionColor", "baselineShift", "paragraphEndIndent", "fontWeight", "breakOpportunity", "leading", "renderingMode", "symbolColor", "fontSharpness", "barColor", "modalTransparencyDuration", "paragraphStartIndent", "justificationStyle", "layoutDirection", "wordSpacing", "listStyleType", "footerColors", "contentBackgroundColor", "paragraphSpaceAfter", "contentBackgroundAlpha", "textRotation", "fontAntiAliasType", "direction", "errorColor", "cffHinting", "locale", "backgroundDisabledColor", "digitWidth", "modalTransparencyColor", "ligatureLevel", "touchDelay", "firstBaselineOffset", "textIndent", "clearFloats", "themeColor", "tabStops", "fontLookup", "modalTransparency", "paragraphSpaceBefore", "textAlign", "headerColors", "fontFamily", "textSelectedColor", "lineThrough", "interactionMode", "whiteSpaceCollapse", "fontGridFitType", "alignmentBaseline", "trackingLeft", "fontStyle", "dropShadowColor", "accentColor", "disabledColor", "modalTransparencyBlur", "downColor", "textJustify", "focusColor", "color", "alternatingItemColors", "typographicCase"];

       for (var i:int = 0; i < styleNames.length; i++)
       {
          styleManager.registerInheritingStyle(styleNames[i]);
       }
   }
}  // FlexInit
}  // package
