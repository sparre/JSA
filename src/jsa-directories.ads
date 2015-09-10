package JSA.Directories is
   procedure Rename_As_Backup (Name : in String);
   --  Renames Name to Name & "~".
   --
   --  Doesn't do anything, if there isn't a file named Name.
   --  Overwrites Name & "~", if it already exists.
end JSA.Directories;
