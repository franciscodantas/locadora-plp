:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% Regra que aluga um filme para um cliente a partir do ID do cliente e do nome do filme
% Essa regra é utilizada para o aluguel por dias
alugaFilme(ID, NomeFilme, 1):-
    prompt('Quantidade de dias: ', Dias),
    number_string(DiasNum, Dias),
    valida_valor_negativo(Dias),
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

% Regra que aluga um filme para um cliente a partir do ID do cliente e do nome do filme
% Essa regra é utilizada para o aluguel por semanas
alugaFilme(ID, NomeFilme, 2):-
    prompt('Quantidade de semanas: ', Semanas),
    valida_valor_negativo(Semanas),
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

% Regra que valida o aluguel de um filme
alugaFilme(_, _, _) :- write('Valores inválidos'), !.

% Regra que aluga uma série para um cliente a partir do ID do cliente e do nome da série
% Essa regra é utilizada para o aluguel por dias
alugaSerie(ID, NomeSerie, 1):-
    prompt('Quantidade de dias: ', Dias),
    number_string(DiasNum, Dias),
    valida_valor_negativo(Dias),
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

% Regra que aluga uma série para um cliente a partir do ID do cliente e do nome da série
% Essa regra é utilizada para o aluguel por semanas
alugaSerie(ID, NomeSerie, 2):-
    prompt('Quantidade de semanas: ', Semanas),
    valida_valor_negativo(Semanas),
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

% Regra que valida o aluguel de uma série
alugaSerie(_, _, _) :- write('Valores inválidos'), !.

% Regra que aluga um jogo para um cliente a partir do ID do cliente e do nome do jogo
% Essa regra é utilizada para o aluguel por dias
alugaJogo(ID, NomeJogo, 1):-
    prompt('Quantidade de dias: ', Dias),
    valida_valor_negativo(Dias),
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

% Regra que aluga um jogo para um cliente a partir do ID do cliente e do nome do jogo
% Essa regra é utilizada para o aluguel por semanas
alugaJogo(ID, NomeJogo, 2):-
    prompt('Quantidade de semanas: ', Semanas),
    valida_valor_negativo(Semanas),
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

% Regra que valida o aluguel de um jogo
alugaJogo(_, _, _) :- write('Valores inválidos'), !.

% Regra que busca os filmes por categoria
% Exemplos de categorias são: Acao, Romance, Aventura
produtoPorCategoria(1) :-
    prompt('Categoria: ', Categoria),
    valida_valor_espacos(Categoria),
    atom_string(CatAtom, Categoria),
    filmes_path(Path),
    get_objects_by_categoria(Path, CatAtom, Filmes),
    organizaListagemProdutos(Filmes, FilmesListagem),
    write(FilmesListagem).

% Regra que busca as séries por categoria
% Exemplos de categorias são: Acao, Romance, Aventura
produtoPorCategoria(2) :-
    prompt('Categoria: ', Categoria),
    valida_valor_espacos(Categoria),
    atom_string(CatAtom, Categoria),
    series_path(Path),
    get_objects_by_categoria(Path, CatAtom, Series),
    organizaListagemProdutos(Series, SeriesListagem),
    write(SeriesListagem).

% Regra que busca os jogos por categoria
% Exemplos de categorias são: Acao, Romance, Aventura
produtoPorCategoria(3) :-
    prompt('Categoria: ', Categoria),
    valida_valor_espacos(Categoria),
    atom_string(CatAtom, Categoria),
    jogos_path(Path),
    get_objects_by_categoria(Path, CatAtom, Jogos),
    organizaListagemProdutos(Jogos, JogosListagem),
    write(JogosListagem).

% Regra que adiciona um filme ao carrinho de um cliente a partir do ID do cliente
addFilmeCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_filme_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'filme'),
    format('~s adicionado ao carrinho.', [Nome]).

% Regra que adiciona um jogo ao carrinho de um cliente a partir do ID do cliente
addJogoCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_jogo_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'jogo'),
    format('~s adicionado ao carrinho.', [Nome]).

% Regra que adiciona uma série ao carrinho de um cliente a partir do ID do cliente
addSerieCarrinho(Id, Nome) :-
    random_id(IdElemento),
    atom_string(IDAtom, Id),
    atom_string(NomeAtom, Nome),
    get_serie_by_nome(NomeAtom, Prod),
    extract_id_object('produtos', Prod, IdProduto),
    adiciona_produto_carrinho(IDAtom, IdElemento, IdProduto, 'serie'),
    format('~s adicionado ao carrinho.', [Nome]).

% Regra que remove um produto do carrinho de um cliente a partir do ID do cliente e do nome do produto
removeDoCarrinhoTipo(Id, Nome) :-
    atom_string(NomeAtom, Nome),
    get_filme_by_nome(NomeAtom, Filme),
    get_serie_by_nome(NomeAtom, Serie),
    get_jogo_by_nome(NomeAtom, Jogo),
    (Filme \= -1 -> removeCarrinho(Id, Filme);
    Serie \= -1 -> removeCarrinho(Id, Serie);
    Jogo \= -1 -> removeCarrinho(Id, Jogo)).

% Regra que organiza a remoção de elemento do carrinho de um cliente
removeCarrinho(Id, Produto) :-
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _),
    extract_id_object('produtos', Produto, IdProduto),
    removeCarrinhoLoop(Carrinho, IdProduto, IDAtom).

% Regra com o loop para encontrar e remove um produto do carrinho de um cliente
% A remoção é feita comparando os IDs dos produtos
removeCarrinhoLoop([], _, _) :- write('Produto não está no carrinho.').
removeCarrinhoLoop([H|T], IdProduto, IdCliente) :-
    extract_info_carrinho(H, IdElemento, ProdId, _),
    (IdProduto = ProdId -> remove_produto_carrinho(IdCliente, IdElemento), write('Produto removido.');
    removeCarrinhoLoop(T, IdProduto, IdCliente)).

% Regra que exibe o carrinho de um cliente a partir do ID do cliente
exibeCarrinho(Id, Resposta) :-
    atom_string(IDAtom, Id),
    get_cliente_carrinho(IDAtom, Carrinho),
    organizaListagemCarrinho(Carrinho, Resposta).

% Regra que aluga o carrinho de um cliente por dias
alugaCarrinho(Id, 1) :- 
    prompt('Quantidade de dias: ', Dias),
    valida_valor_negativo(Dias),
    number_string(DiasNum, Dias),
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _),
    alugaCarrinhoLoop(IDAtom, Carrinho, 0, Total),
    format('Produtos alugados por ~2f reais.', [Total * DiasNum]).

% Regra que aluga o carrinho de um cliente por semanas
alugaCarrinho(Id, 2) :- 
    prompt('Quantidade de semanas: ', Semanas),
    valida_valor_negativo(Semanas),
    number_string(SemanasNum, Semanas),
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _),
    alugaCarrinhoLoop(IDAtom, Carrinho, 0, Total),
    format('Produtos alugados por ~2f reais.', [Total * SemanasNum * 7]).

% Regra com o loop para alugar todos os produtos do carrinho de um cliente
% O aluguel remove os produtos do carrinho e adiciona eles no histórico
alugaCarrinhoLoop(_, [], Total, Total).
alugaCarrinhoLoop(IdCliente, [H|T], Preco, Total) :-
    extract_info_carrinho(H, IdCarrinho, IdProduto, Tipo),
    alugaProdutoId(IdProduto, Tipo, PrecoPorDia, IdCliente),
    remove_produto_carrinho(IdCliente, IdCarrinho),
    Preco2 = PrecoPorDia + Preco,
    alugaCarrinhoLoop(IdCliente, T, Preco2, Total).

% Regra que faz o aluguel de um filme do cliente a partir das informações do filme e do ID do cliente
alugaProdutoId(Id, 'filme', PrecoPorDia, IdCliente) :-
    get_filme_by_id(Id, Filme),
    extract_info_produtos(Filme, _, _, _, _, PrecoPorDia, _),
    random_id(IdElemento),
    data_atual(DataCompra),
    adiciona_produto_historico(IdCliente, IdElemento, DataCompra, Id, 'filme'),
    incrementa_qtd_alugueis_filmes(Id).

% Regra que faz o aluguel de uma série do cliente a partir das informações da série e do ID do cliente
alugaProdutoId(Id, 'serie', PrecoPorDia, IdCliente) :-
    get_serie_by_id(Id, Serie),
    extract_info_produtos(Serie, _, _, _, _, PrecoPorDia, _),
    random_id(IdElemento),
    data_atual(DataCompra),
    adiciona_produto_historico(IdCliente, IdElemento, DataCompra, Id, 'serie'),
    incrementa_qtd_alugueis_series(Id).

% Regra que faz o aluguel de um jogo do cliente a partir das informações do jogo e do ID do cliente
alugaProdutoId(Id, 'jogo', PrecoPorDia, IdCliente) :-
    get_jogo_by_id(Id, Jogo),
    extract_info_produtos(Jogo, _, _, _, _, PrecoPorDia, _),
    random_id(IdElemento),
    data_atual(DataCompra),
    adiciona_produto_historico(IdCliente, IdElemento, DataCompra, Id, 'jogo'),
    incrementa_qtd_alugueis_jogos(Id).

% Regra que obtém as recomendações para um cliente a partir do ID desse cliente
get_recomendacoes(ID, Opc, Resposta) :- 
    atom_string(IDAtom, ID),
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
    get_jogos(Produtos),
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
        get_recomendacoes_gerais(1, Resposta);
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
get_recomendacoes_especificas(3, Historico, Resposta) :- 
    getProdTipoHistorico(Historico, [], HisJogos, 'jogo'),
    listaCategorias(HisJogos, [], Categorias),
    get_jogos(TodosJogos),
    listaNuncaAlugados(HisJogos, TodosJogos, [], NuncaAlugados),
    listaRecs(Categorias, NuncaAlugados, [], Recs),
    get_n_destaques(Recs, 3, 'mais_alugado', [], R),
    length(R, LenHist),
    (LenHist = 0 -> 
        get_recomendacoes_gerais(3, Resposta);
        organizaListagemProdutos(R, Resposta)).

% Regra que exibe o histórico de um cliente a partir do ID desse cliente
exibeHistorico(Id, Resposta) :-
    atom_string(IDAtom, Id),
    get_cliente_by_id(IDAtom, Cliente),
    extract_info_clientes(Cliente, _, _, _, Historico),
    organizaListagemHistorico(Historico, Resposta).

% Regra que pega os produtos de um determinado tipo do histórico
% Os tipos possíveis são: filmes, séries e jogos
getProdTipoHistorico([], Res, Res, _).
getProdTipoHistorico([H|T], Lista, Res, Tipo) :-
    extract_info_historico(H, _, _, IdProduto, TipoProduto, _),
    (Tipo = TipoProduto -> 
        get_produto_by_tipo(IdProduto, Produto, Tipo),
        add(Produto, Lista, NovaLista),
        getProdTipoHistorico(T, NovaLista, Res, Tipo);
        getProdTipoHistorico(T, Lista, Res, Tipo)).

% Regra que pega os produtos ainda não alugados
listaNuncaAlugados(_, [], Res, Res).
listaNuncaAlugados(ProdutosAlugados, [H|T], Lista, Res) :-
    (member(H, ProdutosAlugados) ->
        listaNuncaAlugados(ProdutosAlugados, T, Lista, Res);
        add(H, Lista, NovaLista),
        listaNuncaAlugados(ProdutosAlugados, T, NovaLista, Res)).

% Regra que lista as categorias possíveis do sistema
listaCategorias([], Res, Res).
listaCategorias([H|T], Lista, Res) :-
    extract_info_produtos(H, _, _, _, Categoria, _, _),
    add(Categoria, Lista, NovaLista),
    listaCategorias(T, NovaLista, Res).

% Regra que filtra uma lista de produtos com base em categorias desejadas,
% retornando uma nova lista com os produtos correspondentes
listaRecs(_, [], Res, Res).
listaRecs(Categorias, [H|T], Lista, Res) :-
    extract_info_produtos(H, _, _, _, Cat, _, _),
    (member(Cat, Categorias) -> 
        add(H, Lista, NovaLista),
        listaRecs(Categorias, T, NovaLista, Res);
        listaRecs(Categorias, T, Lista, Res)).

% Regra que pega a data atual
data_atual(Data) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    format_time(atom(Data), '%Y-%m-%d', DateTime).

% Regra que gera um ID aleatório
random_id(ID) :-
    random_between(100000000, 999999999, RandomNumber),
    number_codes(RandomNumber, RandomNumberCodes),
    string_codes(ID, RandomNumberCodes).

% Regra que valida um cliente, verificando se ele existe no sistema
valida_cliente(ID) :- 
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1.
valida_cliente(_) :- write('Cliente não cadastrado.'), cliente.

% Regra recursiva que adiciona um elemento no final de uma lista
add(E, [], [E]).
add(E, [H|T], [H|R]) :-
    add(E, T, R).
