with
  JSA.Tests.Intermediate_Backups;

package body JSA.Tests is
   function Suite return Ahven.Framework.Test_Suite is
      use Ahven.Framework;
      Intermediate_Backup_Test : JSA.Tests.Intermediate_Backups.Test;
   begin
      return Suite : Test_Suite := Create_Suite ("JSA") do
         Add_Static_Test (Suite, Intermediate_Backup_Test);
      end return;
   end Suite;
end JSA.Tests;
