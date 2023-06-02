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

extract_info_produtos([json([id=Id, nome=Nome, descricao=Descricao, categoria=Categoria, precoPorDia=PrecoPorDia, qtdAlugueis=QtdAlugueis])|_], Id, Nome, Descricao, Categoria, PrecoPorDia, QtdAlugueis).

seach_id([Head_Object|_], Id, Head_Object) :- 
    extract_info_produtos([Head_Object|_], Object_Id, _, _, _, _, _),
    Object_Id = Id, !.
seach_id([_|Tail], Id, Object) :- seach_id(Tail, Id, Object).

get_object_by_id(File, Id, Object) :- 
    load_json_file(File, Data),
    seach_id(Data, Id, Object).

%%% REGRAS PARA FILMES %%%
get_filmes(Data) :- load_json_file('Filme.json', Data).
add_filme(ID, Nome, Descricao, Categoria, Preco) :- 
    Filme = json([id=ID, nome=Nome, descricao=Descricao, categoria=Categoria, preco=Preco, qtdAlugueis=0]),
    save_object('Filme.json', Filme).
get_filme_by_id(Id, Filme) :- get_object_by_id('Filme.json', Id, Filme).


