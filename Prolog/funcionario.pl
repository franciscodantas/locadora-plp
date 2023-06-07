:- use_module(library(http/json)).
:- use_module('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% Retorna a lista de filmes, com nome e descrição
listaFilmes(Resposta) :- 
    get_filmes(Data),
    organizaListagemProdutos(Data, Resposta).

listaSeries(Resposta) :- 
    get_series(Data),
    organizaListagemProdutos(Data, Resposta).

listaJogos(Resposta) :- 
    get_jogos(Data),
    organizaListagemProdutos(Data, Resposta).

listaClientes(Resposta) :- 
    get_cientes(Data),
    organizaListagemCliente(Data, Resposta).

adicionaCliente(ID,Nome,IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    add_cliente(ID,Nome),
    Resposta = 'Cadastro realizado!'.

adicionaCliente(_, _, _, _, Resposta) :-
        Resposta = 'Cadastro não realizado!'.

adicionarSeries(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    add_serie(ID, Nome, Descricao, Categoria, Preco),
    Resposta = 'Serie adicionada!'.

adicionarSeries(_, _, _, _, _, _, _, Resposta) :-
    Resposta = 'Serie não adicionada!'.

removerSeries(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    remove_serie_by_id(IDAtom),
    Resposta = 'Serie removida!'.

removerSeries(_, _, _, Resposta):-
    Resposta = 'Serie não removida!'.

adicionarFilmes(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    add_filme(ID, Nome, Descricao, Categoria, Preco),
    Resposta = 'Filme adicionado!'.

adicionarFilmes(_, _, _, _, _, _, _, Resposta):-
    Resposta = 'Filme não adicionado!'.

removerFilmes(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    remove_filme_by_id(IDAtom),
    Resposta = 'Filme removido!'.

removerFilmes(_, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario invalido!',
    Resposta = 'Filme não removido!'.

adicionarJogos(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):- 
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    add_jogo(ID, Nome, Descricao, Categoria, Preco),
    Resposta = 'Jogo adicionado!'.

adicionarJogos(_, _, _, _, _, IdFuncionario, Senha, Resposta):- 
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario invalido!',
    Resposta = 'Jogo não adicionado!'.

removerJogos(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    remove_jogo_by_id(IDAtom),
    Resposta = 'Jogo removido!'.
removerJogos(_, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario invalido!',
    Resposta = 'Jogo não removido!'.

removerCliente(ID, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    remove_cliente_by_id(IDAtom),
    Resposta = 'Cliente removido!'.

removerCliente(_, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario invalido!',
    Resposta = 'Cliente não removido!'.

exibirHistoricoCliente(ID, Resposta) :-
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, Nome, _, Historico),
    organizaListagemHistorico(Historico, Resposta1),
    string_concat('Historico de compras de ', Nome, NomeLinha),
    string_concat(NomeLinha, '\n\n', NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, Resposta1, Resposta).

organizaListagemHistorico([], '').
organizaListagemHistorico([H|T], Resposta) :- 
    organizaListagemHistorico(T, Resposta1),
    extract_info_historico(H, _, _, IdProduto, Tipo, _),
    get_info(IdProduto, Tipo, Nome, Descricao),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Descricao, NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, '\n\n', NomeLinhaComQuebraDeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinhaComQuebraDeLinha, Resposta1, Resposta).

% Organiza a listagem de produtos
organizaListagemProdutos([], '').
organizaListagemProdutos([H|T], Resposta) :-
    organizaListagemProdutos(T, Resposta1),
    extract_info_produtos(H, _, Nome, Descricao, _, _, _),
    string_concat(Nome, '\n', NomeComQuebraDeLinha),
    string_concat(Descricao, '\n', DescricaoComQuebraDeLinha),
    string_concat(NomeComQuebraDeLinha, DescricaoComQuebraDeLinha, Produtos),
    string_concat(Produtos, '\n', ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

organizaListagemCliente([], '').
organizaListagemCliente([H|T], Resposta) :-
    organizaListagemCliente(T, Resposta1),
    extract_info_clientes(H, Id, Nome, _, _),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Id, Produtos),
    string_concat(Produtos, '\n', ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

validaFuncionario(IdFuncionario, Senha, Resposta) :-
    atom_string(IdFuncionarioAtom, IdFuncionario),
    atom_string(SenhaAtom, Senha),
    get_funcionario_by_id(IdFuncionarioAtom, Funcionario),
    ((SenhaAtom = '123', Funcionario \= -1) ->
        Resposta = 'Funcionario validado!';
        Resposta = 'Funcionario invalido!').
