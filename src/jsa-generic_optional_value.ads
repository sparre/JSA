--  Type for objects which _may_ have a value.
--
--  License: ISC

generic
   type Element is private;
package JSA.Generic_Optional_Value is
   type Instance (Set : Boolean := False) is
      record
         case Set is
            when True =>
               Value : Element;
            when False =>
               null;
         end case;
      end record;

   function "+" (Item : in     Element) return Instance;
   function "+" (Item : in     Instance) return Element
     with Pre => Item.Set;

   function "=" (Left  : in     Element;
                 Right : in     Instance) return Boolean;
   function "=" (Left  : in     Instance;
                 Right : in     Element) return Boolean;

   generic
      with function Image (Item : in     Element) return String;
   function Image (Item : in     Instance) return String;

   generic
      with function Value (Item : in     String) return Element;
   function Value (Item : in     String) return Instance;
end JSA.Generic_Optional_Value;
