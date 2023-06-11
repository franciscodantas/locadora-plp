:- initialization (main).
% Inclusão da base de dados
:- consult('DataBase/gerenciadorGeral.pl').
:- consult('DataBase/gerenciadorProdutos.pl').
:- consult('DataBase/gerenciadorClientes.pl').
:- consult('DataBase/gerenciadorFuncionarios.pl').
:- consult('DataBase/gerenciadorGerentes.pl').

% Inclusão das constantes
:- consult('constantes.pl').

% Inclusão das funções das entidades
:- include('cliente.pl').
:- include('funcionario.pl').
:- include('gerente.pl').

% Inclusão dos utilitários
:- consult('utils.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).
:- use_module(library(http/json)).
:- use_module(library(date)).
:- use_module(library(random)).

% Regra que generaliza a interação com o usuário
% Esse regra imprime uma mensagem no terminal e pega um dado usuário
prompt(Message, String) :-
    write(Message),
    flush_output,
    read_line_to_codes(user_input, Codes),
    string_codes(String, Codes).

main :- 
  writeln('\n======== Locadora - Sistema ========\n'),
  write('Selecione uma opção:\n'),
  write('1 - Cliente\n'),
  write('2 - Funcionario\n'),
  write('3 - Gerencia\n'),
  write('4 - Sair\n'),
  prompt('----> ', Input),
  atom_number(Input, Opcao),
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

selecionado(4) :- 
  write('Saindo...'), 
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
  write('13 - Alugar produtos no carrinho\n'),
  write('14 - Recomendações\n'),
  write('15 - Listar histórico cliente\n'),
  write('16 - menu principal\n'),
  prompt('----> ', Input),
  atom_number(Input, Opcao),
  write('\n'),
  selecionadoCliente(Opcao).

selecionadoCliente(1) :-
    %Listar filmes
    listaFilmes(Resposta),
    write(Resposta),
    cliente.

selecionadoCliente(2) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome do filme: ', Nome),
  subMenuDiasSemanas(Opc),
  alugaFilme(Id, Nome, Opc),
  cliente.

selecionadoCliente(3) :-
    %Listar series
    listaSeries(Resposta),
    write(Resposta),
    cliente.

selecionadoCliente(4) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome da serie: ', Nome),
  subMenuDiasSemanas(Opc),
  alugaSerie(Id, Nome, Opc),
  cliente.

selecionadoCliente(5) :-
    %Listar jogos
    listaJogos(Resposta),
    write(Resposta),
    cliente.

selecionadoCliente(6) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome do jogo: ', Nome),
  subMenuDiasSemanas(Opc),
  alugaJogo(Id, Nome, Opc),
  cliente.

selecionadoCliente(7) :-
  subMenuCategoria(Opc),
  produtoPorCategoria(Opc),
  cliente.

selecionadoCliente(8) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome do filme: ', Nome),
  addFilmeCarrinho(Id, Nome),
  cliente.

selecionadoCliente(9) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome do jogo: ', Nome),
  addJogoCarrinho(Id, Nome),
  cliente.

selecionadoCliente(10) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome da série: ', Nome),
  addSerieCarrinho(Id, Nome),
  cliente.

selecionadoCliente(11) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  prompt('Nome do produto: ', Nome),
  removeDoCarrinhoTipo(Id, Nome),
  cliente.

selecionadoCliente(12) :-
  prompt('Seu Id: ', Id),
  exibeCarrinho(Id, Resposta),
  write(Resposta),
  cliente.

selecionadoCliente(13) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  subMenuDiasSemanas(Opc),
  alugaCarrinho(Id, Opc),
  cliente.

selecionadoCliente(14) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  subMenuRecs(Opc),
  get_recomendacoes(Id, Opc, Resposta),
  write(Resposta),
  cliente.
  
selecionadoCliente(15) :-
  prompt('Seu Id: ', Id),
  valida_cliente(Id),
  exibeHistorico(Id, Resposta),
  write(Resposta),
  cliente.

selecionadoCliente(16) :-
  %menu principal
  main.

selecionadoCliente(_) :- write('Opcao invalida'), cliente.

subMenuDiasSemanas(Opc) :-
  write('1 - Alugar por dias\n'),
  write('2 - Alugar por semanas\n'),
  prompt('----> ', Input),
  number_string(Opc, Input).

subMenuCategoria(Opc) :-
  write('1 - Filmes por categoria\n'),
  write('2 - Series por categoria\n'),
  write('3 - Jogos por categoria\n'),
  prompt('----> ', Input),
  number_string(Opc, Input).

subMenuRecs(Opc) :-
  write('1 - Recomendações de filmes\n'),
  write('2 - Recomendações de séries\n'),
  write('3 - Recomendações de jogos\n'),
  prompt('----> ', Input),
  number_string(Opc, Input).

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
  prompt('----> ', Input),
  atom_number(Input, Opcao),
  write('\n'),
  selecionadoFuncionario(Opcao).

selecionadoFuncionario(1) :-
  %Listar filmes disponiveis
  write('Lista de filmes disponiveis:\n\n'),
  listaFilmes(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(2) :-
  %Listar series disponiveis
  write('Lista de series disponiveis:\n\n'),
  listaSeries(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(3) :-
  %Listar jogos disponiveis
  write('Lista de jogos disponiveis:\n\n'),
  listaJogos(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(4) :-
  %Cadastrar cliente
  prompt('Digite o nome do cliente: ', Nome),
  prompt('Digite o CPF do cliente: ', ID),
  prompt('Digite o seu Id: ', IdFuncionario),
  prompt('Digite a senha: ', Senha),
  adicionaCliente(ID, Nome, IdFuncionario, Senha, Resposta),
  write(Resposta),
  funcionario.  

selecionadoFuncionario(5) :-
  %Listar clientes
  write('Lista de clientes:\n\n'),
  listaClientes(Resposta),
  write(Resposta),
  funcionario.

selecionadoFuncionario(6) :-
    %Encerrar cadastro de cliente
    prompt('Digite o CPF do cliente: ', ID),
    prompt('Digite o seu Id: ', IdFuncionario),
    prompt('Digite a senha: ', Senha),
    removerCliente(ID, IdFuncionario, Senha, Resposta),    
    write(Resposta),
    funcionario.

selecionadoFuncionario(7) :-
    %Exibir historico cliente
    prompt('Digite o CPF do cliente: ', ID),
    exibirHistoricoCliente(ID, Resposta),
    write(Resposta),
    funcionario.

selecionadoFuncionario(8) :-
    %Cadastrar série
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
    prompt('Digite o ID da série: ', ID),
    prompt('Digite o ID do funcionário: ', IdFuncionario),
    prompt('Digite a senha: ', Senha),
    removerSeries(ID, IdFuncionario, Senha, Resposta),
    write(Resposta),
    funcionario.

selecionadoFuncionario(10) :-
    %Cadastrar filme
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
    prompt('Digite o ID do filme: ', ID),
    prompt('Digite o ID do funcionário: ', IdFuncionario),
    prompt('Digite a senha: ', Senha),
    removerFilmes(ID, IdFuncionario, Senha, Resposta),
    write(Resposta),
    funcionario.

selecionadoFuncionario(12) :-
    %Cadastrar jogo
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
  prompt('----> ', Input),
  atom_number(Input, Opcao),
  write('\n'),
  selecionadoGerente(Opcao).

selecionadoGerente(1) :-
    %Cadastrar funcionário
    prompt('Digite o nome do funcionário: ', Nome),
    prompt('Digite o ID do funcionário: ', Id),
    prompt('Digite a senha do Funcionário: ', SenhaFunc),
    prompt('Digite a senha: ', Senha),
    prompt('Digite o seu Id: ', IdGerente),
    cadastrarFuncionario(Id,Nome,SenhaFunc, IdGerente, Senha, Resposta),
    write(Resposta),
    gerente.
    
selecionadoGerente(2) :-
    %Exibir funcionário
    prompt('Digite o ID do funcionário: ', ID),
    exibirFuncionario(ID, Resposta),
    write(Resposta),
    gerente.

selecionadoGerente(3) :-
    %Listar funcionários
    listaFuncionarios(Resposta),
    write(Resposta),
    gerente.

selecionadoGerente(4) :-
  %Estatisticas de vendas
  writeln('\n======== Locadora - Sistema - Gerente - Estatíticas ========\n'),
  write('1- Estatistica de filmes\n'),
  write('2- Estatistica de séries\n'),
  write('3- Estatistica de jogos\n'),
  write('4- Estatistica de renda\n'),
  write('5- Estatistica de quantidades\n'),
  write('6- Menu principal\n'),
  prompt('----> ', Input),
  atom_number(Input, Opcao),
  write('\n'),
  selecionadoSubopcaoGerente(Opcao),
  gerente.

selecionadoGerente(5) :-
    %menu principal
    main.

selecionadoGerente(_) :- write('Opcao invalida'),
    gerente.

selecionadoSubopcaoGerente(1) :- 
    get_top_filmes_mais_alugados(Filmes_Mais_Alugados),
    get_top_filmes_menos_alugados(Filmes_Menos_Alugados),
    writeln('======== FILMES MAIS ALUGADOS ========'),
    writeln(Filmes_Mais_Alugados),
    writeln('======== FILMES MENOS ALUGADOS ========'),
    writeln(Filmes_Menos_Alugados),

    gerente.

selecionadoSubopcaoGerente(2) :- 
    get_top_series_mais_alugadas(Series_Mais_Alugadas),
    get_top_series_menos_alugadas(Series_Menos_Alugadas),
    writeln('======== SÉRIES MAIS ALUGADAS ========'),
    writeln(Series_Mais_Alugadas),
    writeln('======== SÉRIES MENOS ALUGADAS ========'),
    writeln(Series_Menos_Alugadas),

    gerente.

selecionadoSubopcaoGerente(3) :- 
    get_top_jogos_mais_alugados(Jogos_Mais_Alugados),
    get_top_jogos_menos_alugados(Jogos_Menos_Alugados),
    writeln('======== JOGOS MAIS ALUGADOS ========'),
    writeln(Jogos_Mais_Alugados),
    writeln('======== JOGOS MENOS ALUGADOS ========'),
    writeln(Jogos_Menos_Alugados),
    
    gerente.

selecionadoSubopcaoGerente(4) :- 
    writeln('======== ESTATÍSTICA DE RENDA ========'),
    calcular_renda_total(Renda),
    writeln(Renda),
    gerente.

selecionadoSubopcaoGerente(5) :- 
    totalFuncionarios(FuncionariosT),
    totalFilmes(FilmesT),
    totalUsuarios(ClienteT),
    totalJogos(JogosT),
    totalSeries(SeriesT),
    totalClientesPedidosNaoFinalizado(ClientePNF),
    writeln('======== ESTATÍSTICA DE QUANTIDADES ========'),
    write('Total de funcionarios: '),
    writeln(FuncionariosT),
    write('Total de filmes: '),
    writeln(FilmesT),
    write('Total de clientes: '),
    writeln(ClienteT),
    write('Total de jogos: '),
    writeln(JogosT),
    write('Total de series: '),
    writeln(SeriesT),
    write('Pedidos não finalizados: '),
    writeln(ClientePNF),
    gerente.

selecionadoSubopcaoGerente(6) :- 
    main.

selecionadoSubopcaoGerente(7) :- write('Opcao invalida'),
    gerente.
