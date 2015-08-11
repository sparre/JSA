--  License: ISC

with Ada.Text_IO;

package body JSA.Generic_Optional_Value is

   function "+" (Item : in     Element) return Instance is
   begin
      return (Set   => True,
              Value => Item);
   end "+";

   function "+" (Item : in     Instance) return Element is
   begin
      return Item.Value;
   end "+";

   function "=" (Left  : in     Element;
                 Right : in     Instance) return Boolean is
   begin
      return Right.Set and then Left = Right.Value;
   end "=";

   function "=" (Left  : in     Instance;
                 Right : in     Element) return Boolean is
   begin
      return Left.Set and then Left.Value = Right;
   end "=";

   function Image (Item : in     Instance) return String is
   begin
      case Item.Set is
         when True =>
            return Image (Item.Value);
         when False =>
            return "";
      end case;
   end Image;

   function Value (Item : in     String) return Instance is
   begin
      if Item = "" then
         return (Set   => False);
      else
         return (Set   => True,
                 Value => Value (Item));
      end if;
   exception
      when others =>
         Ada.Text_IO.Put
           (File => Ada.Text_IO.Current_Error,
            Item => "JSA.Generic_Optional_Value.Value (""" & Item & """);");
         raise;
   end Value;
end JSA.Generic_Optional_Value;
