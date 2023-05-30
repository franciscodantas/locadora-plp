:- (initialization main).
:- include('cliente.pl').
:- include('funcionario.pl').
:- include('gerente.pl').

main :- 
  writeln('"\n======== Locadora - Sistema ========\n"'),
  write('Selecione uma opção:\n'),
  write('1 - Cliente\n'),
  write('2 - Funcionario\n'),
  write('3 - Gerencia\n'),
  write('4 - Sair\n'),
  write('----> '),
  read(Opcao),
  selecionado(Opcao).

selecionado(1) :-
  cliente,
  main.

selecionado(2) :-
  funcionario,
  main.

selecionado(3) :-
  gerente,
  main.

selecionado(4) :- write('Saindo...'), 
halt.

selecionado(_) :-
  write('Selecione uma opção válida'),
  main.

  
  