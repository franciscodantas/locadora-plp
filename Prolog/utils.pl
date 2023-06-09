:- consult('DataBase/GerenciadorBD.pl').

% Retorna a lista de filmes, com nome e descrição
listaFilmes(Resposta) :- 
    get_filmes(Data),
    organizaListagemProdutos(Data, Resposta).

listaSeries(Resposta) :- 
    get_series(Data),
    organizaListagemProdutos(Data, Resposta).

listaJogos(Resposta) :- 
    get_jogos(Data),
    organizaListagemProdutos(Data, Resposta).

listaClientes(Resposta) :- 
    get_cientes(Data),
    organizaListagemCliente(Data, Resposta).

organizaListagemHistorico([], '').
organizaListagemHistorico([H|T], Resposta) :- 
    organizaListagemHistorico(T, Resposta1),
    extract_info_historico(H, _, _, IdProduto, Tipo, _),
    get_info(IdProduto, Tipo, Nome, Descricao),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Descricao, NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, '\n\n', NomeLinhaComQuebraDeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinhaComQuebraDeLinha, Resposta1, Resposta).

% Organiza a listagem de produtos
organizaListagemProdutos([], '').
organizaListagemProdutos([H|T], Resposta) :-
    organizaListagemProdutos(T, Resposta1),
    extract_info_produtos(H, _, Nome, Descricao, _, _, _),
    string_concat(Nome, '\n', NomeComQuebraDeLinha),
    string_concat(Descricao, '\n', DescricaoComQuebraDeLinha),
    string_concat(NomeComQuebraDeLinha, DescricaoComQuebraDeLinha, Produtos),
    string_concat(Produtos, '\n', ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

concatena_strings(ListaStrings, Resultado) :-
    concatena_strings_aux(ListaStrings, '', Resultado).

concatena_strings_aux([], Acumulador, Acumulador).
concatena_strings_aux([String | Resto], Acumulador, Resultado) :-
    atom_concat(Acumulador, String, NovoAcumulador),
    concatena_strings_aux(Resto, NovoAcumulador, Resultado).

formata_valor(Valor, ValorFormatado) :-
    format(atom(AtomValorFormatado), 'R$ ~2f', [Valor]),
    atom_chars(AtomValorFormatado, ListaChars),
    substitui_ponto_virgula(ListaChars, ListaCharsFormatada),
    atom_chars(ValorFormatado, ListaCharsFormatada).

substitui_ponto_virgula([], []).
substitui_ponto_virgula(['.'|T], [','|T2]) :-
    substitui_ponto_virgula(T, T2).
substitui_ponto_virgula([H|T], [H|T2]) :-
    substitui_ponto_virgula(T, T2).

% Organiza a listagem de produtos, apresentando nome, categoria e quantidade de aluguéis
organizaListagemEstatistica([], '').
organizaListagemEstatistica([H|T], Resposta) :-
    organizaListagemEstatistica(T, Resposta1),
    extract_info_produtos(H, _, Nome, _, Categoria, PrecoPorDia, QtdAlugueis),
    formata_valor(PrecoPorDia, PrecoPorDiaFormatado),
    concatena_strings(['\nNome: ', Nome, '\nCategoria: ', Categoria, '\nQuantidade de alugueis: ', QtdAlugueis, '\nPreco por dia: ', PrecoPorDiaFormatado, '\n'], ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

organizaListagemCliente([], '').
organizaListagemCliente([H|T], Resposta) :-
    organizaListagemCliente(T, Resposta1),
    extract_info_clientes(H, Id, Nome, _, _),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Id, Produtos),
    string_concat(Produtos, '\n', ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

get_info(Id, 'filme',  Nome, Descricao) :- 
    get_filme_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'jogo',  Nome, Descricao) :- 
    get_jogo_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'serie', Nome, Descricao) :- 
    get_serie_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

prompt(Message, String) :-
    write(Message),
    flush_output,
    read_line_to_codes(user_input, Codes),
    string_codes(String, Codes).