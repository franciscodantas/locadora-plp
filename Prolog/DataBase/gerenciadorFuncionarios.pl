%%% REGRAS PARA FUNCIONÁRIOS %%%
% Regra específica que busca todos os funcionários do banco de dados
get_funcionarios(Data) :- funcionarios_path(Path), load_json_file(Path, Data).

% Regra que adiciona um funcionário ao banco de dados
add_funcionario(ID, Nome, Senha) :- 
    Funcionario = json([id=ID, nome=Nome, senha=Senha]),
    funcionarios_path(Path), 
    save_object(Path, Funcionario).

% Regra para pegar um funcionário por ID
get_funcionario_by_id(Id, Funcionario) :- funcionarios_path(Path), get_object_by_id(Path, Id, Funcionario, 'funcionarios').

% Regra para remover um funcionário por ID
remove_funcionario_by_id(Id) :- funcionarios_path(Path), remove_object_by_id(Path, Id, 'funcionarios').