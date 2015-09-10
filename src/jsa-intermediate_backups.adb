with
  Ada.Calendar;

package body JSA.Intermediate_Backups is
   In_A_Loop  : Boolean  := False;
   Save_Time  : Duration;
   Loop_Start : Ada.Calendar.Time;
   Saved      : Boolean;

   procedure Begin_Loop is
   begin
      In_A_Loop  := True;
      Save_Time  := 0.0;
      Saved      := False;
      Loop_Start := Ada.Calendar.Clock;
   end Begin_Loop;

   procedure End_Loop is
   begin
      if not Saved then
         Save_State;

         Saved := True;
      end if;

      In_A_Loop := False;
   end End_Loop;

   procedure End_Of_Iteration is
      use Ada.Calendar;

      Total_Time : constant Float := Float (Clock - Loop_Start);
      Timestamp  : Time;
   begin
      if Fraction * Total_Time > Float (Save_Time) then
         Timestamp := Ada.Calendar.Clock;

         Save_State;

         Save_Time := Save_Time + (Clock - Timestamp);
         Saved     := True;
      else
         Saved     := False;
      end if;
   end End_Of_Iteration;

   function In_Loop return Boolean is
   begin
      return In_A_Loop;
   end In_Loop;
end JSA.Intermediate_Backups;
