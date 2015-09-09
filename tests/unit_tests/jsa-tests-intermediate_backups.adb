with
  Ada.Integer_Text_IO,
  Ada.Text_IO;

with
  JSA.Intermediate_Backups;

package body JSA.Tests.Intermediate_Backups is
   overriding
   procedure Initialize (T : in out Test) is
      use Ahven.Framework;
   begin
      T.Set_Name ("Intermediate backups");

      Add_Test_Routine (T, Run'Access, "Run");
   end Initialize;

   procedure Run is
      Counter : Natural := 0;

      procedure Save_Counter;
      procedure Save_Counter is
      begin
         Ada.Text_IO.Put ("Backup of counter: ");
         Ada.Integer_Text_IO.Put (Counter);
         Ada.Text_IO.New_Line;
      end Save_Counter;

      package Backups is
         new JSA.Intermediate_Backups (Fraction   => 0.01,
                                       Save_State => Save_Counter);
   begin
      Backups.Begin_Loop;
      for I in 1 .. 1_000 loop
         Counter := Counter + 1;

         for J in 1 .. 100_000 loop
            if J mod 2 = 0 then
               Counter := Counter + 1;
            else
               Counter := Counter - 1;
            end if;
         end loop;

         Backups.End_Of_Iteration;
      end loop;
      Backups.End_Loop;
   end Run;
end JSA.Tests.Intermediate_Backups;
