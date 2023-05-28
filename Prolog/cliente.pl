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

