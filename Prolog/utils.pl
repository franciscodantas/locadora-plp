:- consult('DataBase/GerenciadorBD.pl').

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

organizaListagemCarrinho([], '').
organizaListagemCarrinho([H|T], Resposta) :- 
    organizaListagemCarrinho(T, Resposta1),
    extract_info_carrinho(H, _, IdProduto, Tipo),
    get_info(IdProduto, Tipo, Nome, Descricao),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Descricao, NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, '\n\n', NomeLinhaComQuebraDeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinhaComQuebraDeLinha, Resposta1, Resposta).

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

get_info(Id, 'filme',  Nome, Descricao) :- 
    get_filme_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'jogo',  Nome, Descricao) :- 
    get_jogo_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'serie', Nome, Descricao) :- 
    get_serie_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

prompt(Message, String) :-
    write(Message),
    flush_output,
    read_line_to_codes(user_input, Codes),
    string_codes(String, Codes).