program OMyGod;

{$mode objfpc} //ООП

uses SySUtils;

//Класс TCustomPerson
type
	TCustomPerson = class //Класс с data
	type
		TmpTCustomPerson = array of TCustomPerson;//Шаблон для массива
	strict private
		LastName:string;
		FirstName:string;
		MiddleName:string;
		Gender:string[2];
		BirthDate:string;
		ID:integer;
		Child:TmpTCustomPerson;
	private
		function MassivChild:integer;//Получаем 
		
	public
		function FLastName:string; 
		procedure SetFLastName(ChangeName:string);
		function FFirstName:string;
		procedure SetFFirstName(ChangeName:string);
		function FMiddleName:string;
		procedure SetMiddleName(ChangeName:string);
		function FGender:string;
		procedure SetFGender(ChangeName:string);
		function FBirthDate:string;
		procedure SetFBirthDate(ChangeName:string);
		function FID:integer;
		procedure SetFID(ChangeID:integer);//не уверен что это нужно для идентификатора
		
		function FindIndexChild(Index:integer):TCustomPerson;
		function FindIdChild(IDChild:integer):TCustomPerson;
		procedure AddChild(AdChild:TCustomPerson);
	end;
	
function TCustomPerson.FLastName:string;
begin
	Result:= LastName;
end;
procedure TCustomPerson.SetFLastName(ChangeName:string);
begin
	LastName:= ChangeName;
end;
function TCustomPerson.FFirstName:string;
begin
	Result:= FirstName;
end;
procedure TCustomPerson.SetFFirstName(ChangeName:string);
begin
	FirstName:= ChangeName;
end;
function TCustomPerson.FMiddleName:string;
begin
	Result:= MiddleName;
end;
procedure TCustomPerson.SetMiddleName(ChangeName:string);
begin
	MiddleName:= ChangeName;
end;
function TCustomPerson.FGender:string;
begin
	Result:=Gender;
end;
procedure TCustomPerson.SetFGender(ChangeName:string);
begin
	Gender:=ChangeName;
end;
function TCustomPerson.FBirthDate:string;
begin
	Result:=BirthDate;
end;
procedure TCustomPerson.SetFBirthDate(ChangeName:string);
begin
	BirthDate:=ChangeName;
end;
function TCustomPerson.FID:integer;
begin
	Result:=ID;
end;
procedure TCustomPerson.SetFID(ChangeID:integer);
begin
	ID:=ChangeID;
end;

function TCustomPerson.MassivChild:integer;
var Tmp:integer;
begin 
	Tmp:= High(Child);
	Result:=Tmp;
end;

function TCustomPerson.FindIndexChild(Index:integer):TCustomPerson;

begin
	if (High(Child) >= Index) and (Index >= 0) then
	begin
		Result:= Child[Index];
		Exit;
	end;
	
	Result:= nil; //Result возращает оригинал(ссылку), а не копию
end;

function TCustomPerson.FindIdChild(IDChild:integer):TCustomPerson;
var i:integer;
begin
	i:= 0;
	for i:=0 to High(Child) do
	begin
		if Child[i].ID = IDChild then
		begin
			Writeln(Child[i].FLastName);
			Result:= Child[i];
			break;
		end;
		Result:= nil;
	end;

end;

procedure TCustomPerson.AddChild(AdChild:TCustomPerson);
	
begin
	SetLength(Child, Length(Child)+1);
	Child[High(Child)]:= AdChild;
	
end;

//Класс TPerson(TCustomPerson)
type
	TPerson = class(TCustomPerson) //текущий обьект разделение задач
		private
		TempChildsID:array of integer; //У каждого персоны будет свои массив детей если есть для связывания
		public
		procedure ReadTxtData(var F:TextFile);
		procedure WriteTxtData(var F:TextFile);
		function ReadFromConsole(TmpGetC:integer):Boolean;
		procedure WriteToConsole;
		
		
		
	end;
	
procedure TPerson.ReadTxtData(var F:TextFile);
var TmpStr:string;
	N:integer;
	
	//TmpTCustomPerson:TCustomPerson;
 begin
		TmpStr:='';
		N:= 0;
		
		Readln(F,TmpStr);//фамилия
		SetFLastName(TmpStr);
		Writeln(TmpStr);
		
		Readln(F, TmpStr);//имя
		SetFFirstName(TmpStr);
		Writeln(TmpStr);
	
		Readln(F, TmpStr);//отчество
		SetMiddleName(TmpStr);
		Writeln(TmpStr);
	
		Readln(F, TmpStr);//пол
		SetFGender(TmpStr);
		Writeln(TmpStr);
	
		Readln(F, TmpStr);//дата 
		SetFBirthDate(TmpStr);
		Writeln(TmpStr);
		
		Readln(F, TmpStr);//ID
		SetFID(StrToInt(TmpStr));
		Writeln(TmpStr);
		
		Readln(F, TmpStr);//Child(s) человека
		while TryStrToInt(TmpStr,N) do
		begin
			Writeln(TmpStr);
			SetLength(TempChildsID,Length(TempChildsID)+1);
			TempChildsID[High(TempChildsID)] := N;
			//AddChild();
			Readln(F, TmpStr);
		end;
			
		Writeln('');
	
 end;

	
	procedure TPerson.WriteTxtData(var F:TextFile); 
	var i:integer;
		//tmpInt:integer;
	begin
		i:=0;
		//Assign(F,'D:\Pascal(DB)\people.txt');
		//Rewrite(F); //Открыть для записи (создаёт/очищает)
		
		Writeln(F, FLastName); //Запись в файл
		Writeln(F, FFirstName);
		Writeln(F, FMiddleName);
		Writeln(F, FGender);
		Writeln(F, FBirthDate);
		Writeln(F, FID);
		//Writeln(F, '---детки---');
		
		for i:=0 to MassivChild do
		begin		
			Writeln(F,FindIndexChild(i).FID);
			//Writeln(FindIndexChild(i).FID);
			//Writeln(F,FindIndexChild(i).FLastName);
			//Writeln(F,FindIndexChild(i).FFirstName);
			//Writeln(F,FindIndexChild(i).FMiddleName);
			//Writeln(F,FindIndexChild(i).FGender);
			//Writeln(F,FindIndexChild(i).FBirthDate);
		end;
		Writeln(F,'');
		//CloseFile(F);
	end;
	
	function TPerson.ReadFromConsole(TmpGetC:integer):Boolean;
	var TmpStr:string;
		NeverCh:integer;
		TmpId:integer;
		N:integer;
	begin
		N:=0;
		NeverCh:=1;
		TmpStr:='';
		Readln(TmpStr);
		if TmpStr = '' then
		begin
			//Writeln('Ввод окончен, так точно!');
			//Result:=false;
			Exit(false);
		end;
		SetFLastName(TmpStr);
		Readln(TmpStr);
		SetFFirstName(TmpStr);
		Readln(TmpStr);
		SetMiddleName(TmpStr);
		Readln(TmpStr);
		SetFGender(TmpStr);
		Readln(TmpStr);
		SetFBirthDate(TmpStr);
		TmpId:=NeverCh+TmpGetC;
		//Writeln(TmpId);
		SetFID(TmpId);
		Readln(TmpStr);
		while TryStrToInt(TmpStr,N) do
		begin
			Writeln(TmpStr);
			SetLength(TempChildsID,Length(TempChildsID)+1);
			TempChildsID[High(TempChildsID)] := N;
			//AddChild();
			Readln(TmpStr);
		end;
			
		Writeln('');
		
		
		
		Result:=true;
	end;
	
	procedure TPerson.WriteToConsole;
		
	begin
	
		Writeln(FID);
		Writeln(FLastName);
		Writeln(FFirstName);
		Writeln(FMiddleName);
		Writeln(FGender);
		Writeln(FBirthDate);
		
	end;
	
//Класс TCustomPersonDB
type 

	TCustomPersonDB = class
	strict private
		DBPerson: array of TPerson;
	private //мои для работы с индексом
		function GetCount:integer;
		function GetCountLength:integer;
		procedure DeleteDBPerson;
	public
		//function ReadDBPersons:TPersonArray;//убрать
		
		procedure AddDBPerson(TmpPerson:TPerson);

		procedure MainDeleteDBPerson(IndexDB:integer);
		function GetIdDBPerson(IDTperson:integer):integer;
		function GetIndexObjDBPerson(P:TPerson):integer;
		function GetObjTPerson(ix:integer):TPerson;
		
	end;
	
	function TCustomPersonDB.GetCount:integer;
	
	begin
		Result:= High(DBPerson);
	end;
	
	function TCustomPersonDB.GetCountLength:integer;
	
	begin
		Result:= Length(DBPerson);
	end;
	
	procedure TCustomPersonDB.AddDBPerson(TmpPerson:TPerson);
	
	begin
		SetLength(DBPerson,Length(DBPerson)+1);
		DBPerson[High(DBPerson)] := TmpPerson;
		//Writeln(DBPerson[High(DBPerson)].FLastName());
	end;
	
	procedure TCustomPersonDB.DeleteDBPerson;//это не основное удаление!(оно используется один раз в InputStandart)
	
	begin
		DBPerson[High(DBPerson)].Free;
		SetLength(DBPerson,Length(DBPerson)-1);
	end;
	
	procedure TCustomPersonDB.MainDeleteDBPerson(IndexDB:integer);
	var i:integer;
	begin
		DBPerson[IndexDB].Free;
		for i:=IndexDB to High(DBPerson) do
		begin
			//Writeln(DBPerson[i].FLastName);
			if i+1 > High(DBPerson) then
				break;
			
			DBPerson[i]:= DBPerson[i+1];
		end;
		SetLength(DBPerson, Length(DBPerson)-1);
	end;
	
	function TCustomPersonDB.GetIdDBPerson(IDTperson:integer):integer;
	var i:integer;
	begin
		i:=0;
		for i:=0 to High(DBPerson) do
		begin
			if DBPerson[i].FID = IDTperson then
			begin
				Result:=i;
				break;
			end;
			Result:=-1;//-1 значит нету такого
		end;
	end;
	
	function TCustomPersonDB.GetIndexObjDBPerson(P:TPerson):integer;
	var i:integer;
	begin
		i:=0;
		for i:= 0 to High(DBPerson) do
		begin
			if DBPerson[i] = P then
			begin
				Result:= i;
				//Writeln(DBPerson[i].FLastName);
				Exit;//	Выход из функции
			end;
		end;
	end;
	
	function TCustomPersonDB.GetObjTPerson(ix:integer):TPerson;
	begin
		if ix < 0 then
			Exit(nil);
			
		if High(DBPerson) >= ix then
		begin
			Result:= DBPerson[ix];
		end;
	
	end;

//класс TPersonDB(TCustomPersonDB)
type
	TPersonDB = class(TCustomPersonDB)                              ///////////////////
	
	public
		procedure WriteDBPerson(var F:TextFile);
		procedure ReadDBPerson(var F:TextFile);
		procedure InputStandart();
		procedure OutStandart();
		
	end;
	
	procedure TPersonDB.WriteDBPerson(var F:TextFile); //Выводит 
	var Tmp:TPerson;
		i:integer;
	begin
		i:=0;
		
		for i:= 0 to GetCount do
		begin
			Tmp:=GetObjTPerson(i);
			Tmp.WriteTxtData(F); //вместе с id детьми
		end;
		CloseFile(F);
	end;
	
	procedure TPersonDB.ReadDBPerson(var F:TextFile); //Выводит
	var TP:TPerson;
		i,j,x:integer;
		TmpTp:TPerson;
		TmpTpTwo:Tperson;
	begin
	i:=0;
	j:=0;
	x:=0;
		Reset(F);
		while not EOF(F) do
		begin
			TP := TPerson.Create;
			TP.ReadTxtData(F);
			AddDBPerson(TP); //выделяет память и передаёт класс
			
		end;
		CloseFile(F);
		
		for i:=0 to GetCount do
		begin
			TmpTp := GetObjTPerson(i);
			for j:= 0 to High(TmpTp.TempChildsID) do
			begin
				for x:= 0 to GetCount do
				begin
					TmpTpTwo:= GetObjTPerson(x);
					
					if TmpTpTwo.FID = TmpTp.TempChildsID[j] then
					begin
						TmpTp.AddChild(TmpTpTwo);
						break;
					end;
				end;
			end;
		end;
		//AddChild();
	end;
	
	procedure TPersonDB.InputStandart; //
		var Tmp:TPerson;
			TmpBol:Boolean;
			i,j,x:integer;
			TmpTp:TPerson;
			TmpTpTwo:TPerson;
	begin
		TmpBol:= false;
		repeat
			Tmp:=TPerson.Create;
			TmpBol := Tmp.ReadFromConsole(GetCountLength);
			AddDBPerson(Tmp);
			
		for i:=0 to GetCount do
		begin
			TmpTp := GetObjTPerson(i);
			for j:= 0 to High(TmpTp.TempChildsID) do
			begin
				for x:= 0 to GetCount do
				begin
					TmpTpTwo:= GetObjTPerson(x);
					
					if TmpTpTwo.FID = TmpTp.TempChildsID[j] then
					begin
						TmpTp.AddChild(TmpTpTwo);
						break;
					end;
				end;
			end;
		end;
			Writeln(TmpBol);
		until TmpBol = False;//цикл робит до тех пор пока не равен fale
		DeleteDBPerson; //надо удалять так как unil repeat создаёт один лишний
	end;
	
	procedure TPersonDB.OutStandart;
		var Tmp:TPerson;
		i:integer;
	begin
		i:= 0;
		for i:=0 to GetCount do
		begin
			Tmp:= GetObjTPerson(i);
			Tmp.WriteToConsole;
			
		end;
	end;
//класс TPersonDBWorker
type
	TPersonDBWorker = class
	strict private
		DB:TPersonDB;
	public
		constructor Create(NewDB: TPersonDB);
		procedure FindFemale(Date:string);
		procedure FindParents(IDchild:Integer);
		procedure FindGrandFathers;
		procedure FindSirota;
	end;
	
	constructor TPersonDBWorker.Create(NewDB: TPersonDB);
	begin
		DB:= NewDB;
	end;
	
	procedure TPersonDBWorker.FindFemale(Date:string);
	var i:integer;
		TmpP:TPerson;
		s:string[2];
	begin
		i:=0;
		s:= 'Ж';
		for i:=0 to DB.GetCount do //DB.GetCount индекс с 0
		begin
			TmpP := DB.GetObjTPerson(i);
			if (TmpP.FGender = s) and (TmpP.FBirthDate = Date) then 
			begin
				Writeln(TmpP.FBirthDate);
				Writeln(TmpP.FID);
				Writeln(TmpP.FLastName);
				Writeln(TmpP.FFirstName);
				Writeln(TmpP.FMiddleName);
				Writeln(TmpP.FGender);
			end;
		end;
	end;
	
	procedure TPersonDBWorker.FindParents(IDchild:Integer);
	var i:integer;
		j:integer;
		x:integer;
	begin
		i:=0;
		j:=0;
		x:=0;
		for i:=0 to DB.GetCount do
		begin
			if DB.GetObjTPerson(i).FID = IDchild then
			begin
				Writeln(DB.GetObjTPerson(i).FID);//DB.GetObjTPerson(i)-это сам класс детища
				for j:= 0 to DB.GetCount do
				begin
					for x:= 0 to DB.GetObjTPerson(j).MassivChild do 
					begin
						if DB.GetObjTPerson(i) = DB.GetObjTPerson(j).FindIndexChild(x) then
						begin
							Writeln(DB.GetObjTPerson(j).FLastName);
							Writeln(DB.GetObjTPerson(j).FFirstName);
							Writeln(DB.GetObjTPerson(j).FMiddleName);
							Writeln(DB.GetObjTPerson(j).FGender);
							Writeln(DB.GetObjTPerson(j).FID);
							Writeln(DB.GetObjTPerson(j).FBirthDate);
						end;
					end;
				end;
			end;
		end;
		
	end;
	
	procedure TPersonDBWorker.FindGrandFathers;
		var i,j,y:integer;
		s2:string[2];
	begin
		s2:='М';
		for i:=0 to DB.GetCount do
		begin
			if DB.GetObjTPerson(i).FGender = s2 then
			begin
				for j:=0 to DB.GetObjTPerson(i).MassivChild do
				begin
					for y:=0 to DB.GetObjTPerson(i).FindIndexChild(j).MassivChild do //
					begin
						Writeln(DB.GetObjTPerson(i).FLastName);
						Writeln(DB.GetObjTPerson(i).FFirstName);
						Writeln(DB.GetObjTPerson(i).FMiddleName);
						Writeln(DB.GetObjTPerson(i).FGender);
						Writeln(DB.GetObjTPerson(i).FBirthDate);
						Writeln(DB.GetObjTPerson(i).FID);
						break;
						//if DB.GetObjTPerson(i).MassivChild[j].MassivChild[y]
					end;
					break;
				end;
			end;
		end;
	end;
	
	procedure TPersonDBWorker.FindSirota;
		var TmpMassive:array of TCustomPerson; //Массив детей если класс в массиве детей значит не сирота
		i,j,y,r:integer;//TPerson? 
		CountL:integer;
		IndexTmp:integer;
		Sirot:Boolean;
	begin
		CountL:=0;
		IndexTmp:=0;
		for i:=0 to DB.GetCount do
		begin
			for j:=0 to DB.GetObjTPerson(i).MassivChild do
			begin
				SetLength(TmpMassive,1+CountL);
				TmpMassive[IndexTmp]:=DB.GetObjTPerson(i).FindIndexChild(j);
				Inc(IndexTmp);
				Inc(CountL);
			end;
		end;
		
		for y:=0 to DB.GetCount do
		begin
			Sirot:=true;
			for r:=0 to High(TmpMassive) do
			begin
				if DB.GetObjTPerson(y) = TmpMassive[r] then
				begin
					//Writeln(DB.GetObjTPerson(y).FLastName);
					//Writeln(DB.GetObjTPerson(y).FID);
					//Writeln('ne Sirota');
					Sirot:=false;
					break;
				end;
			end;
			if Sirot = true then
			begin
				Writeln(DB.GetObjTPerson(y).FLastName);
				Writeln(DB.GetObjTPerson(y).FFirstName);
				Writeln(DB.GetObjTPerson(y).FMiddleName);
				Writeln(DB.GetObjTPerson(y).FGender);
				Writeln(DB.GetObjTPerson(y).FBirthDate);
				Writeln(DB.GetObjTPerson(y).FID);
			end;
		end;
	end;
//Основа
var	
	
	SQL:TPersonDB;
	//MySQL:TPersonDBWorker;
	//F:TextFile;
	D:TextFile;
	//ff:TPersonArray;
BEGIN
	SQL:=TPersonDB.Create;
	//Assign(F,'D:\Pascal(DB)\DataTest2.txt');
	//SQL.ReadDBPerson(F);
	//SQL.ReadDBPerson;
	
	SQL.InputStandart;
	
	
	Assign(D,'D:\Pascal(DB)\DataTest.txt');
	Rewrite(D);
	SQL.WriteDBPerson(D);
	//SQL.OutStandart;
	//MySQL:=TPersonDBWorker.Create(SQL);
	writeln('FindFemale');
	//MySQL.FindFemale('12.08.2008');
	writeln('-----------');
	writeln('FindParents');
	//MySQL.FindParents(444);
	writeln('-----------');
	writeln('FindGrandFathers');
	//MySQL.FindGrandFathers;
	writeln('-----------');
	writeln('FindSirota');
	//MySQL.FindSirota;
	writeln('-----------');
END.
