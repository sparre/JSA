------------------------------------------------------------------------------
--
--  package Tabulated_Text_IO (spec)
--
------------------------------------------------------------------------------
--  Update log:
--
--  2000.02.01 (Jacob Sparre Andersen)
--    Written.
--
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

------------------------------------------------------------------------------

package JSA.Tabulated_Text_IO is

   ---------------------------------------------------------------------------
   --  Tabulator:

   Tabulator : Character := Ada.Characters.Latin_1.HT;

   ---------------------------------------------------------------------------
   --  procedure New_Record:

   procedure New_Record (File : in     Ada.Text_IO.File_Type);

   ---------------------------------------------------------------------------
   --  procedure Skip_Record:

   procedure Skip_Record (File : in     Ada.Text_IO.File_Type);

   ---------------------------------------------------------------------------
   --  procedure New_Field:

   procedure New_Field (File : in     Ada.Text_IO.File_Type);

   ---------------------------------------------------------------------------
   --  procedure Skip_Field:

   procedure Skip_Field (File : in     Ada.Text_IO.File_Type);

   ---------------------------------------------------------------------------
   --  procedure Put:

   procedure Put (File  : in     Ada.Text_IO.File_Type;
                  Field : in     Ada.Strings.Unbounded.Unbounded_String);

   ---------------------------------------------------------------------------
   --  procedure Get:

   procedure Get (File  : in     Ada.Text_IO.File_Type;
                  Field :    out Ada.Strings.Unbounded.Unbounded_String);

   ---------------------------------------------------------------------------

end JSA.Tabulated_Text_IO;
