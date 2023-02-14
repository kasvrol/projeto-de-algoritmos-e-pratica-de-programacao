Program lista15 ;
{15)	FUP que leia uma série de notas. A leitura termina quando for lida uma nota negativa. 
Antes de encerrar o programa, mostrar o total de notas 
lidas e a média das notas.} 
var nota,soma,c:integer;
    med:real;
Begin
	 repeat// validar - inicio
	  write('digite a 1. nota=>');
	  readln(nota);
	  if(nota>100)then
	   writeln('invalido');
	 until (nota<=100); //validar - fim ]
	 while(nota>=0) do
	  begin
	   c:=c+1;
	   soma:=soma+nota;
	   repeat// validar - inicio
	    write('digite a ',c+1:2,'. nota=>');
	    readln(nota);
	    if(nota>100)then
	     writeln('invalido');
	   until (nota<=100); //validar - fim ]
	  end;
	if(c<>0)then  //sempre que o divisor for uma variavel; garantir que seja diferente de zero
	 begin
	  med:=soma/c;
	  writeln('nota lidas=',c:3,' ---- media=',med:10:3);
	 end
	else
	 writeln('nada foi lido');
	End.