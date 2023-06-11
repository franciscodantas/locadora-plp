:- use_module(library(http/json)).
:- import('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% Adiciona um cliente com seu ID e nome, sendo verificado se o cliente já existe e se o funcionario existe
adicionaCliente(ID,Nome,IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente = -1,
    add_cliente(ID,Nome),
    Resposta = 'Cadastro realizado!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
adicionaCliente(_, _, _, _, 'Cadastro não realizado!').

% Adiciona uma Serie com seu ID, nome, categoria, descrição e preço, sendo verificado se a serie já existe e se o funcionario existe
adicionarSeries(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_serie_by_id(IDAtom, Serie),
    Serie = -1,
    string_para_float(Preco, PrecoFloat),
    add_serie(ID, Nome, Descricao, Categoria, PrecoFloat),
    Resposta = 'Serie adicionada!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
adicionarSeries(_, _, _, _, _, _, _, 'Serie não adicionada!').

% Remove uma serie com seu ID, sendo verificado se a serie existe e se o funcionario existe
removerSeries(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_serie_by_id(IDAtom, Serie),
    Serie \= -1,
    remove_serie_by_id(IDAtom),
    Resposta = 'Serie removida!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
removerSeries(_, _, _, 'Serie não removida!').

% Adiciona um filme com seu ID, nome, categoria, descrição e preço, sendo verificado se o filme já existe e se o funcionario existe
adicionarFilmes(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_filme_by_id(IDAtom, Filme),
    Filme = -1,
    string_para_float(Preco, PrecoFloat),
    add_filme(ID, Nome, Descricao, Categoria, PrecoFloat),
    Resposta = 'Filme adicionado!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
adicionarFilmes(_, _, _, _, _, _, _, 'Filme não adicionado!').

% Remove um filme com seu ID, sendo verificado se o filme existe e se o funcionario existe
removerFilmes(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_filme_by_id(IDAtom, Filme),
    Filme \= -1,
    remove_filme_by_id(IDAtom),
    Resposta = 'Filme removido!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
removerFilmes(_, _, _, 'Filme não removido!').

% Adiciona um jogo com seu ID, nome, categoria, descrição e preço, sendo verificado se o jogo já existe e se o funcionario existe
adicionarJogos(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):- 
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_jogo_by_id(IDAtom, Jogo),
    Jogo = -1,
    string_para_float(Preco, PrecoFloat),
    add_jogo(ID, Nome, Descricao, Categoria, PrecoFloat),
    Resposta = 'Jogo adicionado!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
adicionarJogos(_, _, _, _, _, _, _, 'Jogo não adicionado!').

% Remove um jogo com seu ID, sendo verificado se o jogo existe e se o funcionario existe
removerJogos(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_jogo_by_id(IDAtom, Jogo),
    Jogo \= -1,
    remove_jogo_by_id(IDAtom),
    Resposta = 'Jogo removido!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
removerJogos(_, _, _, 'Jogo não removido!').

% Remove um cliente com seu ID, sendo verificado se o cliente existe e se o funcionario existe
removerCliente(ID, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    remove_cliente_by_id(IDAtom),
    Resposta = 'Cliente removido!'.

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
removerCliente(_, _, _, 'Cliente não removido!').

% exibi o historico de compras de um cliente com seu ID, sendo verificado se o cliente existe
exibirHistoricoCliente(ID, Resposta) :-
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    extract_info_clientes(Cliente, _, Nome, _, Historico),
    organizaListagemHistorico(Historico, Resposta1),
    string_concat('Historico de compras de ', Nome, NomeLinha),
    string_concat(NomeLinha, '\n\n', NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, Resposta1, Resposta).

% Caso algo não ocorra como o esperado, retorna uma mensagem de erro
exibirHistoricoCliente(_, 'Cliente não encontrado!').

% Valida um funcionario com seu ID e senha, sendo verificado se o funcionario existe e possue senha valida
validaFuncionario(IdFuncionario, Senha, Resposta) :-
    atom_string(IdFuncionarioAtom, IdFuncionario),
    get_funcionario_by_id(IdFuncionarioAtom, Funcionario),
    extract_info_funcionarios_gerentes(Funcionario, _, _, SenhaAtual),
    atom_string(SenhaAtom, Senha),
    SenhaAtom = SenhaAtual,
    Funcionario \= -1,
    Resposta = 'Funcionario validado!'.
