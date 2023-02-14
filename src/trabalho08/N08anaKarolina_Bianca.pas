Program N08anaKarolina_Bianca;
{Estudantes: Ana Karolina dos Santos e Bianca Dalmaz Paquete}
uses BIBLIONT;
VAR ARQ : FILE OF REGIS;
		REGD:REGIS;
		TOTCAR:ARRAY[1..12] OF INTEGER;
		CARANT,indexLinhas, contador, escolhaDeOrdem, indexOrdena, indexArquivo, indexNotas, indexCandidatos, indexPosicao:INTEGER;
		vet:vetor;
		stringConcat, stringCargoENome: string[38];
		stringCargo: string[2];
		stringNum: string[4];
//--------------------INICIO DA FUN��O DE CABE�ALHO
FUNCTION cabecalhoDeEscolha (escolhaDeOrdem:integer):String[60];
var RESULT:String[60];
Begin
  if(escolhaDeOrdem=1) then
  RESULT:='NUM  	PF '
  else if(escolhaDeOrdem=2) then
  RESULT:='NOME     		       		PF'
  else if(escolhaDeOrdem=3) then
  RESULT:='===C P F===    PF '
  else
  RESULT:='CS	NOME     		       PF';
  cabecalhoDeEscolha:= RESULT;
End;
//--------------------FIM DA FUN��O DE CABE�ALHO
Begin
  //--------------------INICIO DA CHAMADA DE ESCOLHA DO USUARIO
  WRITELN('POR QUAL TIPO DE REGISTRO DESEJA ORDENAR A LISTA?');
  WRITE('1 - INSCRI��O, 2 - ALFAB�TICA, 3 - CPF, 4 - CARGO + ALFAB�TICA => ');
  repeat
    begin
      READLN(escolhaDeOrdem);
      if (escolhaDeOrdem<1) OR (escolhaDeOrdem>4) then
      begin
        WRITELN('POR FAVOR, DIGITE UMA OP��O V�LIDA!');
        WRITE('1 - INSCRI��O, 2 - ALFAB�TICA, 3 - CPF, 4 - CARGO + ALFAB�TICA=> ');
      end;
    end;
  until(escolhaDeOrdem>0) AND (escolhaDeOrdem<5);
  WRITELN;
  //--------------------FIM DA CHAMADA DE ESCOLHA DO USUARIO E INICIO DA LEITURA DO ARQUIVO
  ASSIGN(ARQ,'CAND.IND');
  RESET(ARQ);
  contador:=0;
  indexArquivo:=0;
  Repeat
    BEGIN{1}
      indexArquivo:=contador+1;
      READ(ARQ,REGD);
      VET[indexArquivo].pf:=contador;
      if(escolhaDeOrdem=1) then //--------ESCOLHA DE ORDEM POR NUM
      begin{1.1}
        if(REGD.NUM<10) then
        begin{1.1.1}
          str(REGD.NUM, stringNum);
          stringNum:= Concat('000' + stringNum);
        end{1.1.1}
        else if(REGD.NUM<100) then
        begin{1.1.2}
          str(REGD.NUM, stringNum);
          stringNum:= Concat('00' + stringNum);
        end{1.1.2}
        else if(REGD.NUM<1000) then
        begin{1.1.3}
          str(REGD.NUM, stringNum);
          stringNum:= Concat('0' + stringNum);
        end{1.1.3}
        else
        begin{1.1.4}
          str(REGD.NUM, stringNum);
        end;{1.1.4}
        VET[indexArquivo].CC:=stringNum;
      end{1.1}
      else if(escolhaDeOrdem=2) then //--------ESCOLHA DE ORDEM POR NOME
      begin{1.2}
        VET[indexArquivo].CC:=REGD.NOME;
      end{1.2}
      else if(escolhaDeOrdem=3) then  //--------ESCOLHA DE ORDEM POR CPF
      begin{1.3}
        VET[indexArquivo].CC:=REGD.CPF;
      end{1.3}
      else    //--------ESCOLHA DE ORDEM POR CARGO E ALF�BETICA
      begin{1.4}
        if(REGD.CAR<10) then
        begin{1.4.1}
          str(REGD.CAR, stringCargo);
          stringCargo:= Concat('0' + stringCargo);
        end{1.4.1}
        else
        begin{1.4.2}
          str(REGD.CAR, stringCargo);
        end;{1.4.2}
        stringConcat:= Concat(stringCargo + ' ' + REGD.NOME);
        insert(stringConcat, stringCargoENome, 1);
        VET[indexArquivo].CC:=stringCargoENome;
      end;{1.4}
      contador:=contador+1;
    END;{1}
  Until eof(ARQ);
  //--------------------FIM DA LEITURA DO ARQUIVO E INICIA A ORDENA��O
  WRITELN('ARQUIVO SEM ORDENA��O:');
  WRITELN;
  WRITELN(cabecalhoDeEscolha(escolhaDeOrdem));
  for indexOrdena:= 1 to 20 do//mostra os 20 primeiros do vetor formado
  begin {2}
    writeln(vet[indexOrdena].cc,' ',vet[indexOrdena].pf:5);
  end;{2}
  WRITELN;
  WRITE('APERTE ENTER PARA ORDENAR');
  READLN;
  WRITELN;
  WRITELN('AGUARDE A ORDENA��O...');
  WRITELN;
  ordem(vet,indexArquivo);//ORDENA��O COM A BIBLIONT
  writeln('ORDENA��O REALIZADA A SEGUINTE MANEIRA:');
  writeln;
  WRITELN(cabecalhoDeEscolha(escolhaDeOrdem));
  for indexOrdena:= 1 to 20 do//mostra os 20 primeiros do vetor ORDENADO
  begin {2}
    writeln(vet[indexOrdena].cc,' ',vet[indexOrdena].pf:5); //idem, ordenados
  end;{2}
  WRITELN;
  write('APERTE ENTER PARA LISTAR TODOS CANDIDATOS');
  // READLN;
  //--------------------FIM DA ORDENA��O E INICIA PAGINA��O
  for indexCandidatos:= 1 to indexArquivo do
  begin{3}
    seek(ARQ,vet[indexCandidatos].pf);     //POSICIONA
    READ(ARQ,REGD);
    indexPosicao:=indexPosicao+1;
    IF(REGD.CAR>0)THEN
    TOTCAR[REGD.CAR]:=TOTCAR[REGD.CAR]+1;
    //------------INICIO DA IMPRESS�O DO CABECALHO SE: CONTADOR DE LINHAS = 25
    IF((indexLinhas MOD 25=0) OR (CARANT<>REGD.CAR) AND (escolhaDeOrdem=4)) THEN
    BEGIN{3.1}
      READLN;
      CLRSCR;
      WRITELN;
      write('  ORD  NUM N O M E                             ===C P F=== NASCIMENTO CS  N1');
      WRITELN('  N2  N3  N4  N5  N6   SO   CG  CC CV');
      indexLinhas:=0;
    END;{3.1}
    //------------FIM DA IMPRESS�O DO CABECALHO SE: CONTADOR DE LINHAS = 25
    //------------INICIO DA IMPRESS�O DO CANDIDATO
    WRITE(indexPosicao:5,REGD.NUM:5,' ',REGD.NOME,' ',REGD.CPF,' ',REGD.DATA.DIA,'/',REGD.DATA.MES,'/',REGD.DATA.ANO,REGD.CAR:3);
    FOR indexNotas:=1 TO 6 DO
    begin{3.1.1}
		 WRITE(REGD.NOTAS[indexNotas]:4);
		end;{3.1.1}
    WRITELN(REGD.SOM:5,REGD.CLG:5,REGD.CLC:4,REGD.CCL:3);
    //------------FIM DA IMPRESS�O DO CANDIDATO
    CARANT:=REGD.CAR;
    indexLinhas:=indexLinhas+1;
  end;{3}
  //--------------------FIM DA PAGINA��O
  CLOSE(ARQ);
  //--------------------FIM DA LEITURA DO ARQUIVO
  WRITELN;
  WRITELN('FIM');
  TERMINE;
End.



