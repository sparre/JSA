------------------------------------------------------------------------------
--
--  generic package Generic_Table_Text_IO (body)
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

------------------------------------------------------------------------------
--  Other packages:

with JSA.Tabulated_Text_IO;

------------------------------------------------------------------------------

with JSA.Debugged; use JSA.Debugged;

package body JSA.Generic_Table_Text_IO is

   ---------------------------------------------------------------------------
   --  procedure Close:

   procedure Close (File : in out File_Type) is
   begin
      Ada.Text_IO.Close (File.File);
   end Close;

   ---------------------------------------------------------------------------
   --  function End_Of_File:

   function End_Of_File (File : in     File_Type) return Boolean is
   begin
      return Ada.Text_IO.End_Of_File (File.File);
   end End_Of_File;

   ---------------------------------------------------------------------------
   --  function End_Of_File:
   --
   --  Works on Standard_Input:

   function End_Of_File return Boolean is
   begin
      return Ada.Text_IO.End_Of_File (Ada.Text_IO.Standard_Input);
   end End_Of_File;

   ---------------------------------------------------------------------------
   --  procedure Get:

   procedure Get (File : in     File_Type;
                  Item :    out Row) is
      use Ada.Strings.Unbounded;
      use Tabulated_Text_IO;
      Data : Unbounded_String;
   begin
      for Column in 1 .. File.Last_Column loop
         Get (File  => File.File,
              Field => Data);

         Message_Line ("Read """ & To_String (Data) & """ from column " &
                         Column'Img & ".");

         for Field in Fields loop
            if File.Columns (Field) = Column then
               Item (Field) := Value (To_String (Data));
            end if;
         end loop;
      end loop;

      Skip_Record (File => File.File);
   end Get;

   ---------------------------------------------------------------------------
   --  procedure Get:

   procedure Get (Item :    out Row) is
      use Ada.Strings.Unbounded;
      use Tabulated_Text_IO;
      Data : Unbounded_String;
   begin
      if not Initialised_Standard_Input then

         Initialise_Standard_Input :
         declare
            Column : Natural := 0;
            Label  : Unbounded_String;
         begin
            Last_Standard_Input_Column := 0;

            Standard_Input_Columns := (others => 0);
            while not Ada.Text_IO.End_Of_Line (Ada.Text_IO.Standard_Input) loop
               Tabulated_Text_IO.Get (File  => Ada.Text_IO.Standard_Input,
                                      Field => Label);
               Column := Column + 1;

               Message_Line ("Column " & Column'Img & " is labeled """ &
                               To_String (Label) & """.");

               for Field in Fields loop
                  if Label = Labels (Field) and
                     Standard_Input_Columns (Field) = 0
                  then
                     Standard_Input_Columns (Field) := Column;

                     Message_Line ("Will copy column " &
                                     Standard_Input_Columns (Field)'Img &
                                     " to the field " & Field'Img & ".");

                     Last_Standard_Input_Column :=
                       Natural'Max (Last_Standard_Input_Column, Column);

                     Message_Line ("Will read " &
                                     Last_Standard_Input_Column'Img &
                                     " columns from the file.");
                  end if;
               end loop;
            end loop;

            Tabulated_Text_IO.Skip_Record (File => Ada.Text_IO.Standard_Input);

            Initialised_Standard_Input := True;
         end Initialise_Standard_Input;
      end if;

      for Column in 1 .. Last_Standard_Input_Column loop
         Get (File  => Ada.Text_IO.Standard_Input,
              Field => Data);

         Message_Line ("Read """ & To_String (Data) & """ from column " &
                         Column'Img & ".");

         for Field in Fields loop
            if Standard_Input_Columns (Field) = Column then
               Item (Field) := Value (To_String (Data));
            end if;
         end loop;
      end loop;

      Skip_Record (File => Ada.Text_IO.Standard_Input);
   end Get;

   ---------------------------------------------------------------------------
   --  function Is_Open:

   function Is_Open (File : in     File_Type) return Boolean is
   begin
      return Ada.Text_IO.Is_Open (File.File);
   end Is_Open;

   ---------------------------------------------------------------------------
   --  procedure Open:

   procedure Open (File : in out File_Type;
                   Name : in     String;
                   Mode : in     Ada.Text_IO.File_Mode) is
      use Ada.Strings.Unbounded;
      Column : Natural := 0;
      Label  : Unbounded_String;
   begin --  Open
      Ada.Text_IO.Open (File => File.File,
                        Name => Name,
                        Mode => Mode);

      File.Last_Column := 0;

      File.Columns := (others => 0);
      while not Ada.Text_IO.End_Of_Line (File.File) loop
         Tabulated_Text_IO.Get (File  => File.File,
                                Field => Label);
         Column := Column + 1;

         Message_Line ("Column " & Column'Img & " is labeled """ &
                         To_String (Label) & """.");

         for Field in Fields loop
            if Label = Labels (Field) and File.Columns (Field) = 0 then
               File.Columns (Field) := Column;

               Message_Line ("Will copy column " & File.Columns (Field)'Img &
                               " to the field " & Field'Img & ".");

               File.Last_Column := Natural'Max (File.Last_Column, Column);

               Message_Line ("Will read " & File.Last_Column'Img &
                               " columns from the file.");

            end if;
         end loop;
      end loop;

      Tabulated_Text_IO.Skip_Record (File => File.File);
   end Open;

   ---------------------------------------------------------------------------

end JSA.Generic_Table_Text_IO;
