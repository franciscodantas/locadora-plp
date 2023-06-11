%%% REGRAS PARA GERENTE %%%
% Regra específica que busca todos os gerentes do banco de dados
get_gerentes(Data) :- gerentes_path(Path), load_json_file(Path, Data).

% Regra que adiciona um gerente ao banco de dados
add_gerentes(ID, Nome) :- 
    Gerente = json([id=ID, nome=Nome]),
    gerentes_path(Path),
    save_object(Path, Gerente).

% Regra para pegar um gerente por ID
get_gerente_by_id(Id, Gerente) :- gerentes_path(Path), get_object_by_id(Path, Id, Gerente, 'gerentes').

% Regra para remover um gerente por ID
remove_gerente_by_id(Id) :- gerentes_path(Path), remove_object_by_id(Path, Id, 'gerentes').
