generic
   Fraction : Float;
   --  How large a fraction of the execution time should be allocated
   --  to creating backups.

   with procedure Save_State;
   --  Should save the relevant state.
package JSA.Intermediate_Backups is
   procedure Begin_Loop
     with Pre => not In_Loop;
   --  To be called before entering a loop performing
   --  heavy/long-running calculations.
   --
   --  Sets up timers and counters.

   procedure End_Of_Iteration
     with Pre => In_Loop;
   --  To be called at the end of a loop performing heavy/long-running
   --  calculations.
   --
   --  Will call Save_State if it is considered timely.

   procedure End_Loop
     with Pre => In_Loop;
   --  To be called immediately after the end of a loop performing
   --  heavy/long-running calculations.
   --
   --  Will call Save_State if the last execution of End_Of_Iteration
   --  didn't.

   function In_Loop return Boolean;
end JSA.Intermediate_Backups;
