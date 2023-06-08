:- use_module(library(http/json)).
:- import('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

cadastrarFuncionario(Id,Nome,SenhaFunc, IdGerente, Senha, Resposta):-
    validaGerente(IdGerente, Senha, Resposta1),
    Resposta1 = 'Gerente validado!',
    atom_string(IdAtom, Id),
    get_funcionario_by_id(IdAtom, Funcionario),
    Funcionario = -1,
    add_funcionario(Id, Nome, SenhaFunc),
    Resposta = 'Funcionário cadastrado!'.

cadastrarFuncionario(_, _, _, _, _,'Cadastro não realizado!').

exibirFuncionario(ID, Resposta):-
    atom_string(IdAtom, ID),
    get_funcionario_by_id(IdAtom, Funcionario),
    Funcionario \= -1,
    extract_info_funcionarios_gerentes(Funcionario, _, Nome, _),
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
    extract_info_funcionarios_gerentes(H, ID, Nome, _),
    string_concat(Nome, ' - ', NomeTraco),
    string_concat(NomeTraco, ID, NomeTracoID),
    string_concat(NomeTracoID, '\n', Resposta2),
    string_concat(Resposta2, Resposta1, Resposta).

validaGerente(IdGerente, Senha, Resposta) :-
    atom_string(IdGerenteAtom, IdGerente),
    get_gerente_by_id(IdGerenteAtom, Gerente),
    extract_info_funcionarios_gerentes(Gerente, _, _, SenhaAtual),
    atom_string(SenhaAtom, Senha),
    SenhaAtom = SenhaAtual,
    Gerente \= -1,
    Resposta = 'Gerente validado!', !.

seleciona_aluguel_destaque('mais_alugado', QtdAlugueis1, QtdAlugueis2, Produto1, Produto2, Destaque) :- 
    (QtdAlugueis1 > QtdAlugueis2 -> Destaque = Produto1 ; Destaque = Produto2).
seleciona_aluguel_destaque('menos_alugado', QtdAlugueis1, QtdAlugueis2, Produto1, Produto2, Destaque) :- 
    (QtdAlugueis1 > QtdAlugueis2 -> Destaque = Produto2 ; Destaque = Produto1).

get_produto_em_destaque([], _, Produto_Maior_Atual, Produto_Maior_Atual).
get_produto_em_destaque([Produto_Atual | Tail], Tipo_Destaque, Produto_Maior_Atual, Produto_Maior_Final) :- 
    extract_info_produtos(Produto_Atual, _, _, _, _, _, QtdAlugueis_Atual),
    extract_info_produtos(Produto_Maior_Atual, _, _, _, _, _, QtdAlugueis_Maior),
    seleciona_aluguel_destaque(Tipo_Destaque, QtdAlugueis_Atual, QtdAlugueis_Maior, Produto_Atual, Produto_Maior_Atual, Novo_Maior),
    get_produto_em_destaque(Tail, Tipo_Destaque, Novo_Maior, Produto_Maior_Final).

