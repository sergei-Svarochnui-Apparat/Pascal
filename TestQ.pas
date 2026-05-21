program Test;

{$mode objfpc}

uses Encapsul;

var Person:TCustomPerson;

BEGIN
	Writeln('Тестирование модуля Encapsul');
	Writeln();
	
	Person:= TCustomPerson.Create;
	
	Person.SetFLastName('Иванов');
	Person.SetFFirstName('Иван');
	Person.SetFID(1);
	
	Writeln('',Person.FLastName);
	Writeln('',Person.FFirstName);
	Writeln('',Person.FID);
	
	Person.Free;
	
END.

