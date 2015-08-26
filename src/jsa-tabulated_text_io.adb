------------------------------------------------------------------------------
--
--  package Tabulated_Text_IO (body)
--
------------------------------------------------------------------------------
--  Update log:
--
--  2000.02.01 (Jacob Sparre Andersen)
--    Written.
--
------------------------------------------------------------------------------

package body JSA.Tabulated_Text_IO is

   ---------------------------------------------------------------------------
   --  procedure Get:

   procedure Get (File  : in     Ada.Text_IO.File_Type;
                  Field :    out Ada.Strings.Unbounded.Unbounded_String) is

      use Ada.Strings.Unbounded;
      use Ada.Text_IO;

      Char : Character;

   begin --  Get
      Field := Null_Unbounded_String;

      loop
         if End_Of_Line (File) then
            exit;
         else
            Get (File => File,
                 Item => Char);

            if Char = Tabulator then
               exit;
            else
               Append (Source   => Field,
                       New_Item => Char);
            end if;
         end if;
      end loop;
   end Get;

   ---------------------------------------------------------------------------
   --  procedure New_Field:

   procedure New_Field (File : in     Ada.Text_IO.File_Type) is

      use Ada.Text_IO;

   begin --  New_Field
      Put (File => File,
           Item => Tabulator);
   end New_Field;

   ---------------------------------------------------------------------------
   --  procedure New_Record:

   procedure New_Record (File : in     Ada.Text_IO.File_Type) is

      use Ada.Text_IO;

   begin --  New_Record
      New_Line (File => File);
   end New_Record;

   ---------------------------------------------------------------------------
   --  procedure Put:

   procedure Put (File  : in     Ada.Text_IO.File_Type;
                  Field : in     Ada.Strings.Unbounded.Unbounded_String) is

      use Ada.Strings.Unbounded;
      use Ada.Text_IO;

   begin --  Put
      if Col (File => File) > 1 then
         Put (Tabulator);
      end if;

      for Index in 1 .. Length (Field) loop
         if Element (Field, Index) = Tabulator then
            Put (File => File,
                 Item => ' ');
         else
            Put (File => File,
                 Item => Element (Field, Index));
         end if;
      end loop;

      if Col (File => File) = 1 then
         Put (File => File,
              Item => ' ');
      end if;
   end Put;

   ---------------------------------------------------------------------------
   --  procedure Skip_Field:

   procedure Skip_Field (File : in     Ada.Text_IO.File_Type) is

      use Ada.Text_IO;

      Char : Character;

   begin --  Skip_Field
      loop
         if End_Of_Line (File => File) then
            exit;
         else
            Get (File => File,
                 Item => Char);
            exit when Char = Tabulator;
         end if;
      end loop;
   end Skip_Field;

   ---------------------------------------------------------------------------
   --  procedure Skip_Record:

   procedure Skip_Record (File : in     Ada.Text_IO.File_Type) is

      use Ada.Text_IO;

   begin --  Skip_Record
      Skip_Line (File => File);
   end Skip_Record;

   ---------------------------------------------------------------------------

end JSA.Tabulated_Text_IO;
