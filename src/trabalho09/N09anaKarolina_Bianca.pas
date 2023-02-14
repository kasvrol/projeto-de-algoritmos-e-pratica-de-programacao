Program N09anaKarolina_Bianca;
{Estudantes: Ana Karolina dos Santos e Bianca Dalmaz Paquete}
USES BIBLIONT;
var //arquivos
arquivoDeCandidatos:file of regis;
registroCandidatos:regis;
arquivoNotas:TEXT;
//outras
vet:vetor;
posiv,indexArqNotas,indexNotas,registroInicial,registroFinal, indexVet,tamanhoChar, indexForOrd, qtyDeCand, notaInt, indexCand, transInt, indexNum:integer;
registroDeNotas, registro:string[28];
inscricao, numInscricao:string[4];
BEGIN
  assign(arquivoDeCandidatos,'cand.ind');
  assign(arquivoNotas,'NOTAS.txt');
  RESET(arquivoDeCandidatos);
  RESET(arquivoNotas);
writeln('Lendo a quantidade de candidatos...');
//--------------INICIO DA MONTAGEM;
repeat
  read(arquivoDeCandidatos,registroCandidatos);
  indexVet:=indexCand+1;        //indexVet = indice do vetor
  vet[indexVet].pf:=indexCand;    //indexCand = posicao fisica do registro no arquivo
  str(registroCandidatos.num,inscricao);
  tamanhoChar:=length(inscricao);
  for indexNum:=1 to 4-tamanhoChar do
  insert('0',inscricao,1);  //insere zeros a esquerda para ficar compativel com o numero lido em faltas
  vet[indexVet].cc:=inscricao;
  indexCand:=indexCand+1;
until(eof(arquivoDeCandidatos));
//--------------FIM DA MONTAGEM E DEMONSTRAÇÃO DE PESSOAS;
WRITELN('PRIMEIROS 15 ELEMENTOS ANTES DA ORDENAÇÃO:');
for indexForOrd:=1 to 15 do
  writeln(' ',vet[indexForOrd].cc,'  ',vet[indexForOrd].pf:5);
writeln;
writeln('------- APERTE ENTER PARA CONTINUAR -------');
readln;
writeln;
writeln('Aguarde, estamos ordenando os candidatos...');
writeln;
qtyDeCand:= indexVet;
ordem(vet,qtyDeCand);
WRITELN('PRIMEIROS 15 ELEMENTOS APÓS A ORDENAÇÃO:');
for indexForOrd:=1 to 15 do
  writeln(' ',vet[indexForOrd].cc,'  ',vet[indexForOrd].pf:5);
//--------------FIM DA ORDENAÇÃO E INICIO DA LEITURA DE NOTAS;
 writeln(' NUM  NOME                                  CONTEUDO   INDICE     PF NO      REG.   N1  N2  N3  N4  N5  N6 SOMA');
 writeln('                                            DO VETOR   DO VETOR   ARQUIVO    FALTA');
repeat
  indexArqNotas:=indexArqNotas+1;
  readln(arquivoNotas,registroDeNotas);
  inscricao:=copy(registroDeNotas,1,4); //----Lê inscrição da nota;
  pebin1(vet,inscricao,qtyDeCand,posiv); //----Procura o inscrição relacionado a pf no vet;
  seek(arquivoDeCandidatos,vet[posiv].pf);
  read(arquivoDeCandidatos,registroCandidatos);
  registroInicial:=5;
  registroCandidatos.som:=0;
  for indexNotas:=1 to 6 do
  begin       //----Lê as notas da inscrição;
    registroFinal:=registroInicial+3;
    val(copy(registroDeNotas,registroInicial,registroFinal),notaInt,transInt);
    registroCandidatos.NOTAS[indexNotas]:= notaInt;
    registroCandidatos.som:=notaInt+registroCandidatos.som;
    registroInicial:=registroFinal+1;
  end;
  writeln;
  IF(indexArqNotas MOD 20 = 0)THEN
  begin
    writeln('APERTE ENTER PARA CONTINUAR');
    readln;                                                                                                                             
    writeln(' NUM  NOME                                  CONTEUDO   INDICE     PF NO      REG.   N1  N2  N3  N4  N5  N6 SOMA');
    writeln('                                            DO VETOR   DO VETOR   ARQUIVO    FALTA');
  end;
  write(registroCandidatos.num:5,' ',registroCandidatos.nome,inscricao:10);
  write(posiv:10,vet[posiv].pf:10,registroCandidatos.falta:9,'   ');
  for indexNotas:=1 to 6 do
  begin
    write(registroCandidatos.NOTAS[indexNotas]:3,' ');
  end;
  writeln(' ',registroCandidatos.som:3);
  seek(arquivoDeCandidatos,vet[posiv].pf);//RETORNA APONTADOR PARA INICIO DO REGISTRO
  write(arquivoDeCandidatos,registroCandidatos);
until eof(arquivoNotas);
//--------------FIM DA LEITURA DE NOTAS;
writeln;
writeln('Total de candidatos na prova --',indexArqNotas:5,' candidatos');
termine;
CLOSE(arquivoNotas);
CLOSE(arquivoDeCandidatos);
END.