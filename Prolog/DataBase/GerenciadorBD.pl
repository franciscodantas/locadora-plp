:- use_module(library(http/json)).

%%% MÉTODOS GERAIS %%%
load_json_file(File, Data) :-
    open(File, read, Stream),
    json_read(Stream, Data),
    close(Stream).

save_json_file(File, Data) :-
    open(File, write, Stream),
    json_write(Stream, Data),
    close(Stream).

save_object(File, Element) :- 
    load_json_file(File, Data),
    New_Data = [Element | Data],
    save_json_file(File, New_Data).

extract_info_produtos(json([id=Id, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=PrecoPorDia, qtdAlugueis=QtdAlugueis]), Id, Nome, Descricao, Categoria, PrecoPorDia, QtdAlugueis).
extract_info_clientes(json([id=Id, nome=Nome, carrinho=Carrinho, historico=Historico]), Id, Nome, Carrinho, Historico).
extract_info_funcionarios_gerentes(json([identificador=Id, nome=Nome]), Id, Nome).
extract_info_historico(json([id=Id, dataCompra=DataCompra, idProduto=IdProduto, tipo=Tipo, idCliente=IdCliente]), Id, DataCompra, IdProduto, Tipo, IdCliente).
extract_info_carrinho(json([id=Id, idProduto=IdProduto, tipo=Tipo]), Id, IdProduto, Tipo).

extract_id_object('produtos', Head_Object, Object_Id) :- extract_info_produtos(Head_Object, Object_Id, _, _, _, _, _).
extract_id_object('clientes', Head_Object, Object_Id) :- extract_info_clientes(Head_Object, Object_Id, _, _, _).
extract_id_object('funcionarios', Head_Object, Object_Id) :- extract_info_funcionarios_gerentes(Head_Object, Object_Id, _).
extract_id_object('gerentes', Head_Object, Object_Id) :- extract_info_funcionarios_gerentes(Head_Object, Object_Id, _).
extract_id_object('elemento_carrinho', Head_Object, Object_Id) :- extract_info_carrinho(Head_Object, Object_Id, _, _).

seach_id([], _, -1, _) :- !. % Caso não o objeto buscado não exista, -1 é retornado
seach_id([Head_Object|Tail], Id, Object, Type) :- 
    extract_id_object(Type, Head_Object, Object_Id),
    (Object_Id = Id -> Object = Head_Object; seach_id(Tail, Id, Object, Type)).

seach_nome([], _, -1) :- !. % Caso não o objeto buscado não exista, -1 é retornado
seach_nome([Head_Object|Tail], Nome, Object) :- 
    extract_info_produtos(Head_Object, _, Object_Nome, _, _, _, _),
    (Object_Nome = Nome -> Object = Head_Object; seach_nome(Tail, Nome, Object)).

get_object_by_id(File, Id, Object, Type) :- 
    load_json_file(File, Data),
    seach_id(Data, Id, Object, Type).

get_info(Id, 'filme',  Nome, Descricao) :- 
    get_filme_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'jogo',  Nome, Descricao) :- 
    get_jogo_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'serie', Nome, Descricao) :- 
    get_serie_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_object_by_nome(File, Nome, Object) :- 
    load_json_file(File, Data),
    seach_nome(Data, Nome, Object).

remove_object([], _, []).
remove_object([Header|Tail], Object, Final_Data) :-
    remove_object(Tail, Object, Data),
    (Header = Object -> Final_Data = Data ; Final_Data = [Header | Data]).

remove_object_by_id(File, Id, Type) :-
    load_json_file(File, Data),
    seach_id(Data, Id, Object, Type),
    remove_object(Data, Object, Final_Data),
    save_json_file(File, Final_Data).

%%% REGRAS PARA FILMES %%%
get_filmes(Data) :- load_json_file('DataBase/Filme.json', Data).
add_filme(ID, Nome, Descricao, Categoria, Preco) :- 
    Filme = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=0]),
    save_object('DataBase/Filme.json', Filme).
get_filme_by_id(Id, Filme) :- get_object_by_id('DataBase/Filme.json', Id, Filme, 'produtos').
get_filme_by_nome(Nome, Filme) :- get_object_by_nome('DataBase/Filme.json', Nome, Filme).
remove_filme_by_id(Id) :- remove_object_by_id('DataBase/Filme.json', Id, 'produtos').

%%% REGRAS PARA SÉRIES %%%
get_series(Data) :- load_json_file('DataBase/Serie.json', Data).
add_serie(ID, Nome, Descricao, Categoria, Preco) :- 
    Serie = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=0]),
    save_object('DataBase/Serie.json', Serie).
get_serie_by_id(Id, Serie) :- get_object_by_id('DataBase/Serie.json', Id, Serie, 'produtos').
get_serie_by_nome(Nome, Serie) :- get_object_by_nome('DataBase/Serie.json', Nome, Serie).
remove_serie_by_id(Id) :- remove_object_by_id('DataBase/Serie.json', Id, 'produtos').

%%% REGRAS PARA JOGOS %%%
get_jogos(Data) :- load_json_file('DataBase/Jogo.json', Data).
add_jogo(ID, Nome, Descricao, Categoria, Preco) :- 
    Jogo = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=0]),
    save_object('DataBase/Jogo.json', Jogo).
get_jogo_by_id(Id, Jogo) :- get_object_by_id('DataBase/Jogo.json', Id, Jogo, 'produtos').
get_jogo_by_nome(Nome, Jogo) :- get_object_by_nome('DataBase/Jogo.json', Nome, Jogo).
remove_jogo_by_id(Id) :- remove_object_by_id('DataBase/Jogo.json', Id, 'produtos').

%%% REGRAS PARA CLIENTES %%%
get_cientes(Data) :- load_json_file('DataBase/Cliente.json', Data).
add_cliente(Id, Nome) :- add_cliente(Id, Nome, [], []).
add_cliente(ID, Nome, Carrinho, Historico) :- 
    Cliente = json([id=ID, nome=Nome, carrinho=Carrinho, historico=Historico]),
    save_object('DataBase/Cliente.json', Cliente).
get_cliente_by_id(Id, Cliente) :- get_object_by_id('DataBase/Cliente.json', Id, Cliente, 'clientes').
remove_cliente_by_id(Id) :- remove_object_by_id('DataBase/Cliente.json', Id, 'clientes').
get_cliente_carrinho(Id, Carrinho) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _).
adiciona_produto_carrinho(Id, IdElemento, IdProduto, Tipo) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    Elemento = json([id=IdElemento, idProduto=IdProduto, tipo=Tipo]),
    NewCarrinho = [Elemento | Carrinho],
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, NewCarrinho, Historico).
remove_produto_carrinho(Id, IdElemento) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    seach_id(Carrinho, IdElemento, Elemento, 'elemento_carrinho'),
    remove_object(Carrinho, Elemento, NewCarrinho),
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, NewCarrinho, Historico).
get_cliente_historico(Id, Historico) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, _, _, Historico).
adiciona_produto_historico(Id, IdElemento, DataCompra, IdProduto, Tipo) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    Elemento = json([id=IdElemento, dataCompra=DataCompra, idProduto=IdProduto, tipo=Tipo, idCliente=Id]),
    NewHistorico = [Elemento | Historico],
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, Carrinho, NewHistorico).

%%% REGRAS PARA FUNCIONÁRIOS %%%
get_funcionarios(Data) :- load_json_file('DataBase/Funcionario.json', Data).
add_funcionario(ID, Nome) :- 
    Funcionario = json([id=ID, nome=Nome]),
    save_object('DataBase/Funcionario.json', Funcionario).
get_funcionario_by_id(Id, Funcionario) :- get_object_by_id('DataBase/Funcionario.json', Id, Funcionario, 'funcionarios').
remove_funcionario_by_id(Id) :- remove_object_by_id('DataBase/Funcionario.json', Id, 'funcionarios').

%%% REGRAS PARA GERENTE %%%
get_gerentes(Data) :- load_json_file('DataBase/Gerente.json', Data).
add_gerentes(ID, Nome) :- 
    Gerente = json([id=ID, nome=Nome]),
    save_object('DataBase/Gerente.json', Gerente).
get_gerente_by_id(Id, Gerente) :- get_object_by_id('DataBase/Gerente.json', Id, Gerente, 'gerentes').
