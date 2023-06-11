:- use_module(library(http/json)).
:- import('utils.pl').
:- consult('DataBase/GerenciadorBD.pl').
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% Gerador de id
% Inicializa o contador com o valor 1000
initialize_counter :-
    retractall(counter(_)),
    assertz(counter(1000)).
% Gera um novo ID incrementando o contador
generate_id(ID) :-
    retract(counter(Counter)),
    NewCounter is Counter + 1,
    assertz(counter(NewCounter)),
    atom_concat('ID', NewCounter, ID).
% Inicializa o contador antes de usar a função
:- initialization initialize_counter.

% Escolhe filme usando o idFilme e o idCliente e adiciona o filme selecionado ao carrinho correspondente ao cliente selecionado
adicionaFilme(IdFilme, IdCliente, Resposta) :-
  atom_string(IDAtomf, IdFilme),
  get_filme_by_id(IDAtomf, Filme),
  Filme \= -1,
  atom_string(IDAtomc, IdCliente),
  get_cliente_by_id(IDAtomc, Cliente),
  Cliente \= -1,
  generate_id(IdElemento),
  adiciona_produto_carrinho(IDAtomc, IdElemento, IDAtomf, 'filme'),
  Resposta = 'Filme adicionado ao carrinho'.


adicionaFilme(IdFilme, _, 'Cliente não existente') :-
  atom_string(_, IdFilme).

adicionaFilme(_, IdCliente, 'Filme não existente') :-
  atom_string(_, IdCliente).

% Escolhe serie usando o idSerie e o idCliente e adiciona a serie selecionada ao carrinho correspondente ao cliente selecionado
adicionaSerie(IdSerie, IdCliente, Resposta) :-
  atom_string(IDAtoms, IdSerie),
  get_serie_by_id(IDAtoms, Serie),
  Serie \= -1,
  atom_string(IDAtomc, IdCliente),
  get_cliente_by_id(IDAtomc, Cliente),
  Cliente \= -1,
  generate_id(IdElemento),
  adiciona_produto_carrinho(IDAtomc, IdElemento, IDAtoms, 'serie'),
  Resposta = 'Serie adicionado ao carrinho'.


adicionaSerie(IdSerie, _, 'Cliente não existente') :-
  atom_string(_, IdSerie).

adicionaSerie(_, IdCliente, 'Serie não existente') :-
  atom_string(_, IdCliente).

% Escolhe jogo usando o idJogo e o idCliente e adiciona o jogo selecionado ao carrinho correspondente ao cliente selecionado
adicionaJogo(IdJogo, IdCliente, Resposta) :-
  atom_string(IDAtomj, IdJogo),
  get_jogo_by_id(IDAtomj, Jogo),
  Jogo \= -1,
  atom_string(IDAtomc, IdCliente),
  get_cliente_by_id(IDAtomc, Cliente),
  Cliente \= -1,
  generate_id(IdElemento),
  adiciona_produto_carrinho(IDAtomc, IdElemento, IDAtomj, 'jogo'),
  Resposta = 'Jogo adicionado ao carrinho'.


adicionaJogo(IdJogo, _, 'Cliente não existente') :-
  atom_string(_, IdJogo).

adicionaJogo(_, IdCliente, 'Jogo não existente') :-
  atom_string(_, IdCliente).  


% Retorna o carrinho de um cliente especifico utilizando o IdCliente como referencia
verCarrinho(IdCliente, Resposta) :-
  atom_string(IdAtom, IdCliente),
  get_cliente_by_id(IdAtom, Cliente),
  Cliente \= -1,
  get_cliente_carrinho(IdAtom, Carrinho),
  Resposta = Carrinho.

verCarrinho(_, "Cliente não existente").

% Remove um produto referenciado pelo IdProduto de um carrinho de um cliente referenciado por IdCliente.
removeProdutoCarrinho(IdProduto, IdCliente, Resposta) :-
  atom_string(IdAtomc, IdCliente),
  get_cliente_by_id(IdAtomc, Cliente),
  Cliente \= -1,
  atom_string(IdAtomp, IdProduto),
  remove_produto_carrinho(IdAtomc, IdAtomp),
  Resposta = 'Produto removido'.

removeProdutoCarrinho(_, IdCliente, 'Produto não encontrado') :-
  atom_string(_, IdCliente).

removeProdutoCarrinho(IdProduto, _, 'Cliente não existente') :-
  atom_string(_, IdProduto).

% Adiciona o jogo referente ao IdProduto ao historico de um cliente referente ao IdCliente utilizando o DataCompra como parametro de tempo de aluguel.
alugarJogo(IdCliente, DataCompra, IdProduto, Resposta) :-
  atom_string(IdAtomc, IdCliente),
  get_cliente_by_id(IdAtomc, Cliente),
  Cliente \= -1,
  atom_string(IdAtomj, IdProduto),
  get_jogo_by_id(IdAtomj, Jogo),
  Jogo \= -1,
  atom_string(Data, DataCompra),
  generate_id(IdElemento),
  adiciona_produto_historico(IdAtomc, IdElemento, Data, IdAtomj, 'jogo'),
  add_historico_geral(IdElemento, Data, IdAtomj, 'jogo', IdAtomc),
  Resposta = 'Jogo alugado com sucesso'.

alugarJogo(_, DataCompra, IdProduto, 'Cliente não existente') :-
  atom_string(_, DataCompra),
  atom_string(_, IdProduto).
alugarJogo(IdCliente, _, IdProduto, 'Data invalida') :- 
  atom_string(_, IdProduto),
  atom_string(_, IdCliente).
alugarJogo(IdCliente, DataCompra, _, 'Produto não encontrado') :- 
  atom_string(_, DataCompra),
  atom_string(_, IdCliente).

% Adiciona o filme referente ao IdProduto ao historico de um cliente referente ao IdCliente utilizando o DataCompra como parametro de tempo de aluguel.
alugarFilme(IdCliente, DataCompra, IdProduto, Resposta) :-
  atom_string(IdAtomc, IdCliente),
  get_cliente_by_id(IdAtomc, Cliente),
  Cliente \= -1,
  atom_string(IdAtomf, IdProduto),
  get_filme_by_id(IdAtomf, Filme),
  Filme \= -1,
  atom_string(Data, DataCompra),
  generate_id(IdElemento),
  adiciona_produto_historico(IdAtomc, IdElemento, Data, IdAtomf, 'filme'),
  add_historico_geral(IdElemento, Data, IdAtomf, 'filme', IdAtomc),
  Resposta = 'Filme alugado com sucesso'.

alugarFilme(_, DataCompra, IdProduto, 'Cliente não existente') :- 
  atom_string(_, DataCompra),
  atom_string(_, IdProduto).
alugarFilme(IdCliente, _, IdProduto, 'Data invalida') :- 
  atom_string(_, IdProduto),
  atom_string(_, IdCliente).
alugarFilme(IdCliente, DataCompra, _, 'Produto não encontrado'):-
  atom_string(_, DataCompra),
  atom_string(_, IdCliente).

% Adiciona a serie referente ao IdProduto ao historico de um cliente referente ao IdCliente utilizando o DataCompra como parametro de tempo de aluguel.
alugarSerie(IdCliente, DataCompra, IdProduto, Resposta) :-
  atom_string(IdAtomc, IdCliente),
  get_cliente_by_id(IdAtomc, Cliente),
  Cliente \= -1,
  atom_string(IdAtoms, IdProduto),
  get_serie_by_id(IdAtoms, Serie),
  Serie \= -1,
  atom_string(Data, DataCompra),
  generate_id(IdElemento),
  adiciona_produto_historico(IdAtomc, IdElemento, Data, IdAtoms, 'serie'),
  add_historico_geral(IdElemento, Data, IdAtoms, 'serie', IdAtomc),
  Resposta = 'Serie alugada com sucesso'.

alugarSerie(_, DataCompra, IdProduto, 'Cliente não existente') :-
  atom_string(_, DataCompra),
  atom_string(_, IdProduto).
alugarSerie(IdCliente, _, IdProduto, 'Data invalida') :-
  atom_string(_, IdProduto),
  atom_string(_, IdCliente).
alugarSerie(IdCliente, DataCompra, _, 'Produto não encontrado') :-
  atom_string(_, DataCompra),
  atom_string(_, IdCliente).