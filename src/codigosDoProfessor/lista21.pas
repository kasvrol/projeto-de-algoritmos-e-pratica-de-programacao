Program lista21 ;
{21)	FUP que informe se um número lido é primo ou não. }
var num,metade,c:integer;
    chav:boolean;
//provar que o numero NAO EH PRIMO 
Begin
 chav:=true;//apostando que o numero lido eh primo
 write('digite o numero=>');
 readln(num);
//tento provar que não é (se for divisivel por alguem entre 2 e a metade do num)
 metade:=num div 2;
 c:=1;
 repeat
  c:=c+1;
	if(num mod c)=0 then
	 chav:=false;
 until (c=metade) or (not chav);
 if(chav) or (num=2) then
  writeln(num:20,' priiiiiiiiiimmmmmmoooo')
 else
  writeln(num:20,' nao eh primo');
 write('enter para encerrar');
 readln;	 
End.