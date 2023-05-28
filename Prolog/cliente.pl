:- import('utils.pl').

cliente :-
  writeln('\n======== Locadora - Sistema - Cliente ========\n'),
  write('1 - Listar filmes\n'),
  write('2 - Escolher filme\n'),
  write('3 - Listar series\n'),
  write('4 - Escolher serie\n'),
  write('5 - Listar jogos\n'),
  write('6 - Escolher jogo\n'),
  write('7 - Produto por categoria\n'),
  write('8 - Adicionar Filme ao carrinho\n'),
  write('9 - Adicionar Jogo ao carrinho\n'),
  write('10 - Adicionar Série ao carrinho\n'),
  write('11 - Remover do carrinho\n'),
  write('12 - Ver carrinho\n'),
  write('13 - Recomendações\n'),
  write('14 - Listar histórico cliente\n'),
  write('15 - menu principal\n'),
  write('--->')
  read(Opcao),
  selecionadoCliente(Opcao).


selecionadoCliente(1) :-
  %Listar filmes
  cliente.

selecionadoCliente(2) :-
  %Escolher filme
  cliente.

selecionadoCliente(3) :-
  %Listar series
  cliente.

selecionadoCliente(4) :-
  %Escolher serie
  cliente.

selecionadoCliente(5) :-
  %Listar jogos
  cliente.

selecionadoCliente(6) :-
  %Escolher jogo
  cliente.

selecionadoCliente(7) :-
  %Produto por categoria
  cliente.

selecionadoCliente(8) :-
  %Adicionar Filme ao carrinho
  cliente.

selecionadoCliente(9) :-
  %Adicionar Jogo ao carrinho
  cliente.

selecionadoCliente(10) :-
  %Adicionar Série ao carrinho
  cliente.

selecionadoCliente(11) :-
  %Remover de carrinho
  cliente.

selecionadoCliente(12) :-
  %Ver carrinho
  cliente.

selecionadoCliente(13) :-
  %Recomendações
  cliente.

selecionadoCliente(14) :-
  %Listar histórico cliente
  cliente.

selecionadoCliente(15) :-
  %menu principal
  cliente.

selecionadoCliente(_) :- write('Opcao invalida'), cliente.
