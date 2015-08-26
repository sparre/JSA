------------------------------------------------------------------------------
--
--  generic package Generic_Table_Text_IO (spec)
--
--  A package for reading data tables with column headers indicating
--  which data are in which columns.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2003.03.25-26 (Jacob Sparre Andersen)
--    Written.
--
--  2003.06.17 (Jacob Sparre Andersen)
--    Added the option of reading from Standard_Input.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Strings.Unbounded;
with Ada.Text_IO;

------------------------------------------------------------------------------

generic
   type Element is private;

   with function Value (Item : in String) return Element;

   type Fields is (<>);
   type Row is array (Fields) of Element;

   type Label_Array is array (Fields) of
     Ada.Strings.Unbounded.Unbounded_String;

   Labels : Label_Array;
package JSA.Generic_Table_Text_IO is

   ---------------------------------------------------------------------------
   --  type File_Type:

   type File_Type is limited private;

   ---------------------------------------------------------------------------
   --  procedure Open:

   procedure Open (File : in out File_Type;
                   Name : in     String;
                   Mode : in     Ada.Text_IO.File_Mode);

   ---------------------------------------------------------------------------
   --  procedure Close:

   procedure Close (File : in out File_Type);

   ---------------------------------------------------------------------------
   --  function Is_Open:

   function Is_Open (File : in     File_Type) return Boolean;

   ---------------------------------------------------------------------------
   --  function End_Of_File:

   function End_Of_File (File : in     File_Type) return Boolean;

   ---------------------------------------------------------------------------
   --  function End_Of_File:
   --
   --  Works on Standard_Input.

   function End_Of_File return Boolean;

   ---------------------------------------------------------------------------
   --  procedure Get:

   procedure Get (File : in     File_Type;
                  Item :    out Row);

   ---------------------------------------------------------------------------
   --  procedure Get:
   --
   --  Works on Standard_Input.

   procedure Get (Item :    out Row);

   ---------------------------------------------------------------------------

private

   ---------------------------------------------------------------------------
   --  type File_Type:

   type Column_Indices is array (Fields) of Natural;

   type File_Type is limited
      record
         File        : Ada.Text_IO.File_Type;
         Last_Column : Natural := 0;
         Columns     : Column_Indices := (others => 0);
      end record;

   ---------------------------------------------------------------------------
   --  Reading from Standard_Input:

   Initialised_Standard_Input : Boolean := False;
   Last_Standard_Input_Column : Natural := 0;
   Standard_Input_Columns     : Column_Indices := (others => 0);

   ---------------------------------------------------------------------------

end JSA.Generic_Table_Text_IO;
