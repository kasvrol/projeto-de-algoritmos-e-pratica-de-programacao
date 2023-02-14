PROGRAM N07anakarolina_bianca;
{Estudantes: Ana Karolina dos Santos GRR:20223404
Bianca Dalmaz Paquete GRR:20223395 }

USES BIBLIONT;
var gabarito:string[60];
		resposta:array[1..1500] of string[28];
		notaMenorQueDez:string[1];
		notaMenorQueCem:string[2];
		notaCem:string[3];
		concatenaNota:string[4];
		resultStringMAIOR:string[3];
		resultString:string[2];
		resultAA:string[4];
		resultStringMenor:string[1];
		resultado:array[1..6] of integer;
		arquivoDeProvas, arquivoDeNotas:TEXT;
		registro:STRING[28];
		respostaDoGabarito, respostaDoCandidato:STRING[1];
		REGD:REGIS;
		index,indexResult, indexLeNotas, indexGabarito, matricula, indexArrayString, indexString:INTEGER;
		erro:boolean;
		registroDeProvas:STRING[64];
type StringArray = array[1..6] of integer;



//-------
FUNCTION validaGabarito (gabaritoDoCandidato, GABARITO:String):StringArray;
var RESULT, disciplina:array[1..6] of integer;
indexDisciplina:integer;
Begin
  //----- zerar array de disciplinas
  FOR indexDisciplina:=1 TO 6 DO
	  BEGIN
	    disciplina[indexDisciplina]:=0;
	  END;
  //-------- ler gabarito de disciplinas  e atribuir notas
  FOR index:=1 TO 60 DO
	  BEGIN
	    respostaDoGabarito:=COPY(GABARITO,index,1); //RETIRA DO GABARITO OFICIAL AS RESPOSTAS INDIVIDUALMENTE
	    respostaDoCandidato:=COPY(gabaritoDoCandidato,index,1); //RETIRA DO GABARITO DO CANDIDATO AS RESPOSTAS INDIVIDUALMENTE
	    //--CHECA SE AS RESPOSTAS SÃO IGUAIS E ATRIBUI NOTA
	    if(respostaDoGabarito=respostaDoCandidato) then
		    BEGIN
		      if((5<index) AND (index<26)) then
			      BEGIN
			        if((5<index) AND (index<16)) then
			        disciplina[2]:=disciplina[2]+10
			        else
			        disciplina[3]:=disciplina[3]+10
			      END
		      else if((25<index) AND (index<46)) then
		      disciplina[4]:=disciplina[4]+5
		      else if((45<index) AND (index<56)) then
		      disciplina[5]:=disciplina[5]+10
		      else
			      BEGIN
			        if((0<index) AND (index<6)) then
			        disciplina[1]:=disciplina[1]+20
			        else
			        disciplina[6]:=disciplina[6]+20
			      END
		    END;
	  END;
  FOR indexResult:=1 TO 6 DO
	  BEGIN
	    RESULT[indexResult]:= disciplina[indexResult]
	  END;
  validaGabarito:= RESULT;
End;

//--------- PEGA GABARITO OFICIAL (INICIO)
BEGIN
  repeat//valida o gabarito
    writeln('                    123451234567890123456789012345678901234567890123456789012345');
    write('Digite o gabarito=> ');
    readln(gabarito);
    gabarito:=upcase(gabarito);
      indexGabarito:=1;
      erro:=false;
      repeat
        if(gabarito[indexGabarito]<'A') OR (GABARITO[indexGabarito]>'E')THEN
	        begin
	          WRITELN('ILEGAL');
	          erro:=true;
	        end
        ELSE
        indexGabarito:=indexGabarito+1
      UNTIL( indexGabarito>60 ) or (erro)
    UNTIL(indexGabarito>60);
    writeln('Gerando o arquivo com as notas...');
    
    //--------PEGA GABARITO OFICIAL (FIM)
    //-----LÊ O ARQUIVO DE PROVAS (INICIO)
    ASSIGN(arquivoDeProvas,'prova.txt');
    RESET(arquivoDeProvas);
    ASSIGN(arquivoDeNotas,'notas.txt');
    REWRITE(arquivoDeNotas);
    //leitura das inscr e resp
    WHILE NOT EOF(arquivoDeProvas) DO
    BEGIN
      READLN(arquivoDeProvas,registroDeProvas);
      resultado:= validaGabarito(COPY(registroDeProvas,5,64), gabarito);  // VALIDA AS NOTAS DO CANDIDATO
      indexString:=1;
      indexArrayString:=indexArrayString+1;
      insert(COPY(registroDeProvas,1,4), resposta[indexArrayString],indexString);
      FOR indexLeNotas:=1 TO 6 DO
	      BEGIN
	        if((resultado[indexLeNotas]<10) or (resultado[indexLeNotas]=0)) then
		        begin
		          indexString:=length(resposta[indexArrayString]) + 1;
		          str(resultado[indexLeNotas], notaMenorQueDez);
		          concatenaNota:= Concat('   ', notaMenorQueDez);
		          insert(concatenaNota, resposta[indexArrayString], indexString);
		        end
	        else if(resultado[indexLeNotas]<100) then
		        begin
		          indexString:=length(resposta[indexArrayString]) + 1;
		          str(resultado[indexLeNotas], notaMenorQueCem);
		          concatenaNota:= Concat('  ', notaMenorQueCem);
		          insert(concatenaNota, resposta[indexArrayString], indexString);
		        end
	        else
		        begin
		          indexString:=length(resposta[indexArrayString]) + 1;
		          str(resultado[indexLeNotas], notaCem);
		          concatenaNota:= Concat(' ', notaCem);
		          insert(concatenaNota, resposta[indexArrayString], indexString);
		        end;
	      END;
      WRITELN(arquivoDeNotas, resposta[indexArrayString]);
    END;
    
    writeln('Arquivo pronto.');
    TERMINE;
    CLOSE(arquivoDeProvas);
    CLOSE(arquivoDeNotas);
  END.