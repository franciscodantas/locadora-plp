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

/* As regras get_produto_em_destaque e seleciona_aluguel_destaque são
responsáveis por selecionar o produto em detaque positivo ou negativo
em relação ao aluguel. O produto com maior número de alugueis
pode ser obtido passando o átomo 'mais_alugado' para as regras.
Já o produto com menor número de alugueis pode ser obtido 
passando o átomo 'menos_alugado' para as regras */
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

/* Essa regra é responsável por pegar 'n' produtos em destaque.
O destaque pode ser os 'n' produtos mais alugados ou os 'n' produtos
menos alugados */
get_n_destaques(_, 0, _, Destaques_Atuais, Destaques_Atuais_Dec) :- reverse(Destaques_Atuais, Destaques_Atuais_Dec).
get_n_destaques([], _, _, Destaques_Atuais, Destaques_Atuais_Dec) :- reverse(Destaques_Atuais, Destaques_Atuais_Dec).
get_n_destaques(Produtos, N, Tipo_Destaque, Destaques_Atuais, Destaques_Finais) :- 
    [Primeiro_Produto | _] = Produtos,
    get_produto_em_destaque(Produtos, Tipo_Destaque, Primeiro_Produto, Destaque),
    Novos_Destaques = [Destaque | Destaques_Atuais],
    remove_object(Produtos, Destaque, Novos_Produtos),
    Novo_N is N - 1,
    get_n_destaques(Novos_Produtos, Novo_N, Tipo_Destaque, Novos_Destaques, Destaques_Finais).

get_produto_by_tipo(IdProduto, Produto, 'filme') :- get_filme_by_id(IdProduto, Produto).
get_produto_by_tipo(IdProduto, Produto, 'serie') :- get_serie_by_id(IdProduto, Produto).
get_produto_by_tipo(IdProduto, Produto, 'jogo') :- get_jogo_by_id(IdProduto, Produto).