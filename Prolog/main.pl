:- initialization (main).
:- include('cliente.pl').
:- include('funcionario.pl').
:- include('gerente.pl').
:- include('utils.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

main :- 
  writeln('\n======== Locadora - Sistema ========\n'),
  write('Selecione uma opção:\n'),
  write('1 - Cliente\n'),
  write('2 - Funcionario\n'),
  write('3 - Gerencia\n'),
  write('4 - Sair\n'),
  write('---->'),
  read(Opcao),
  write('\n'),
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
  write('--->'),
  read(Opcao),
  write('\n'),
  selecionadoCliente(Opcao).


selecionadoCliente(1) :-
  %Listar filmes
  listaFilmes(Resposta),
  write(Resposta),
  cliente.

selecionadoCliente(2) :-
  %Escolher filme
  cliente.

selecionadoCliente(3) :-
  %Listar series
  listaSeries(Resposta),
  write(Resposta),
  cliente.

selecionadoCliente(4) :-
  %Escolher serie
  cliente.

selecionadoCliente(5) :-
  %Listar jogos
  listaJogos(Resposta),
  write(Resposta),
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
  write('\n'),
  selecionadoFuncionario(Opcao).

selecionadoFuncionario(1) :-
  %Listar filmes disponiveis
  listaFilmes(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(2) :-
  %Listar series disponiveis
  listaSeries(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(3) :-
  %Listar jogos disponiveis
  listaJogos(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(4) :-
  %Cadastrar cliente
  write('Cadastro de cliente\n'),
  prompt('', _),
  prompt('Digite o nome do cliente: ', Nome),
  prompt('Digite o CPF do cliente: ', ID),
  prompt('Digite o seu Id: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  adicionaCliente(ID, Nome, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.  

selecionadoFuncionario(5) :-
  %Listar clientes
  listaClientes(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(6) :-
  %Encerrar cadastro de cliente
  prompt('', _),
  prompt('Digite o CPF do cliente: ', ID),
  prompt('Digite o seu Id: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  removerCliente(ID, IdFuncionario, Senha, Resposta),  
  write(Resposta),
  funcionario.

selecionadoFuncionario(7) :-
  %Exibir historico cliente
  prompt('', _),
  prompt('Digite o CPF do cliente: ', ID),
  exibirHistoricoCliente(ID, Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(8) :-
  %Cadastrar série
  prompt('', _),
  prompt('Digite o nome da série: ', Nome),
  prompt('Digite o ID da série: ', ID),
  prompt('Digite o ID do funcionário: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  prompt('Digite a categoria: ', Categoria),
  prompt('Digite a descrição: ', Descricao),
  prompt('Digite o preço: ', Preco),
  adicionarSeries(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(9) :-
  %Excluir série
  prompt('', _),
  prompt('Digite o ID da série: ', ID),
  prompt('Digite o ID do funcionário: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  removerSeries(ID, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(10) :-
  %Cadastrar filme
  prompt('', _),
  prompt('Digite o nome do filme: ', Nome),
  prompt('Digite o ID do filme: ', ID),
  prompt('Digite o ID do funcionário: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  prompt('Digite a categoria: ', Categoria),
  prompt('Digite a descrição: ', Descricao),
  prompt('Digite o preço: ', Preco),
  adicionarFilmes(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(11) :-
  %Excluir filme
  prompt('', _),
  prompt('Digite o ID do filme: ', ID),
  prompt('Digite o ID do funcionário: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  removerFilmes(ID, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(12) :-
  %Cadastrar jogo
  prompt('', _),
  prompt('Digite o nome do jogo: ', Nome),
  prompt('Digite o ID do jogo: ', ID),
  prompt('Digite o ID do funcionário: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  prompt('Digite a categoria: ', Categoria),
  prompt('Digite a descrição: ', Descricao),
  prompt('Digite o preço: ', Preco),
  adicionarJogos(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(13) :-
  %Exlcuir jogo
  prompt('', _),
  prompt('Digite o ID do jogo: ', ID),
  prompt('Digite o ID do funcionário: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  removerJogos(ID, IdFuncionario, Senha, Resposta),
  write(Resposta),
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
  write('\n'),
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

prompt(Message, String) :-
  write(Message),
  flush_output,
  read_line_to_codes(user_input, Codes),
  string_codes(String, Codes).

limpar_entrada :-
  flush_output,
  current_input(Stream),
  set_input(Stream).