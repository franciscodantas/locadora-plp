:- use_module(library(http/json)).
:- import('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

cadastrarFuncionario(Id,Nome, IdGerente, Senha, Resposta):-
    validaGerente(IdGerente, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IdAtom, Id),
    get_funcionario_by_id(IdAtom, Funcionario),
    Funcionario = -1,
    add_funcionario(Id, Nome),
    Resposta = 'Funcionário cadastrado!'.

cadastrarFuncionario(_, _, _, _, 'Funcionário ja cadastrado!').

exibirFuncionario(ID, Resposta):-
    atom_string(IdAtom, ID),
    get_funcionario_by_id(IdAtom, Funcionario),
    Funcionario \= -1,
    extract_info_funcionarios_gerentes(Funcionario, _, Nome),
    string_concat('Nome: ', Nome, NomeLinha),
    string_concat(NomeLinha, ' - ', NomeTraco),
    string_concat(NomeTraco, ID, NomeTracoID),
    string_concat(NomeTracoID, '\n', Resposta).

exibirFuncionario(_, 'Funcionário não existe!').

listaFuncionarios(Resposta) :-
    get_funcionarios(Funcionarios),
    organizaListagemFuncionarios(Funcionarios, Resposta).

organizaListagemFuncionarios([], '').
organizaListagemFuncionarios([H|T], Resposta) :-
    organizaListagemFuncionarios(T, Resposta1),
    extract_info_funcionarios_gerentes(H, Nome, ID),
    string_concat(Nome, ' - ', NomeTraco),
    string_concat(NomeTraco, ID, NomeTracoID),
    string_concat(NomeTracoID, '\n', Resposta2),
    string_concat(Resposta2, Resposta1, Resposta).

validaGerente(IdGerente, Senha, Resposta) :-
    atom_string(IdGerenteAtom, IdGerente),
    atom_string(SenhaAtom, Senha),
    get_gerente_by_id(IdGerenteAtom, Gerente),
    ((SenhaAtom = '123', Gerente \= -1) ->
        Resposta = 'Funcionario validado!';
        Resposta = 'Funcionario invalido!').
