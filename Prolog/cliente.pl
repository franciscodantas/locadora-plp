:- use_module(library(http/json)).
:- import('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).
:- use_module(library(date)).
:- use_module(library(random)).

alugaFilme(ID, NomeFilme, 1):-
    prompt('', _),
    prompt('Quantidade de dias: ', Dias),
    number_string(DiasNum, Dias),
    atom_string(NomeFilmeAtom, NomeFilme),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_filme_by_nome(NomeFilmeAtom, Filme),
    extract_info_produtos(Filme, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'filme'),
    incrementa_qtd_alugueis_filmes(IdProduto),
    Valor is PrecoPorDia * DiasNum,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeFilme, Valor]).

alugaFilme(ID, NomeFilme, 2):-
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    number_string(SemanasNum, Semanas),
    atom_string(NomeFilmeAtom, NomeFilme),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_filme_by_nome(NomeFilmeAtom, Filme),
    extract_info_produtos(Filme, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'filme'),
    incrementa_qtd_alugueis_filmes(IdProduto),
    Valor = PrecoPorDia * SemanasNum * 7,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeFilme, Valor]).

alugaSerie(ID, NomeSerie, 1):-
    prompt('', _),
    prompt('Quantidade de dias: ', Dias),
    number_string(DiasNum, Dias),
    atom_string(NomeSerieAtom, NomeSerie),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_serie_by_nome(NomeSerieAtom, Serie),
    extract_info_produtos(Serie, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'serie'),
    incrementa_qtd_alugueis_series(IdProduto),
    Valor = PrecoPorDia * DiasNum,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeSerie, Valor]).

alugaSerie(ID, NomeSerie, 2):-
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    number_string(SemanasNum, Semanas),
    atom_string(NomeSerieAtom, NomeSerie),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_serie_by_nome(NomeSerieAtom, Serie),
    extract_info_produtos(Serie, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'jogo'),
    incrementa_qtd_alugueis_series(IdProduto),
    Valor = PrecoPorDia * SemanasNum * 7,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeSerie, Valor]).

alugaJogo(ID, NomeJogo, 1):-
    prompt('', _),
    prompt('Quantidade de dias: ', Dias),
    number_string(DiasNum, Dias),
    atom_string(NomeJogoAtom, NomeJogo),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_jogo_by_nome(NomeJogoAtom, Jogo),
    extract_info_produtos(Jogo, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'jogo'),
    incrementa_qtd_alugueis_jogos(IdProduto),
    Valor = PrecoPorDia * DiasNum,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeJogo, Valor]).

alugaJogo(ID, NomeJogo, 2):-
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    number_string(SemanasNum, Semanas),
    atom_string(NomeJogoAtom, NomeJogo),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_jogo_by_nome(NomeJogoAtom, Jogo),
    extract_info_produtos(Jogo, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'jogo'),
    incrementa_qtd_alugueis_jogos(IdProduto),
    Valor = PrecoPorDia * SemanasNum * 7,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeJogo, Valor]).

produtoPorCategoria(1) :-
    prompt('', _),
    prompt('Categoria: ', Categoria),
    atom_string(CatAtom, Categoria),
    get_objects_by_categoria('DataBase/Filme.json', CatAtom, Filmes),
    organizaListagemProdutos(Filmes, FilmesListagem),
    write(FilmesListagem).

produtoPorCategoria(2) :-
    prompt('', _),
    prompt('Categoria: ', Categoria),
    atom_string(CatAtom, Categoria),
    get_objects_by_categoria('DataBase/Serie.json', CatAtom, Series),
    organizaListagemProdutos(Series, SeriesListagem),
    write(SeriesListagem).

produtoPorCategoria(3) :-
    prompt('', _),
    prompt('Categoria: ', Categoria),
    atom_string(CatAtom, Categoria),
    get_objects_by_categoria('DataBase/Jogo.json', CatAtom, Jogos),
    organizaListagemProdutos(Jogos, JogosListagem),
    write(JogosListagem).

addFilmeCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_filme_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'filme'),
    format('~s adicionado ao carrinho.', [Nome]).

addJogoCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_jogo_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'jogo'),
    format('~s adicionado ao carrinho.', [Nome]).

addSerieCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_serie_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'serie'),
    format('~s adicionado ao carrinho.', [Nome]).

removeDoCarrinhoTipo(Id, Nome) :-
    atom_string(NomeAtom, Nome),
    get_filme_by_nome(NomeAtom, Filme),
    get_serie_by_nome(NomeAtom, Serie),
    get_jogo_by_nome(NomeAtom, Jogo),
    (Filme \= -1 -> removeCarrinho(Id, Filme);
    Serie \= -1 -> removeCarrinho(Id, Serie);
    Jogo \= -1 -> removeCarrinho(Id, Jogo)).

removeCarrinho(Id, Produto) :-
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _),
    extract_id_object('produtos', Produto, IdProduto),
    removeCarrinhoLoop(Carrinho, IdProduto, IDAtom).

removeCarrinhoLoop([], _, _) :- write('Produto não está no carrinho.').
removeCarrinhoLoop([H|T], IdProduto, IdCliente) :-
    extract_info_carrinho(H, IdElemento, ProdId, _),
    (IdProduto = ProdId -> remove_produto_carrinho(IdCliente, IdElemento), write('Produto removido.');
    removeCarrinhoLoop(T, IdProduto, IdCliente)).

exibeCarrinho(Id, Resposta) :-
    atom_string(IDAtom, Id),
    get_cliente_carrinho(IDAtom, Carrinho),
    organizaListagemCarrinho(Carrinho, Resposta).

alugaCarrinho(Id, 1) :- 
    prompt('', _),
    prompt('Quantidade de dias: ', Dias),
    number_string(DiasNum, Dias),
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _),
    alugaCarrinhoLoop(IDAtom, Carrinho, 0, Total),
    format('Produtos alugados por ~2f reais.', [Total * DiasNum]).

alugaCarrinho(Id, 2) :- 
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    number_string(SemanasNum, Semanas),
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _),
    alugaCarrinhoLoop(IDAtom, Carrinho, 0, Total),
    format('Produtos alugados por ~2f reais.', [Total * SemanasNum * 7]).

alugaCarrinhoLoop(_, [], Total, Total).
alugaCarrinhoLoop(IdCliente, [H|T], Preco, Total) :-
    extract_info_carrinho(H, IdCarrinho, IdProduto, Tipo),
    alugaProdutoId(IdProduto, Tipo, PrecoPorDia, IdCliente),
    remove_produto_carrinho(IdCliente, IdCarrinho),
    Preco2 = PrecoPorDia + Preco,
    alugaCarrinhoLoop(IdCliente, T, Preco2, Total).

alugaProdutoId(Id, 'filme', PrecoPorDia, IdCliente) :-
    get_filme_by_id(Id, Filme),
    extract_info_produtos(Filme, _, _, _, _, PrecoPorDia, _),
    random_id(IdElemento),
    data_atual(DataCompra),
    adiciona_produto_historico(IdCliente, IdElemento, DataCompra, Id, 'filme'),
    incrementa_qtd_alugueis_filmes(Id).

alugaProdutoId(Id, 'serie', PrecoPorDia, IdCliente) :-
    get_serie_by_id(Id, Serie),
    extract_info_produtos(Serie, _, _, _, _, PrecoPorDia, _),
    random_id(IdElemento),
    data_atual(DataCompra),
    adiciona_produto_historico(IdCliente, IdElemento, DataCompra, Id, 'serie'),
    incrementa_qtd_alugueis_series(Id).

alugaProdutoId(Id, 'jogo', PrecoPorDia, IdCliente) :-
    get_jogo_by_id(Id, Jogo),
    extract_info_produtos(Jogo, _, _, _, _, PrecoPorDia, _),
    random_id(IdElemento),
    data_atual(DataCompra),
    adiciona_produto_historico(IdCliente, IdElemento, DataCompra, Id, 'jogo'),
    incrementa_qtd_alugueis_jogos(Id).

get_recomendacoes(ID, Opc, Resposta) :- 
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    get_cliente_historico(IDAtom, Historico),
    length(Historico, LenHist),
    (LenHist = 0 -> get_recomendacoes_gerais(Opc, Resposta); get_recomendacoes_especificas(Opc, Historico, Resposta)).

% Recomendações de filmes
get_recomendacoes_gerais(1, Resposta) :- 
    get_filmes(Produtos),
    get_n_destaques(Produtos, 3, 'mais_alugado', [], R),
    organizaListagemProdutos(R, Resposta).

% Recomendações de series
get_recomendacoes_gerais(2, Resposta) :- 
    get_series(Produtos),
    get_n_destaques(Produtos, 3, 'mais_alugado', [], R),
    organizaListagemProdutos(R, Resposta).

% Recomendações de jogos
get_recomendacoes_gerais(3, Resposta) :- 
    get_series(Produtos),
    get_n_destaques(Produtos, 3, 'mais_alugado', [], R),
    organizaListagemProdutos(R, Resposta).

% Recomendações de filmes
get_recomendacoes_especificas(1, Historico, Resposta) :- 
    getProdTipoHistorico(Historico, [], HisFilmes, 'filme'), % Lista com todos os filmes que o cliente viu
    listaCategorias(HisFilmes, [], Categorias), % Lista com as categorias dos filmes que o cliente viu
    get_filmes(TodosFilmes), % Todos os filmes
    listaNuncaAlugados(HisFilmes, TodosFilmes, [], NuncaAlugados), % Todos os filmes que o cliente não viu
    listaRecs(Categorias, NuncaAlugados, [], Recs), % Filmes que o cliente não viu e são das categorias que o cliente mostrou interesse
    get_n_destaques(Recs, 3, 'mais_alugado', [], R), % 3 mais alugados da lista anterior 
    length(R, LenHist),
    (LenHist = 0 -> 
        get_recomendacoes_gerais(2, Resposta);
        organizaListagemProdutos(R, Resposta)).

% Próximos predicados de recomendação seguem a mesma lógica do anterior.
% Recomendações de séries
get_recomendacoes_especificas(2, Historico, Resposta) :- 
    getProdTipoHistorico(Historico, [], HisSeries, 'serie'),
    listaCategorias(HisSeries, [], Categorias),
    get_series(TodasSeries),
    listaNuncaAlugados(HisSeries, TodasSeries, [], NuncaAlugados),
    listaRecs(Categorias, NuncaAlugados, [], Recs),
    get_n_destaques(Recs, 3, 'mais_alugado', [], R),
    length(R, LenHist),
    (LenHist = 0 -> 
        get_recomendacoes_gerais(2, Resposta);
        organizaListagemProdutos(R, Resposta)).

% Recomendações de jogos
get_recomendacoes_especificas(2, Historico, Resposta) :- 
    getProdTipoHistorico(Historico, [], HisJogos, 'jogo'),
    listaCategorias(HisJogos, [], Categorias),
    get_jogos(TodosJogos),
    listaNuncaAlugados(HisJogos, TodasSeries, [], NuncaAlugados),
    listaRecs(Categorias, NuncaAlugados, [], Recs),
    get_n_destaques(Recs, 3, 'mais_alugado', [], R),
    length(R, LenHist),
    (LenHist = 0 -> 
        get_recomendacoes_gerais(2, Resposta);
        organizaListagemProdutos(R, Resposta)).

exibeHistorico(Id, Resposta) :-
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, _, Historico),
    organizaListagemHistorico(Historico, Resposta).


getProdTipoHistorico([], Res, Res, _).
getProdTipoHistorico([H|T], Lista, Res, Tipo) :-
    extract_info_historico(H, _, _, IdProduto, TipoProduto, _),
    (Tipo = TipoProduto -> 
        get_produto_by_tipo(IdProduto, Produto, Tipo),
        add(Produto, Lista, NovaLista),
        getProdTipoHistorico(T, NovaLista, Res, Tipo);
        getProdTipoHistorico(T, Lista, Res, Tipo)).

listaNuncaAlugados(_, [], Res, Res).
listaNuncaAlugados(ProdutosAlugados, [H|T], Lista, Res) :-
    (member(H, ProdutosAlugados) ->
        listaNuncaAlugados(ProdutosAlugados, T, Lista, Res);
        add(H, Lista, NovaLista),
        listaNuncaAlugados(ProdutosAlugados, T, NovaLista, Res)).

listaCategorias([], Res, Res).
listaCategorias([H|T], Lista, Res) :-
    extract_info_produtos(H, _, _, _, Categoria, _, _),
    add(Categoria, Lista, NovaLista),
    listaCategorias(T, NovaLista, Res).

listaRecs(_, [], Res, Res).
listaRecs(Categorias, [H|T], Lista, Res) :-
    extract_info_produtos(H, _, _, _, Cat, _, _),
    (member(Cat, Categorias) -> 
        add(H, Lista, NovaLista),
        listaRecs(Categorias, T, NovaLista, Res);
        listaRecs(Categorias, T, Lista, Res)).
    

data_atual(Data) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    format_time(atom(Data), '%Y-%m-%d', DateTime).

random_id(ID) :-
    random_between(100000000, 999999999, RandomNumber),
    number_codes(RandomNumber, RandomNumberCodes),
    string_codes(ID, RandomNumberCodes).

valida_cliente(ID) :- 
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1.
valida_cliente(_) :- write('Cliente não cadastrado.'), cliente.

add(E, [], [E]).
add(E, [H|T], [H|R]) :-
    add(E, T, R).