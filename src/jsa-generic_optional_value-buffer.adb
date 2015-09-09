separate (JSA.Generic_Optional_Value)

protected body Buffer is
   procedure Clear is
   begin
      if Stored.Set then
         Stored := (Set => False);
         Changed := True;
      end if;
   end Clear;

   entry Get (Item :    out Instance) when Changed is
   begin
      Item := Stored;
      Changed := False;
   end Get;

   procedure Set (Item : in     Element) is
   begin
      if Stored.Set and then Stored.Value = Item then
         null;
      else
         Stored := (Set   => True,
                    Value => Item);
         Changed := True;
      end if;
   end Set;
end Buffer;
