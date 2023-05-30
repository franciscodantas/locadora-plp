:- import('utils.pl').

gerente :- 
  writeln('\n======== Locadora - Sistema - Gerente ========\n'),
  write('1- Cadastrar funcionário\n'),
  write('2- Exibir funcionário\n'),
  write('3- Listar funcionários\n'),
  write('4- Estatisticas de vendas\n'),
  write('5- menu principal\n'),
  write('--->'),
  read(Opcao),
  selecionadoGerente(Opcao).

selecionadoGerente(1) :-
  %Cadastrar funcionário
  gerente.
  
selecionadoGerente(2) :-
  %Exibir funcionário
  gerente.

selecionadoGerente(3) :-
  %Listar funcionários
  gerente.

selecionadoGerente(4) :-
  %Estatisticas de vendas
  gerente.

selecionadoGerente(5) :-
  %menu principal
  gerente.

selecionadoGerente(_) :- write('Opcao invalida'),
  gerente.