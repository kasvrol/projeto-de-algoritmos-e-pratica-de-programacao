Program lista14 ;
{14)	FUP que leia 10 notas. Antes de encerrar, mostre a média das notas lidas. }
var nota,soma,c:integer;
    med:real;
Begin
 for c:=1 to 10 do
  begin
	 repeat// validar - inicio
	  write('digite a ',c:2,'. nota=>');
	  readln(nota);
	  if(nota<0) or (nota>100)then
	   writeln('invalido');
	 until(nota>=0) and (nota<=100); //validar - fim
	 soma:=soma+nota;
	end;
	med:=soma/10;
	writeln('media=',med:10:3);
	write('enter para encerrar');
	readln; 
End.