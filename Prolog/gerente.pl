:- use_module(library(http/json)).
:- consult('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% Cadastra um novo funcionario
cadastrarFuncionario(Id,Nome,SenhaFunc, IdGerente, Senha, Resposta):-
    validaGerente(IdGerente, Senha, Resposta1),
    Resposta1 = 'Gerente validado!',
    atom_string(IdAtom, Id),
    get_funcionario_by_id(IdAtom, Funcionario),
    Funcionario = -1,
    add_funcionario(Id, Nome, SenhaFunc),
    Resposta = 'Funcionário cadastrado!'.

% Caso algum erro ocorra, retorna uma mensagem de erro
cadastrarFuncionario(_, _, _, _, _,'Cadastro não realizado!').

% Exibe um funcionario
exibirFuncionario(ID, Resposta):-
    atom_string(IdAtom, ID),
    get_funcionario_by_id(IdAtom, Funcionario),
    Funcionario \= -1,
    extract_info_funcionarios_gerentes(Funcionario, _, Nome, _),
    string_concat('Nome: ', Nome, NomeLinha),
    string_concat(NomeLinha, ' - ', NomeTraco),
    string_concat(NomeTraco, ID, NomeTracoID),
    string_concat(NomeTracoID, '\n', Resposta).

% Caso funcionario não exista, retorna uma mensagem de erro
exibirFuncionario(_, 'Funcionário não existe!').

% Exibe todos os funcionarios
listaFuncionarios(Resposta) :-
    get_funcionarios(Funcionarios),
    organizaListagemFuncionarios(Funcionarios, Resposta).

% Organiza a listagem de funcionarios
organizaListagemFuncionarios([], '').
organizaListagemFuncionarios([H|T], Resposta) :-
    organizaListagemFuncionarios(T, Resposta1),
    extract_info_funcionarios_gerentes(H, ID, Nome, _),
    string_concat(Nome, ' - ', NomeTraco),
    string_concat(NomeTraco, ID, NomeTracoID),
    string_concat(NomeTracoID, '\n', Resposta2),
    string_concat(Resposta2, Resposta1, Resposta).

% Valida um gerente e sua senha
validaGerente(IdGerente, Senha, Resposta) :-
    atom_string(IdGerenteAtom, IdGerente),
    get_gerente_by_id(IdGerenteAtom, Gerente),
    extract_info_funcionarios_gerentes(Gerente, _, _, SenhaAtual),
    atom_string(SenhaAtom, Senha),
    SenhaAtom = SenhaAtual,
    Gerente \= -1,
    Resposta = 'Gerente validado!', !.


/* Essa regra é responsável por pegar os 3 filmes mais alugados do sistema */
get_top_filmes_mais_alugados(Resposta) :- 
    get_filmes(Filmes),
    get_n_destaques(Filmes, 3, 'mais_alugado', [], Filmes_Mais_Alugados),
    organizaListagemEstatistica(Filmes_Mais_Alugados, Resposta).

/* Essa regra é responsável por pegar os 3 filmes menos alugados do sistema */
get_top_filmes_menos_alugados(Resposta) :- 
    get_filmes(Filmes),
    get_n_destaques(Filmes, 3, 'menos_alugado', [], Filmes_Menos_Alugados),
    organizaListagemEstatistica(Filmes_Menos_Alugados, Resposta).

/* Essa regra é responsável por pegar os 3 séries mais alugados do sistema */
get_top_series_mais_alugadas(Resposta) :- 
    get_series(Serie),
    get_n_destaques(Serie, 3, 'mais_alugado', [], Series_Mais_Alugadas),
    organizaListagemEstatistica(Series_Mais_Alugadas, Resposta).

/* Essa regra é responsável por pegar os 3 séries menos alugados do sistema */
get_top_series_menos_alugadas(Resposta) :- 
    get_series(Serie),
    get_n_destaques(Serie, 3, 'menos_alugado', [], Series_Menos_Alugadas),
    organizaListagemEstatistica(Series_Menos_Alugadas, Resposta).

/* Essa regra é responsável por pegar os 3 jogos mais alugados do sistema */
get_top_jogos_mais_alugados(Resposta) :- 
    get_jogos(Jogos),
    get_n_destaques(Jogos, 3, 'mais_alugado', [], Jogos_Mais_Alugados),
    organizaListagemEstatistica(Jogos_Mais_Alugados, Resposta).

/* Essa regra é responsável por pegar os 3 jogos menos alugados do sistema */
get_top_jogos_menos_alugados(Resposta) :- 
    get_jogos(Jogos),
    get_n_destaques(Jogos, 3, 'menos_alugado', [], Jogos_Menos_Alugados),
    organizaListagemEstatistica(Jogos_Menos_Alugados, Resposta).

formata_renda(Renda_Filmes, Renda_Series, Renda_Jogos, Renda_Total, Resposta) :- 
    formata_valor(Renda_Filmes, Renda_Filmes_Formatada),
    formata_valor(Renda_Series, Renda_Series_Formatada),
    formata_valor(Renda_Jogos, Renda_Jogos_Formatada),
    formata_valor(Renda_Total, Renda_Total_Formatada),
    concatena_strings(['\nRenda de filmes: ', Renda_Filmes_Formatada, '\nRenda de series: ', Renda_Series_Formatada, '\nRenda de jogos: ', Renda_Jogos_Formatada, '\nRenda total: ', Renda_Total_Formatada], Resposta).

calcular_renda_total(Resposta) :-
    get_filmes(Filmes),
    get_series(Series),
    get_jogos(Jogos),
    calcula_renda_produtos(Filmes, 0, Renda_Filmes),
    calcula_renda_produtos(Series, 0, Renda_Series),
    calcula_renda_produtos(Jogos, 0, Renda_Jogos),
    Renda_Total is Renda_Filmes + Renda_Series + Renda_Jogos,
    formata_renda(Renda_Filmes, Renda_Series, Renda_Jogos, Renda_Total, Resposta).

calcula_renda_produtos([], RendaAcumulada, RendaAcumulada).
calcula_renda_produtos([ProdutoAtual|ProdutosRestantes], RendaAcumulada, RendaTotal) :-
    extract_info_produtos(ProdutoAtual, _, _, _, _, Renda, _),
    NovaRendaAcumulada is RendaAcumulada + Renda,
    calcula_renda_produtos(ProdutosRestantes, NovaRendaAcumulada, RendaTotal).

