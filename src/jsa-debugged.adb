------------------------------------------------------------------------------
--
--  package Debugged (body)
--
------------------------------------------------------------------------------
--  Update information:
--
--  1996.07.26 (Jacob Sparre Andersen)
--    Copied from Debugging (1996.07.26).
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Ada.Command_Line;
with Ada.Text_IO;

package body JSA.Debugged is

   ---------------------------------------------------------------------------
   --  procedure Message:
   --
   --  Writes a message to Current_Error if debugging is activated.

   procedure Message (Item : in     String) is

      use Ada.Text_IO;

   begin --  Message
      if Debug then
         Put (Current_Error, Item);
         --  Flush (Current_Error);
      end if;
   end Message;

   ---------------------------------------------------------------------------
   --  procedure Message_Line:
   --
   --  Writes a message and a new line to Current_Error if debugging is
   --  activated.

   procedure Message_Line (Item : in     String) is

      use Ada.Text_IO;

   begin --  Message_Line
      if Debug then
         Put_Line (Current_Error, Item);
         --  Flush (Current_Error);
      end if;
   end Message_Line;

   ---------------------------------------------------------------------------

   use Ada.Command_Line;
   use Ada.Text_IO;

   Error_Log               : File_Type;
   Log_To_Current_Error    : Boolean := True;
   Log_File_Argument_Index : Positive;

begin --  Debugged
   for Index in 1 .. Argument_Count - 1 loop
      if Argument (Index) = "-errorlog" then
         Log_To_Current_Error := False;
         Log_File_Argument_Index := Index + 1;
         exit;
      end if;
   end loop;

   if not Log_To_Current_Error then
      if Argument (Log_File_Argument_Index) = "-" then
         Set_Error (Standard_Output);
      else
         Create (File => Error_Log,
                 Name => Argument (Log_File_Argument_Index));
         Set_Error (Error_Log);
      end if;
   end if;
end JSA.Debugged;
