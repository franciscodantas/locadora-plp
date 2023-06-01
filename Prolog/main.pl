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

%Menu cliente
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
  main.

selecionadoCliente(_) :- write('Opcao invalida'), cliente.

%Menu funcionario
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
  main.

selecionadoFuncionario(_) :- write('Opcao invalida'),
  funcionario.

%Menu gerente
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
  main.

selecionadoGerente(_) :- write('Opcao invalida'),
  gerente.