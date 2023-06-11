%%% REGRAS GERAIS %%%
% Regra geral para ler um arquivo JSON do banco de dados
load_json_file(File, Data) :-
    open(File, read, Stream),
    json_read(Stream, Data),
    close(Stream).

% Regra geral salvar no banco de dados uma estrutura JSON recebida como parâmetro
save_json_file(File, Data) :-
    open(File, write, Stream),
    json_write(Stream, Data),
    close(Stream).

% Regra para adicionar um elemento a um arquivo JSON
save_object(File, Element) :- 
    load_json_file(File, Data),
    New_Data = [Element | Data],
    save_json_file(File, New_Data).

% Regras que extraem as informações das entidades já citadas do banco de dados
extract_info_produtos(json([id=Id, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=PrecoPorDia, qtdAlugueis=QtdAlugueis]), Id, Nome, Descricao, Categoria, PrecoPorDia, QtdAlugueis).
extract_info_clientes(json([id=Id, nome=Nome, carrinho=Carrinho, historico=Historico]), Id, Nome, Carrinho, Historico).
extract_info_funcionarios_gerentes(json([id=Id, nome=Nome, senha=Senha]), Id, Nome, Senha).
extract_info_historico(json([id=Id, dataCompra=DataCompra, idProduto=IdProduto, tipo=Tipo, idCliente=IdCliente]), Id, DataCompra, IdProduto, Tipo, IdCliente).
extract_info_carrinho(json([id=Id, idProduto=IdProduto, tipo=Tipo]), Id, IdProduto, Tipo).

% Regra que generalizam a extração do Id das entidades do banco de dados já citadas
% (Esse regra é importante para generalizar o uso do regra de busca por ID)
extract_id_object('produtos', Head_Object, Object_Id) :- extract_info_produtos(Head_Object, Object_Id, _, _, _, _, _).
extract_id_object('clientes', Head_Object, Object_Id) :- extract_info_clientes(Head_Object, Object_Id, _, _, _).
extract_id_object('funcionarios', Head_Object, Object_Id) :- extract_info_funcionarios_gerentes(Head_Object, Object_Id, _,_).
extract_id_object('gerentes', Head_Object, Object_Id) :- extract_info_funcionarios_gerentes(Head_Object, Object_Id, _, _).
extract_id_object('elemento_carrinho', Head_Object, Object_Id) :- extract_info_carrinho(Head_Object, Object_Id, _, _).
extract_id_object('elemento_historico', Head_Object, Object_Id) :- extract_info_historico(Head_Object, Object_Id, _, _, _, _).

% Regra geral que busca qualquer entidade por ID
% Caso a entidade não seja encontrada, -1 é retornado
seach_id([], _, -1, _) :- !. % Caso não o objeto buscado não exista, -1 é retornado
seach_id([Head_Object|Tail], Id, Object, Type) :- 
    extract_id_object(Type, Head_Object, Object_Id),
    (Object_Id = Id -> Object = Head_Object; seach_id(Tail, Id, Object, Type)).

% Regra geral que busca uma entidade por nome
% Essa regar funciona apenas para produtos: filmes, séries e jogos
seach_nome([], _, -1) :- !. % Caso não o objeto buscado não exista, -1 é retornado
seach_nome([Head_Object|Tail], Nome, Object) :- 
    extract_info_produtos(Head_Object, _, Object_Nome, _, _, _, _),
    (Object_Nome = Nome -> Object = Head_Object; seach_nome(Tail, Nome, Object)).

% Regra que generaliza a busca de entidades por id
get_object_by_id(File, Id, Object, Type) :- 
    load_json_file(File, Data),
    seach_id(Data, Id, Object, Type).

% Regra que generaliza a busca de entidade por nome
get_object_by_nome(File, Nome, Object) :- 
    load_json_file(File, Data),
    seach_nome(Data, Nome, Object).

% Regra que cria o loop da busca de todos os elemento com a categoria desejada
% Os produtos são: filmes, séries e jogos
get_objects_by_categoria_loop([], _, Lista_Atual, Lista_Atual).
get_objects_by_categoria_loop([Head_Object|Tail], Categoria, Lista_Atual, Lista_Final) :- 
    extract_info_produtos(Head_Object, _, _, _, Object_Categoria, _, _),
    (Object_Categoria = Categoria -> Nova_Lista = [Head_Object | Lista_Atual]; Nova_Lista = Lista_Atual),
    get_objects_by_categoria_loop(Tail, Categoria, Nova_Lista, Lista_Final).

% Regra busca de todos os elemento com a categoria desejada
get_objects_by_categoria(File, Categoria, Objects) :- 
    load_json_file(File, Data),
    get_objects_by_categoria_loop(Data, Categoria, [], Objects).

% Regra geral que remove um elemento de uma lista recebida
% e tem como resultado a lista sem o elemento
remove_object([], _, []).
remove_object([Header|Tail], Object, Final_Data) :-
    remove_object(Tail, Object, Data),
    (Header = Object -> Final_Data = Data ; Final_Data = [Header | Data]).

% Regra geral que unifica a remoção de objetos por ID
remove_object_by_id(File, Id, Type) :-
    load_json_file(File, Data),
    seach_id(Data, Id, Object, Type),
    remove_object(Data, Object, Final_Data),
    save_json_file(File, Final_Data).


%%% REGRAS PARA HISTÓRICO GERAL %%%
% Regra específica que busca todos os produtos do histórico geral
get_historico_geral(Data) :- historico_path(Path), load_json_file(Path, Data).

% Regra que adiciona um produto ao histórico geral
add_historico_geral(ID, DataCompra, IdProduto, Tipo, IdCliente) :- 
    HistoricoGeral = json([id=ID, dataCompra=DataCompra, idProduto=IdProduto, tipo=Tipo, idCliente=IdCliente]),
    historico_path(Path),
    save_object(Path, HistoricoGeral).

% Regra para remover um produto por ID do histórico geral
remove_historico_geral_by_id(Id) :- historico_path(Path), remove_object_by_id(Path, Id, 'elemento_historico').

