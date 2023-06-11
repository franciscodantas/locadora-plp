%%% REGRAS PARA FILMES %%%
% Regra específica que busca todos os filmes do banco de dados
get_filmes(Data) :- filmes_path(Path), load_json_file(Path, Data).

% Regra que adiciona um filme ao banco de dados
% A quantidade de aluguéis é padronizada para 0 quando um filme é cadastrado
add_filme(ID, Nome, Descricao, Categoria, Preco) :- 
    Filme = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=0]),
    filmes_path(Path), 
    save_object(Path, Filme).

% Sobrecarga de regra para adicionar um filme no banco de dados quando
% a quantidade de aluguéis não é 0
add_filme(ID, Nome, Descricao, Categoria, Preco, QtdAlugueis) :- 
    Filme = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=QtdAlugueis]),
    filmes_path(Path), 
    save_object(Path, Filme).

% Regra para pegar um filme por ID
get_filme_by_id(Id, Filme) :- filmes_path(Path), get_object_by_id(Path, Id, Filme, 'produtos').

% Regra para pegar um filme por nome
get_filme_by_nome(Nome, Filme) :- filmes_path(Path), get_object_by_nome(Path, Nome, Filme).

% Regra para remover um filme por ID
remove_filme_by_id(Id) :- filmes_path(Path), remove_object_by_id(Path, Id, 'produtos').

% Regra para incrementar a quantidade de aluguéis de um filme
incrementa_qtd_alugueis_filmes(Id) :- 
    get_filme_by_id(Id, Filme),
    extract_info_produtos(Filme, _, Nome, Descricao, Categoria, PrecoPorDia, QtdAlugueis),
    Nova_QtsAlugueis is QtdAlugueis + 1,
    remove_filme_by_id(Id),
    add_filme(Id, Nome, Descricao, Categoria, PrecoPorDia, Nova_QtsAlugueis).


%%% REGRAS PARA SÉRIES %%%
% Regra específica que busca todas as séries do banco de dados
get_series(Data) :- series_path(Path), load_json_file(Path, Data).

% Regra que adiciona uma série ao banco de dados
% A quantidade de aluguéis é padronizada para 0 quando uma série é cadastrado
add_serie(ID, Nome, Descricao, Categoria, Preco) :- 
    Serie = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=0]),
    series_path(Path),
    save_object(Path, Serie).

% Sobrecarga de regra para adicionar uma série no banco de dados quando
% a quantidade de aluguéis não é 0
add_serie(ID, Nome, Descricao, Categoria, Preco, QtdAlugueis) :- 
    Serie = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=QtdAlugueis]),
    series_path(Path),
    save_object(Path, Serie).

% Regra para pegar uma série por ID
get_serie_by_id(Id, Serie) :- series_path(Path), get_object_by_id(Path, Id, Serie, 'produtos').

% Regra para pegar uma série por nome
get_serie_by_nome(Nome, Serie) :- series_path(Path), get_object_by_nome(Path, Nome, Serie).

% Regra para remover uma série por ID
remove_serie_by_id(Id) :- series_path(Path), remove_object_by_id(Path, Id, 'produtos').

% Regra para incrementar a quantidade de aluguéis de uma série
incrementa_qtd_alugueis_series(Id) :- 
    get_serie_by_id(Id, Serie),
    extract_info_produtos(Serie, _, Nome, Descricao, Categoria, PrecoPorDia, QtdAlugueis),
    Nova_QtsAlugueis is QtdAlugueis + 1,
    remove_serie_by_id(Id),
    add_serie(Id, Nome, Descricao, Categoria, PrecoPorDia, Nova_QtsAlugueis).


%%% REGRAS PARA JOGOS %%%
% Regra específica que busca todos os jogos do banco de dados
get_jogos(Data) :- jogos_path(Path), load_json_file(Path, Data).

% Regra que adiciona um jogo ao banco de dados
% A quantidade de aluguéis é padronizada para 0 quando um jogo é cadastrado
add_jogo(ID, Nome, Descricao, Categoria, Preco) :- 
    Jogo = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=0]),
    jogos_path(Path), 
    save_object(Path, Jogo).

% Sobrecarga de regra para adicionar um jogo no banco de dados quando
% a quantidade de aluguéis não é 0
add_jogo(ID, Nome, Descricao, Categoria, Preco, QtdAlugueis) :- 
    Jogo = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=Preco, qtdAlugueis=QtdAlugueis]),
    jogos_path(Path), 
    save_object(Path, Jogo).

% Regra para pegar um jogo por ID
get_jogo_by_id(Id, Jogo) :- jogos_path(Path), get_object_by_id(Path, Id, Jogo, 'produtos').

% Regra para pegar um jogo por nome
get_jogo_by_nome(Nome, Jogo) :- jogos_path(Path), get_object_by_nome(Path, Nome, Jogo).

% Regra para remover um jogo por ID
remove_jogo_by_id(Id) :- jogos_path(Path), remove_object_by_id(Path, Id, 'produtos').

% Regra para incrementar a quantidade de aluguéis de um jogo
incrementa_qtd_alugueis_jogos(Id) :- 
    get_jogo_by_id(Id, Jogo),
    extract_info_produtos(Jogo, _, Nome, Descricao, Categoria, PrecoPorDia, QtdAlugueis),
    Nova_QtsAlugueis is QtdAlugueis + 1,
    remove_jogo_by_id(Id),
    add_jogo(Id, Nome, Descricao, Categoria, PrecoPorDia, Nova_QtsAlugueis).
