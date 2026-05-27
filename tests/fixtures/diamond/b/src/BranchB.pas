unit BranchB;

{$mode delphi}{$H+}

interface

function BranchBMessage: string;

implementation

function BranchBMessage: string;
begin
  Result := 'branch b says hello';
end;

end.
