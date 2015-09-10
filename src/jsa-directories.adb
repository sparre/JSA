with
  Ada.Directories;

package body JSA.Directories is
   procedure Rename_As_Backup (Name : in String) is
      use Ada.Directories;
      Backup : constant String := Name & "~";
   begin
      if Exists (Name) then
         if Exists (Backup) then
            Delete_File (Backup);
         end if;

         Rename (Old_Name => Name,
                 New_Name => Backup);
      end if;
   end Rename_As_Backup;
end JSA.Directories;
