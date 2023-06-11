:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% Regra que adiciona um cliente
adicionaCliente(ID,Nome,IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente = -1,
    add_cliente(ID,Nome),
    Resposta = 'Cadastro realizado!'.

% Regra que  valida a adição de um cliente
adicionaCliente(_, _, _, _, 'Cadastro não realizado!').

% Regra que adiciona uma série
adicionarSeries(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_serie_by_id(IDAtom, Serie),
    Serie = -1,
    string_para_float(Preco, PrecoFloat),
    add_serie(ID, Nome, Descricao, Categoria, PrecoFloat),
    Resposta = 'Serie adicionada!'.

% Regra que  valida a adição de uma série
adicionarSeries(_, _, _, _, _, _, _, 'Serie não adicionada!').

% Regra que remove uma série por ID
removerSeries(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_serie_by_id(IDAtom, Serie),
    Serie \= -1,
    remove_serie_by_id(IDAtom),
    Resposta = 'Serie removida!'.

% Regra que valida a adição de uma série
removerSeries(_, _, _, 'Serie não removida!').

% Regra que adiciona um filme
adicionarFilmes(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_filme_by_id(IDAtom, Filme),
    Filme = -1,
    string_para_float(Preco, PrecoFloat),
    add_filme(ID, Nome, Descricao, Categoria, PrecoFloat),
    Resposta = 'Filme adicionado!'.

% Regra que valida a adição de um filme
adicionarFilmes(_, _, _, _, _, _, _, 'Filme não adicionado!').

% Regra que remove um filme por ID
removerFilmes(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_filme_by_id(IDAtom, Filme),
    Filme \= -1,
    remove_filme_by_id(IDAtom),
    Resposta = 'Filme removido!'.

% Regra que valida a remoção de um filme
removerFilmes(_, _, _, 'Filme não removido!').

% Regra que adiciona um jogo
adicionarJogos(Nome, ID, Categoria, Descricao, Preco, IdFuncionario, Senha, Resposta):- 
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_jogo_by_id(IDAtom, Jogo),
    Jogo = -1,
    string_para_float(Preco, PrecoFloat),
    add_jogo(ID, Nome, Descricao, Categoria, PrecoFloat),
    Resposta = 'Jogo adicionado!'.

% Regra que valida a adição de um jogo
adicionarJogos(_, _, _, _, _, _, _, 'Jogo não adicionado!').

% Regra que remove um jogo por ID
removerJogos(ID, IdFuncionario, Senha, Resposta):-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_jogo_by_id(IDAtom, Jogo),
    Jogo \= -1,
    remove_jogo_by_id(IDAtom),
    Resposta = 'Jogo removido!'.

% Regra que valida a remoção de um jogo
removerJogos(_, _, _, 'Jogo não removido!').

% Regra que remove um cliete por ID
removerCliente(ID, IdFuncionario, Senha, Resposta) :-
    validaFuncionario(IdFuncionario, Senha, Resposta1),
    Resposta1 = 'Funcionario validado!',
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    remove_cliente_by_id(IDAtom),
    Resposta = 'Cliente removido!'.

% Regra que valida a remoção de um cliente
removerCliente(_, _, _, 'Cliente não removido!').

% Regra que exibe o histórico de um ciente por ID
exibirHistoricoCliente(ID, Resposta) :-
    atom_string(IDAtom, ID),
    get_cliente_by_id(IDAtom, Cliente),
    Cliente \= -1,
    extract_info_clientes(Cliente, _, Nome, _, Historico),
    organizaListagemHistorico(Historico, Resposta1),
    string_concat('Historico de compras de ', Nome, NomeLinha),
    string_concat(NomeLinha, '\n\n', NomeLinhaComQuebraDeLinha),
    string_concat(NomeLinhaComQuebraDeLinha, Resposta1, Resposta).

% Regra que valida a exibição do histórico de um cliente
exibirHistoricoCliente(_, 'Cliente não encontrado!').

% Regra que valida um funcionário verificando se a senha dele está correta
validaFuncionario(IdFuncionario, Senha, Resposta) :-
    atom_string(IdFuncionarioAtom, IdFuncionario),
    get_funcionario_by_id(IdFuncionarioAtom, Funcionario),
    extract_info_funcionarios_gerentes(Funcionario, _, _, SenhaAtual),
    atom_string(SenhaAtom, Senha),
    SenhaAtom = SenhaAtual,
    Funcionario \= -1,
    Resposta = 'Funcionario validado!'.
