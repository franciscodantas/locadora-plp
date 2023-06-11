%%% REGRAS PARA CLIENTES %%%
% Regra específica que busca todos os clientes do banco de dados
get_cientes(Data) :- clientes_path(Path), load_json_file(Path, Data).

% Regra que adiciona um cliente ao banco de dados
% O carrinho e o histórico de um cliente iniciam vazios por padrão
add_cliente(Id, Nome) :- add_cliente(Id, Nome, [], []).

% Sobrecarga de regra para adicionar um cliente no banco de dados quando
% o carrinho e o histórico não iniciarem vazios
add_cliente(ID, Nome, Carrinho, Historico) :- 
    Cliente = json([id=ID, nome=Nome, carrinho=Carrinho, historico=Historico]),
    clientes_path(Path),
    save_object(Path, Cliente).

% Regra para pegar um cliente por ID
get_cliente_by_id(Id, Cliente) :- clientes_path(Path), get_object_by_id(Path, Id, Cliente, 'clientes').

% Regra para remover um cliente por ID
remove_cliente_by_id(Id) :- clientes_path(Path), remove_object_by_id(Path, Id, 'clientes').

% Regra para pegar o carrinho de cliente a partir do ID do cliente
get_cliente_carrinho(Id, Carrinho) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, _, Carrinho, _).

% Regra para adicionar um produto ao carrinho de um cliente
adiciona_produto_carrinho(Id, IdElemento, IdProduto, Tipo) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    Elemento = json([id=IdElemento, idProduto=IdProduto, tipo=Tipo]),
    NewCarrinho = [Elemento | Carrinho],
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, NewCarrinho, Historico).

% Regra para remover um produto do carrinho de um cliente a partir do ID do cliente e do ID do produto
remove_produto_carrinho(Id, IdElemento) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    seach_id(Carrinho, IdElemento, Elemento, 'elemento_carrinho'),
    remove_object(Carrinho, Elemento, NewCarrinho),
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, NewCarrinho, Historico).

% Regra para pegar o histórico de um cliente a partir do ID do cliente
get_cliente_historico(Id, Historico) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, _, _, Historico).

% Regra para adicionar um produto ao histórico de um cliente
adiciona_produto_historico(Id, IdElemento, DataCompra, IdProduto, Tipo) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    Elemento = json([id=IdElemento, dataCompra=DataCompra, idProduto=IdProduto, tipo=Tipo, idCliente=Id]),
    NewHistorico = [Elemento | Historico],
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, Carrinho, NewHistorico).

% Regra para remover um produto do histórico de um cliente a partir do ID do cliente e do ID do produto
remove_produto_historico(Id, IdElemento) :-
    get_cliente_by_id(Id, Cliente),
    extract_info_clientes(Cliente, _, Nome, Carrinho, Historico),
    seach_id(Historico, IdElemento, Elemento, 'elemento_historico'),
    remove_object(Historico, Elemento, NewHistorico),
    remove_cliente_by_id(Id),
    add_cliente(Id, Nome, Carrinho, NewHistorico).
