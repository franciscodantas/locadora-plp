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
    atom_string(NomeFilmeAtom, NomeFilme),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_filme_by_nome(NomeFilmeAtom, Filme),
    extract_info_produtos(Filme, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'filme'),
    incrementa_qtd_alugueis_filmes(IDAtom),
    Valor = PrecoPorDia * Dias,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeFilme, Valor]).

alugaFilme(ID, NomeFilme, 2):-
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    atom_string(NomeFilmeAtom, NomeFilme),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_filme_by_nome(NomeFilmeAtom, Filme),
    extract_info_produtos(Filme, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'filme'),
    incrementa_qtd_alugueis_filmes(IDAtom),
    Valor = PrecoPorDia * Semanas * 7,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeFilme, Valor]).

alugaSerie(ID, NomeSerie, 1):-
    prompt('', _),
    prompt('Quantidade de dias: ', Dias),
    atom_string(NomeSerieAtom, NomeSerie),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_serie_by_nome(NomeSerieAtom, Serie),
    extract_info_produtos(Serie, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'serie'),
    incrementa_qtd_alugueis_series(IDAtom),
    Valor = PrecoPorDia * Dias,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeSerie, Valor]).

alugaSerie(ID, NomeSerie, 2):-
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    atom_string(NomeSerieAtom, NomeSerie),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_serie_by_nome(NomeSerieAtom, Serie),
    extract_info_produtos(Serie, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'jogo'),
    incrementa_qtd_alugueis_series(IDAtom),
    Valor = PrecoPorDia * Semanas * 7,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeSerie, Valor]).

alugaJogo(ID, NomeJogo, 1):-
    prompt('', _),
    prompt('Quantidade de dias: ', Dias),
    atom_string(NomeJogoAtom, NomeJogo),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_jogo_by_nome(NomeJogoAtom, Jogo),
    extract_info_produtos(Jogo, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'jogo'),
    incrementa_qtd_alugueis_jogos(IDAtom),
    Valor = PrecoPorDia * Dias,
    format('Aluguel de ~s realizado por ~2f reais.', [NomeJogo, Valor]).

alugaJogo(ID, NomeJogo, 2):-
    prompt('', _),
    prompt('Quantidade de semanas: ', Semanas),
    atom_string(NomeJogoAtom, NomeJogo),
    atom_string(IDAtom, ID),
    data_atual(DataCompra),
    random_id(IdElemento),
    get_jogo_by_nome(NomeJogoAtom, Jogo),
    extract_info_produtos(Jogo, IdProduto, _, _, _, PrecoPorDia, _),
    adiciona_produto_historico(IDAtom, IdElemento, DataCompra, IdProduto, 'jogo'),
    incrementa_qtd_alugueis_jogos(IDAtom),
    Valor = PrecoPorDia * Semanas * 7,
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
    get_filme_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'jogo'),
    format('~s adicionado ao carrinho.', [Nome]).

addSerieCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_filme_by_nome(NomeAtom, Prod),
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

exibeHistorico(Id, Resposta) :-
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    extract_info_clientes(Cliente, _, Nome, _, Historico),
    organizaListagemHistorico(Historico, Resposta).

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

add(E, [], [E]).
add(E, [H|T], [H|R]) :-
    add(E, T, R).