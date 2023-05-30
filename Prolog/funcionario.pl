:- import('utils.pl').

funcionario :-
  writeln('\n======== Locadora - Sistema - Funcionário ========\n'),
  write('1 - Listar filmes disponiveis\n'),
  write('2 - Listar series disponiveis\n'),
  write('3 - Listar jogos disponiveis\n'),
  write('4 - Cadastrar cliente\n'),
  write('5 - Listar clientes\n'),
  write('6 - Encerrar cadastro de cliente\n'),
  write('7 - Exibir historico cliente\n'),
  write('8 - Cadastrar série\n'),
  write('9 - Excluir série\n'),
  write('10 - Cadastrar filme\n'),
  write('11 - Excluir filme\n'),
  write('12 - Cadastrar jogo\n'),
  write('13 - Exlcuir jogo\n'),
  write('14 - menu principal\n'),
  write('--->'),
  read(Opcao),
  selecionadoFuncionario(Opcao).

selecionadoFuncionario(1) :-
  %Listar filmes disponiveis
  funcionario.

selecionadoFuncionario(2) :-
  %Listar series disponiveis
  funcionario.

selecionadoFuncionario(3) :-
  %Listar jogos disponiveis
  funcionario.

selecionadoFuncionario(4) :-
  %Cadastrar cliente
  funcionario.

selecionadoFuncionario(5) :-
  %Listar clientes
  funcionario.

selecionadoFuncionario(6) :-
  %Encerrar cadastro de cliente
  funcionario.

selecionadoFuncionario(7) :-
  %Exibir historico cliente
  funcionario.

selecionadoFuncionario(8) :-
  %Cadastrar série
  funcionario.

selecionadoFuncionario(9) :-
  %Excluir série
  funcionario.

selecionadoFuncionario(10) :-
  %Cadastrar filme
  funcionario.

selecionadoFuncionario(11) :-
  %Excluir filme
  funcionario.

selecionadoFuncionario(12) :-
  %Cadastrar jogo
  funcionario.

selecionadoFuncionario(13) :-
  %Exlcuir jogo
  funcionario.

selecionadoFuncionario(14) :-
  %menu principal
  funcionario.

selecionadoFuncionario(_) :- write('Opcao invalida'),
  funcionario.