
/**
 *  Generated by mxmlc 4.0
 *
 *  Package:    
 *  Class:      MyTest
 *  Source:     C:\Users\Frank\Documents\Studium Medieninformatik\FSV\MME2\repro\Consilio\src\MyTest.mxml
 *  Template:   flex2/compiler/mxml/gen/ClassDef.vm
 *  Time:       2012.04.17 11:03:48 CEST
 */

package 
{

import flash.accessibility.*;
import flash.debugger.*;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.printing.*;
import flash.profiler.*;
import flash.system.*;
import flash.text.*;
import flash.ui.*;
import flash.utils.*;
import flash.xml.*;
import mx.binding.*;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IFlexModuleFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.filters.*;
import mx.styles.*;
import spark.components.Application;
import spark.components.BorderContainer;
import spark.components.Image;


[SWF( backgroundColor='0')]
[Frame(extraClass="_MyTest_FlexInit")]

[Frame(factoryClass="_MyTest_mx_managers_SystemManager")]


//  begin class def
public class MyTest
    extends spark.components.Application
{

    //  instance variables

    //  type-import dummies



    //  constructor (Flex display object)
    /**
     * @private
     **/
    public function MyTest()
    {
        super();

        mx_internal::_document = this;




        // layer initializers

       
        // properties
        this.minWidth = 955;
        this.minHeight = 600;
        this.mxmlContentFactory = new mx.core.DeferredInstanceFromFunction(_MyTest_Array1_c);


        // events












    }

    /**
     * @private
     **/ 
    private var __moduleFactoryInitialized:Boolean = false;

    /**
     * @private
     * Override the module factory so we can defer setting style declarations
     * until a module factory is set. Without the correct module factory set
     * the style declaration will end up in the wrong style manager.
     **/ 
    override public function set moduleFactory(factory:IFlexModuleFactory):void
    {
        super.moduleFactory = factory;
        
        if (__moduleFactoryInitialized)
            return;

        __moduleFactoryInitialized = true;


        // our style settings
        //  initialize component styles
        if (!this.styleDeclaration)
        {
            this.styleDeclaration = new CSSStyleDeclaration(null, styleManager);
        }

        this.styleDeclaration.defaultFactory = function():void
        {
            this.backgroundColor = 0;
        };


        // ambient styles
        mx_internal::_MyTest_StylesInit();

                         
    }
 
    //  initialize()
    /**
     * @private
     **/
    override public function initialize():void
    {


        super.initialize();
    }


    //  scripts
    //  end scripts


    //  supporting function definitions for properties, events, styles, effects
private function _MyTest_Array1_c() : Array
{
	var temp : Array = [_MyTest_BorderContainer1_c()];
	return temp;
}

private function _MyTest_BorderContainer1_c() : spark.components.BorderContainer
{
	var temp : spark.components.BorderContainer = new spark.components.BorderContainer();
	temp.left = 56;
	temp.bottom = 213;
	temp.width = 520;
	temp.height = 123;
	temp.mxmlContentFactory = new mx.core.DeferredInstanceFromFunction(_MyTest_Array2_c);
	temp.setStyle("backgroundColor", 9210763);
	temp.setStyle("borderVisible", false);
	temp.setStyle("cornerRadius", 4);
	temp.setStyle("dropShadowVisible", false);
	if (!temp.document) temp.document = this;
	return temp;
}

private function _MyTest_Array2_c() : Array
{
	var temp : Array = [_MyTest_Image1_c()];
	return temp;
}

private function _MyTest_Image1_c() : spark.components.Image
{
	var temp : spark.components.Image = new spark.components.Image();
	temp.left = 20;
	temp.width = 96;
	temp.height = 96;
	temp.verticalCenter = 0;
	if (!temp.document) temp.document = this;
	return temp;
}



    //  initialize style defs for MyTest

    mx_internal var _MyTest_StylesInit_done:Boolean = false;

    mx_internal function _MyTest_StylesInit():void
    {
        //  only add our style defs to the style manager once
        if (mx_internal::_MyTest_StylesInit_done)
            return;
        else
            mx_internal::_MyTest_StylesInit_done = true;
            
        var style:CSSStyleDeclaration;
        var effects:Array;
                    

        var conditions:Array;
        var condition:CSSCondition;
        var selector:CSSSelector;

        styleManager.initProtoChainRoots();
    }


    //  embed carrier vars
    //  end embed carrier vars


//  end class def
}

//  end package def
}