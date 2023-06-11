:- use_module(library(dcg/basics)).

% Regra que retorna a lista de filmes, com nome e descrição
listaFilmes(Resposta) :- 
    get_filmes(Data),
    organizaListagemProdutos(Data, Resposta).

% Regra que retorna a lista de séries, com nome e descrição
listaSeries(Resposta) :- 
    get_series(Data),
    organizaListagemProdutos(Data, Resposta).

% Regra que retorna a lista de jogos, com nome e descrição
listaJogos(Resposta) :- 
    get_jogos(Data),
    organizaListagemProdutos(Data, Resposta).

% Regra que retorna a lista de clientes, com nome e ID
listaClientes(Resposta) :- 
    get_cientes(Data),
    organizaListagemCliente(Data, Resposta).

% Regra que formata os dados do histórico recebidos do banco de dados
% Essa regra organiza históricos gerais e históricos específicos para a impressão no main
organizaListagemHistorico([], '').
organizaListagemHistorico([H|T], Resposta) :- 
    organizaListagemHistorico(T, Resposta1),
    extract_info_historico(H, _, _, IdProduto, Tipo, _),
    get_info(IdProduto, Tipo, Nome, Descricao),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Descricao, NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, '\n\n', NomeLinhaComQuebraDeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinhaComQuebraDeLinha, Resposta1, Resposta).

% Regra que formata os dados do carrinho recebidos do banco de dados
% Essa regra organiza o carrinho para a impressão no main
organizaListagemCarrinho([], '').
organizaListagemCarrinho([H|T], Resposta) :- 
    organizaListagemCarrinho(T, Resposta1),
    extract_info_carrinho(H, _, IdProduto, Tipo),
    get_info(IdProduto, Tipo, Nome, Descricao),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Descricao, NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, '\n\n', NomeLinhaComQuebraDeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinhaComQuebraDeLinha, Resposta1, Resposta).

% Regra que formata os dados dos produtos recebidos do banco de dados
% Essa regra organiza os produtos para a impressão no main
organizaListagemProdutos([], '').
organizaListagemProdutos([H|T], Resposta) :-
    organizaListagemProdutos(T, Resposta1),
    extract_info_produtos(H, _, Nome, Descricao, _, _, _),
    string_concat(Nome, '\n', NomeComQuebraDeLinha),
    string_concat(Descricao, '\n', DescricaoComQuebraDeLinha),
    string_concat(NomeComQuebraDeLinha, DescricaoComQuebraDeLinha, Produtos),
    string_concat(Produtos, '\n', ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

% Regra que formata os dados recebidos do banco de dados com os produtos mais vendidos
% Essa regra organiza os produtos para imprimir as informações importantes para
% a seção de estatística de vendas
organizaListagemEstatistica([], '').
organizaListagemEstatistica([H|T], Resposta) :-
    organizaListagemEstatistica(T, Resposta1),
    extract_info_produtos(H, _, Nome, _, Categoria, PrecoPorDia, QtdAlugueis),
    formata_valor(PrecoPorDia, PrecoPorDiaFormatado),
    concatena_strings(['\nNome: ', Nome, '\nCategoria: ', Categoria, '\nQuantidade de alugueis: ', QtdAlugueis, '\nPreco por dia: ', PrecoPorDiaFormatado, '\n'], ProdutosConcatenados),
    string_concat(ProdutosConcatenados, Resposta1, Resposta).

% Regra que formata os dados dos clientes presentes no banco de dados
organizaListagemCliente([], '').
organizaListagemCliente([H|T], Resposta) :-
    organizaListagemCliente(T, Resposta1),
    extract_info_clientes(H, Id, Nome, _, _),
    string_concat(Nome, ' - ', NomeLinha),
    string_concat(NomeLinha, Id, Clientes),
    string_concat(Clientes, '\n', ClientesConcatenados),
    string_concat(ClientesConcatenados, Resposta1, Resposta).

% Regra que recebe uma lista de string retorna a concatenação de todas
concatena_strings(ListaStrings, Resultado) :-
    concatena_strings_loop(ListaStrings, '', Resultado).

% Regra que auxilia a concatenação de uma lista da lista de strings recebidas
concatena_strings_loop([], Acumulador, Acumulador).
concatena_strings_loop([String | Resto], Acumulador, Resultado) :-
    atom_concat(Acumulador, String, NovoAcumulador),
    concatena_strings_loop(Resto, NovoAcumulador, Resultado).

% Regra que formata um valor de ponto flutuante recebido para
% um formato de valor em reais: R$ valor
formata_valor(Valor, ValorFormatado) :-
    format(atom(AtomValorFormatado), 'R$ ~2f', [Valor]),
    atom_chars(AtomValorFormatado, ListaChars),
    substitui_ponto_virgula(ListaChars, ListaCharsFormatada),
    atom_chars(ValorFormatado, ListaCharsFormatada).

% Regra que auxilia que completa a formatação de um valor de
% ponto flutuante para reais, substituindo o ponto por vírgula
substitui_ponto_virgula([], []).
substitui_ponto_virgula(['.'|T], [','|T2]) :-
    substitui_ponto_virgula(T, T2).
substitui_ponto_virgula([H|T], [H|T2]) :-
    substitui_ponto_virgula(T, T2).

% Regras que generalizam a extração de informações relevantes para a impressão da lista de produtos
% - Os produtos podem ser filmes, séries e jogos
% - As informações extraídas para a impressão são nome e descrição
get_info(Id, 'filme',  Nome, Descricao) :- 
    get_filme_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'jogo',  Nome, Descricao) :- 
    get_jogo_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

get_info(Id, 'serie', Nome, Descricao) :- 
    get_serie_by_id(Id, Object),
    extract_info_produtos(Object, _, Nome, Descricao, _, _, _),!.

string_para_float(String, Float) :-
    atom_chars(String, Chars),    % Converte a string em uma lista de caracteres
    number_chars(Float, Chars).   % Converte a lista de caracteres em um número de ponto flutuante

% As regras get_produto_em_destaque e seleciona_aluguel_destaque são
% responsáveis por selecionar o produto em detaque positivo ou negativo
% em relação ao aluguel. O produto com maior número de alugueis
% pode ser obtido passando o átomo 'mais_alugado' para as regras.
% Já o produto com menor número de alugueis pode ser obtido 
% passando o átomo 'menos_alugado' para as regras 
seleciona_aluguel_destaque('mais_alugado', QtdAlugueis1, QtdAlugueis2, Produto1, Produto2, Destaque) :- 
    (QtdAlugueis1 > QtdAlugueis2 -> Destaque = Produto1 ; Destaque = Produto2).
seleciona_aluguel_destaque('menos_alugado', QtdAlugueis1, QtdAlugueis2, Produto1, Produto2, Destaque) :- 
    (QtdAlugueis1 > QtdAlugueis2 -> Destaque = Produto2 ; Destaque = Produto1).

% Regra que pega um produto em destaque(como explicado acima)
get_produto_em_destaque([], _, Produto_Maior_Atual, Produto_Maior_Atual).
get_produto_em_destaque([Produto_Atual | Tail], Tipo_Destaque, Produto_Maior_Atual, Produto_Maior_Final) :- 
    extract_info_produtos(Produto_Atual, _, _, _, _, _, QtdAlugueis_Atual),
    extract_info_produtos(Produto_Maior_Atual, _, _, _, _, _, QtdAlugueis_Maior),
    seleciona_aluguel_destaque(Tipo_Destaque, QtdAlugueis_Atual, QtdAlugueis_Maior, Produto_Atual, Produto_Maior_Atual, Novo_Maior),
    get_produto_em_destaque(Tail, Tipo_Destaque, Novo_Maior, Produto_Maior_Final).

% Essa regra é responsável por pegar 'n' produtos em destaque.
% O destaque pode ser os 'n' produtos mais alugados ou os 'n' produtos
% menos alugados 
get_n_destaques(_, 0, _, Destaques_Atuais, Destaques_Atuais_Dec) :- reverse(Destaques_Atuais, Destaques_Atuais_Dec).
get_n_destaques([], _, _, Destaques_Atuais, Destaques_Atuais_Dec) :- reverse(Destaques_Atuais, Destaques_Atuais_Dec).
get_n_destaques(Produtos, N, Tipo_Destaque, Destaques_Atuais, Destaques_Finais) :- 
    [Primeiro_Produto | _] = Produtos,
    get_produto_em_destaque(Produtos, Tipo_Destaque, Primeiro_Produto, Destaque),
    Novos_Destaques = [Destaque | Destaques_Atuais],
    remove_object(Produtos, Destaque, Novos_Produtos),
    Novo_N is N - 1,
    get_n_destaques(Novos_Produtos, Novo_N, Tipo_Destaque, Novos_Destaques, Destaques_Finais).

% Regras para pegar produtos a partir do tipo
% Os tipos possíveis são: filme, serie e jogo
get_produto_by_tipo(IdProduto, Produto, 'filme') :- get_filme_by_id(IdProduto, Produto).
get_produto_by_tipo(IdProduto, Produto, 'serie') :- get_serie_by_id(IdProduto, Produto).
get_produto_by_tipo(IdProduto, Produto, 'jogo') :- get_jogo_by_id(IdProduto, Produto).

% Regra para remover espaços em branco antes e depois de uma string
trim(String, TrimmedString) :-
    atom_chars(String, Chars),
    trim_front(Chars, TrimmedFront),
    reverse(TrimmedFront, Reversed),
    trim_front(Reversed, ReversedTrimmed),
    reverse(ReversedTrimmed, Trimmed),
    atom_chars(TrimmedString, Trimmed).

% Regra para remover espaços em branco antes de uma string
trim_front([], []).
trim_front([X|Xs], [X|Xs]) :-
    X \= ' ',
    X \= '\t',
    X \= '\n'.
trim_front([_|Xs], TrimmedFront) :-
    trim_front(Xs, TrimmedFront).

% Regra de validação que gera false se a string recebida é composta apenas por espaços em branco
valida_valor_espacos(Valor) :- 
  trim(Valor, ValorTrimmed), ValorTrimmed \= ''.

% Regra de validação que gera false se o valor recebido não é positivo
valida_valor_negativo(Valor) :-
    number_string(Float, Valor),
    Float > 0.