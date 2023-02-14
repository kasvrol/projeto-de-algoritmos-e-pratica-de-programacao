Program lista23 ;
{23)	FUP que leia dia, mês e ano e informe se a data lida é válida ou não.
o ano tem que ser maior que 1920 e menor que 2010}
var dd,mm,aa,dmax:integer;
    chav:boolean; 
Begin
 write(' digite o dia=>');
 readln(dd);
 write(' digite o mes=>');
 readln(mm);
 write(' digite o ano=>');
 readln(aa);
 chav:=true;//considero a data lida válida
//tento provar que a data lida nao eh valida
//ano
 if(aa<1921) or (aa>2009)then
  chav:=false //ano invalido, data invalida
  else
//mes
  if(mm<1) or (mm>12) then
   chav:=false //ano valido, mes invalido, data invalida
//dia
  else
	 begin
//determino dias maximos do mes lido
    dmax:=31;
		if(mm=4) or (mm=6) or (mm=9) or (mm=11)then
		 dmax:=30;
		if(mm=2)then
     begin
      dmax:=28;
      if(aa mod 4) = 0 then //ano bissesto
       dmax:=29;
     end;
    if(dd<1) or (dd>dmax)then
     chav:=false; //ano valido, mes valido, dia invalido, data invalida
   end;
//verifico o conteudo de chav para saber se a data é valida ou nao
   if chav then
    writeln('data valida')
   else
    writeln('data iiiinnnvalida');
  write('enter para encerrar');
  readln;    
End.