## Hubbell (2001) deduziu um modelo de distribuição de abundância de espécies a partir de sua teoria neutra da biodiversidade. No livro apresenta sua teoria, ele mostra os números de espécies previstos por oitvas, para seu modelo e para lognormal: 
## Incluir um iframe com a página do livro que tem esta figura, e uma legenda "Ajuste da lognormal e do modelo multinomial de soma zero aos dados de BCI (Hubbell 2001) : <iframe frameborder="0" scrolling="no" style="border:0px" src="https://books.google.com.br/books?id=EIQpFBu84NoC&lpg=PA135&vq=Fig.%205.7&hl=pt-BR&pg=PA135&output=embed" width=500 height=500></iframe>

## Levou algum tempo até que desenvolvimento analíticos e computacionais permitissem a comparação destes modelos por critério de verossimilhança. Neste tutorial vamos usar o pacote `sads` para afzer estas comparações com o critério deinformação de Akaike (AIC). Comece carregando o pacote sads:

library(sads)

## Conjunto de dados - arvores ma parcela permanente de BCI
## Usaremos una vez más los datos de conteos de árboles da [parcela permanente de la isla de Barro Colorado](https://ctfs.si.edu/webatlas/datasets/bci/) (Panamá), pero ahora solamente el total de individuos por especie em toda os 50ha da parcela. O pacote sads tem o objeto de dados `bci`, que tem estes dados. Ao carregar o pacote os dados já estarão diponíveis. Veja as abundâncias das 10 especies mais comuns com 

head(sort (bci, decreasing=TRUE), 10)

## e aqui verifique o total de especies
length(bci)

## e aqui criamos um objeto com o numero de especies por oitavas de abundância

bci.oc <- octav(bci)
head(bci.oc)

## com qual podemos então produzir o histograma de oitavas:

plot(bci.oc)

## Ajuste dos modelos
## Agora vamos ajustar três modelos a estes dados:
## * Uma log-normal: no R esta  distribuição (`[dpqr]lnorm`) começa em zero. Para aproximar a linha de véu proposta por Preston, vamos ajustar uma distribuição truncada 0,99.
## * Poisson-lognormal, que é a solução analítica para uma lognormal truncada por uma amostragem ao acaso do indivíduos
## * O modelo multinomial de soma zero da teoria neutra. Usaremos a distribuição proposta por Volkov et al. (2003).

## Começamos com o ajuste à lognormal. Afunção do pacote `sad`para fazer este ajuste é `fitlnorm()`, que tem um argumento `trunc`, com qual definimos a truncagem em 0,99:

(bci.ln <- fitlnorm(bci, trunc = 0.99))

## Agora ajustamos a log-series:

(bci.ls <- fitls(bci))

## E finalmente a multinomial de soma zero da teoria neutra. Oscáluclos deste ajuste demoram um pouco mais, e podem levar um a alguns minutos, dependendo de seu computador (incluir uma nota de rodapé: caso tenha problemas em ajustar, você pode baixar o objeto com o ajuste [aqui](../02_ajustes/bci_vk.rds) e carrargar o objeto com comando bci.vk <- readRDS("bci_vk.rds"))

(bci.vk <- fitvolkov(bci))

## Seção a seleção de modelos com AIC

## O AIC é uma medida de erro de pervisão de um modelo estatístico,
## calculado por $$\text{AIC} = -2 ln(\hat \mathcal{L}) + 2 k$$, onde
## \hat \mathcal{L} é o valor da máxima verossimilhança do modelo
## ajustado aos dados, e k o número de parâmetros do modelo. Os objetos de modelos ajustados pelo pacote `sads` guardam o valor de \ln \hat \mathcal{L}. Verifique este valor para o modelo lognormal:

logLik(bci.ln)

## o numero de parâmetros k do modelo está exibido como "df". Na
## log-normal temos dois parâmetros, mu e sigma.

## Com isso, podemos calcular o AIC deste modelo explicitamente assim:

as.numeric(-2 * logLik(bci.ln) + 2*2)

## Mas isso nem é ncessário pois temos a função para cálculo do AIC no *R*:
AIC(bci.ln)

## O valor de AIC de um modelo não é interpretável. Ele ganha significado para comparar modelos ajustados aos mesmos dados (incluir uma nota de rodapé: Isto é muito importante: como o AIC é calculado da verossimilhança, ele também é uma quantidade condicionada aos dados. Assim, não faz sentido comparar AICs de modelos ajustados  a dados diferentes. Apenas a diferentes modelos ajustados exatamente aos mesmo dados).
## O AIC expressa a perda de informação contida nos dados quando se  a substituimos pelo modelo. Se esta perda é pequena, o modelo será capaz de simular novos dados muito parecidos com os reais, ou seja, o modelo tem grande poder preditivo. Sendo uma medida de perda de informação, um menor valor de AIC indica um modelo melhor. Para comparar modelos desta maneira, calculamos seus  AICs, ordenamos os modelos do de menor para maior AIC e calcumaos a diferença entre cada IAC e o menor (tornar esta explicação mais concisa). O melhor modelos entre os avaliado será o de menor AIC. Mas em geral adotamos a convenção de que todos os modelos com diferença de AIC em relação ao melhor menor que 2 são igualmente bem sustentados pelos dados.

## O pacote `bblme`, sobre o qual as rotinas do `sads` são construídas, tem uma função que realiza estes cálculos:

AICtab(bci.ln, bci.ls, bci.vk,
       mnames = c("Lognormal", "Log-series", "Neutral"))

## Incluir aqui um teste: Com esta seleção de modelos podemos concluir que: todos os três modelos são igualmente bem sapoiados pelos dados; o modelo log-normal e log-series são equivalentes, o modelo neutro tem o maior suporte dos dados, entre os três avaliados (correta), o modelo neutro é o melhro modelo possível para estes dados      

## Esta comparação nos permite comparar estritamente estes trẽs
## modelos quanto ao seu poder preditivo. Esperamos que aquele que
## tenha maior poder preditivo também resulte em melhor ajuste aos
## dados. Vamos avaliar
## graficamente o ajuste destes três modelos com o grafico de oitavas:

plot(bci.oc)
lines(octavpred(bci.ln), col=1, lwd = 2)
lines(octavpred(bci.ls), col=2, lwd = 2)
lines(octavpred(bci.vk), col=3, lwd = 2)
legend("topright", c("Lognormal", "Log-series", "Neutral"),
       lty=1, pch =1, col=1:3, cex = 1.25, bty = "n")

## e também com o gráfico de rank-abundancia

plot(rad(bci))
lines(radpred(bci.ln), col=1, lwd = 2)
lines(radpred(bci.ls), col=2, lwd = 2)
lines(radpred(bci.vk), col=3, lwd = 2)
legend("topright", c("Lognormal", "Log-series", "Neutral"),
       lty=1, pch =1, col=1:3, cex = 1.25, bty = "n")
#[tentar fazer esta parte ficar mais sucinta]
## Note que a principal diferença entre a lognormal e a distribuição da teoria neutra é um melhor ajuste das abundâncias mais baixas. Isto acontece porque no modelo neutro há um parâmetro de imigração, que controla  a proporção de espećies raras na amostra, ou seja a forma da cauda esquerda da sad.

## Este parâmetro é estimado  ajuste da sad deste modelo, e sob o modelo expressa a proporção das mortes que são substituídos por incivíduos migrantes, ou seja, que não vêm de fora da comunidade. O outro parâmetro da sad do modelo neutro é $\Theta$ (theta), que Hubbell (2001) chamou de número fundamental da biodiversidade. Veja que o intervalosd e confinça dos dois parâmetros são bem amplos para o ajuste aos dados de BCI:

confint(bci.vk, method ="quad")

## Exercício: avaliando outros modelos

## Você pode incluir quantos modelos quiser em sua seleção de modelos, desde que sejam todos ajustados exatamente aso mesmos dados. Então vamos deixar aqui o exrcício de avaliar mais outros dois modelos ajustados aos mesmo dados de bci:
## * "Power bend", do qual a log-serie é um caso particular. \Este modelo tem um parâmetro a mais, que permite uma distribuição mais flexível que a logsérie, principalmente quanto à sua cauda esquerda (Pueyo, 2006). Assim, pode ser uma alternativa que resolva o problema de super-estimativa de número de espécies raras que log-series teve.
## * Poisson-logormal: é a solução analítica para a truncagem devido à amostragem de uma comunidade lognormal (Bulmer 1974, Grøtan & Engen, 2008). Portanto pode ser elhor laternativa que a aproximação que usamos ajustando uma lognormal truncada arbitrariamente em 0,99.

## Adapte os comandos acima para ajustar estes dois modelos e incluí-los na seleção de modelos
## Inclua aqui um test de verdadeiro e falso ou de marque apenas as alternativas verdadeiras (pode melhorar os enunciados):
## Marque V (verdadeiro) ou F (falso) (ou marque as alternativas verdadeiras) para cada uma das afirmações sobre esta nova seleção de modelos
## Confirmamos a expectativa que os modelos power-bend e poilog são melhores alternativas que a log-série e a lognormal truncada, respectivamente (V)
## Os modelos power-bend e poisson-lognormal são igualmente plausíveis, mas inferiores ao modelo da teoria neutra (V)
## O modelo power-bend superestima menos o número de espécies raras, comparado com a log-series (V)
## O modelo poisson-lognormal subestima o número de espécies raras tanto como o modelo log-normal truncado (F)

## Conclusões
## faça um breve resumo do que se aprende com este exercício

## Colocar como apêndice, com os códigos escondidos com a opção code_folding=TRUE:
## Aqui estão os códigos da solução dos exercícios, se quiser comparar. mas tente resolver primeiro antes de olhar. 
bci.pb <- fitpowbend(bci)
bci.pl <- fitpoilog(bci)

AICtab(bci.ln, bci.ls, bci.vk, bci.pb, bci.pl,
       mnames = c("Lognormal", "Log-series", "Neutral", "Power-bend", "Poilog"))

par(mfrow=c(1,2))
plot(bci.oc)
lines(octavpred(bci.ln), col=1, lwd = 2)
lines(octavpred(bci.ls), col=2, lwd = 2)
lines(octavpred(bci.vk), col=3, lwd = 2)
legend("topright", c("Lognormal", "Log-series", "Neutral"),
       lty=1, pch =1, col=1:3, cex = 1.25, bty = "n")

plot(bci.oc)
lines(octavpred(bci.pl), col=1, lwd = 2)
lines(octavpred(bci.pb), col=2, lwd = 2)
lines(octavpred(bci.vk), col=3, lwd = 2)
legend("topright", c("Poilog", "Power-bend","Neutral"),
       lty=1, pch =1, col=1:3, cex = 1.25, bty = "n")
par(mfrow=c(1,1))
