------------------------------------------------------------------------------
--
--  package Debugged (spec)
--
--  As below, but not saving debugging messages.
--
--  This package is used to log debugging messages.
--  If the program is executed with command line arguments, then the last
--  argument is used as the name Current_Error is logged to. Otherwise
--  will Current_Error be redirected to Standard_Output.
--
------------------------------------------------------------------------------
--  Update information:
--
--  1996.07.26 (Jacob Sparre Andersen)
--    Copied from Debugging (1996.07.26).
--    Debug set to False.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

package JSA.Debugged is

   Debug : constant Boolean := False;

   ---------------------------------------------------------------------------
   --  Exceptions:

   Not_Implemented_Yet    : exception;
   Can_Not_Be_Implemented : exception;

   This_Can_Never_Happen : exception;

   -----------------------------------------------------------------------
   --  procedure Message:
   --
   --  Writes a message to Current_Error if Debugged is activated.

   procedure Message (Item : in     String);

   pragma Inline (Message);

   -----------------------------------------------------------------------
   --  procedure Message_Line:
   --
   --  Writes a message and a new line to Current_Error if Debugged is
   --  activated.

   procedure Message_Line (Item : in     String);

   pragma Inline (Message_Line);

   -----------------------------------------------------------------------

end JSA.Debugged;
