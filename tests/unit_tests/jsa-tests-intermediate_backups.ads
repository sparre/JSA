with
  Ahven.Framework;

package JSA.Tests.Intermediate_Backups is
   type Test is new Ahven.Framework.Test_Case with null record;

   overriding
   procedure Initialize (T : in out Test);
private
   procedure Run;
end JSA.Tests.Intermediate_Backups;
