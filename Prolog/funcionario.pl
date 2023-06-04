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

adicionaCliente(ID,Nome,_,_, Resposta) :-
    add_cliente(ID,Nome),
    Resposta = 'Cadastro realizado!'.

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

