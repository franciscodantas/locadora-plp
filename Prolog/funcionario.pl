:- use_module(library(http/json)).
:- use_module('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').

listaFilmes(Resposta) :- 
    get_filmes(Data),
    organizaListagemProdutos(Data, Resposta).

organizaListagemProdutos([], "").
organizaListagemProdutos([H|T], Resposta) :-
    organizaListagemProdutos(T, Resposta1),
    extract_info_produtos(H, _, Nome, Descricao, _, _, _),
    string_concat(Nome, "\n", NomeComQuebraDeLinha),
    string_concat(Descricao, "\n", DescricaoComQuebraDeLinha),
    string_concat(NomeComQuebraDeLinha, DescricaoComQuebraDeLinha, ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).
