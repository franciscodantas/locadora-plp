:- use_module(library(http/json)).
:- import('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).


adicionaCliente(ID,Nome,IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente = -1,
    add_cliente(ID,Nome),
    Resposta = 'Cadastro realizado!'.

adicionaCliente(_, _, _, _, 'Cadastro não realizado!').

adicionarSeries(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_serie_by_id(IDAtom, Serie),
    Serie = -1,
    add_serie(ID, Nome, Descricao, Categoria, Preco),
    Resposta = 'Serie adicionada!'.

adicionarSeries(_, _, _, _, _, _, _, 'Serie não adicionada!').

removerSeries(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_serie_by_id(IDAtom, Serie),
    Serie \= -1,
    remove_serie_by_id(IDAtom),
    Resposta = 'Serie removida!'.

removerSeries(_, _, _, 'Serie não removida!').

adicionarFilmes(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_filme_by_id(IDAtom, Filme),
    Filme = -1,
    add_filme(ID, Nome, Descricao, Categoria, Preco),
    Resposta = 'Filme adicionado!'.

adicionarFilmes(_, _, _, _, _, _, _, 'Filme não adicionado!').

removerFilmes(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_filme_by_id(IDAtom, Filme),
    Filme \= -1,
    remove_filme_by_id(IDAtom),
    Resposta = 'Filme removido!'.

removerFilmes(_, _, _, 'Filme não removido!').

adicionarJogos(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):- 
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_jogo_by_id(IDAtom, Jogo),
    Jogo = -1,
    add_jogo(ID, Nome, Descricao, Categoria, Preco),
    Resposta = 'Jogo adicionado!'.

adicionarJogos(_, _, _, _, _, _, _, 'Jogo não adicionado!').

removerJogos(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_jogo_by_id(IDAtom, Jogo),
    Jogo \= -1,
    remove_jogo_by_id(IDAtom),
    Resposta = 'Jogo removido!'.

removerJogos(_, _, _, 'Jogo não removido!').

removerCliente(ID, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    remove_cliente_by_id(IDAtom),
    Resposta = 'Cliente removido!'.

removerCliente(_, _, _, 'Cliente não removido!').

exibirHistoricoCliente(ID, Resposta) :-
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    extract_info_clientes(Cliente, _, Nome, _, Historico),
    organizaListagemHistorico(Historico, Resposta1),
    string_concat('Historico de compras de ', Nome, NomeLinha),
    string_concat(NomeLinha, '\n\n', NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, Resposta1, Resposta).

exibirHistoricoCliente(_, 'Cliente não encontrado!').

validaFuncionario(IdFuncionario, Senha, Resposta) :-
    atom_string(IdFuncionarioAtom, IdFuncionario),
    get_funcionario_by_id(IdFuncionarioAtom, Funcionario),
    extract_info_funcionarios_gerentes(Funcionario, _, _, SenhaAtual),
    atom_string(SenhaAtom, Senha),
    SenhaAtom = SenhaAtual,
    Funcionario \= -1,
    Resposta = 'Funcionario validado!'.
