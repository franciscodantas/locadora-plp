module Functions.ClienteFunctions where
    import DataBase.GerenciadorBD as BD
    import Models.Cliente
    import Models.Filme as FI
    import Models.Serie as SE
    import Models.Jogo as JO
    import Models.Produto

{- Lista filmes de uma categoria -}
    pesquisaFilmes:: String -> String
    pesquisaFilmes cat = 
        let filmes = filtraFilmes (BD.getFilmeJSON "DataBase/Filme.json")
        organizaListagem filmes

{- Lista jogos de uma categoria -}
    pesquisaJogos:: String -> String
    pesquisaJogos cat = 
        let jogos = filtraJogos (BD.getJogoJSON "DataBase/Jogo.json")
        organizaListagem jogos

{- Lista series de uma categoria -}
    pesquisaSeries:: String -> String
    pesquisaFilmes cat = 
        let series = filtraSeries (BD.getFilmeJSON "DataBase/Series.json")
        organizaListagem series

{- Adicionar filme ao carrinho -}
    addFilme:: String -> String -> IO String
    addFilme idCliente idFilme = do
        let filme = BD.getFilmeJSON "DataBase/Filme.json"
        BD.editClienteCarrinhoJSON idCliente filme

{- Adicionar série ao carrinho -}
    addSerie:: String -> String -> IO String
    addSerie idCliente idSerie = do
        let serie = BD.getFilmeJSON "DataBase/Serie.json"
        BD.editClienteCarrinhoJSON idCliente serie

{- Adicionar jogo ao carrinho -}
    addJogo:: String -> String -> IO String
    addJogo idCliente idSerie = do
        let jogo = BD.getFilmeJSON "DataBase/Jogo.json"
        BD.editClienteCarrinhoJSON idCliente jogo

--T0D0: Confirmar compra

--T0D0: Recomendações

{- faz a organização das lista em uma string por linha usando a sua
   representação em string -}
    organizaListagem :: Show t => [t] -> String
    organizaListagem [] = ""
    organizaListagem (x:xs) = show x ++ "\n" ++ organizaListagem xs

{- Filtra filmes por categoria -}
    filtraFilmes:: String -> [Filme] -> [Filme]
    filtraFilmes cat [] = []
    filtraFilmes lista = filter (\x -> (FI.categoria x) == cat) lista

{- Filtra jogos por categoria -}
    filtraJogos:: String -> [Jogo] -> [Jogo]
    filtraJogos cat [] = []
    filtraJogos lista = filter (\x -> (JO.categoria x) == cat) lista

{- Filtra séries por categoria -}
    filtraSeries:: String -> [Jogo] -> [Jogo]
    filtraSeries cat [] = []
    filtraSeries lista = filter (\x -> (SE.categoria x) == cat) lista
