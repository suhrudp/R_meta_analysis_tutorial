# META-ANALYSIS

## **LOAD LIBRARIES**

```{r}
library(metafor)
library(meta)
```

## **ATTACH DATA**

```{r}
df <- dat.bcg
attach(df)
View(df)
```

## CALCULATING APPROPRIATE EFFECT SIZES

1.  For continuous outcomes (eg, means and standard deviations): Cohen's D (AKA standardized mean difference), Hedge's G, Glass's delta and so on.
2.  For dichotomous outcomes (eg, outcome achieved or not, mild or severe disease): log odds ratios, odds ratios, risk ratios and so on.

```{r}
dfes <- escalc(measure="RR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=df)
View(dfes)

cont <- escalc(measure="SMD", m1i=mean1, m2i=mean2, sd1i=SD1, sd2i=SD2, n1i
                              =N1, n2i=N2)
```

## FITTING A META-ANALYTIC MODEL VIA A LINEAR (MIXED-EFFECTS) MODEL

```{r}
ma.mod <- rma(yi=yi, vi=vi, slab=author, data=dfes)

summary(ma.mod)
forest(ma.mod)
funnel(ma.mod)
```

## META-REGRESSION TO EXPLORE HETEROGENEITY

```{r}
mr.mod <- rma(yi=yi, vi=vi, slab=author, mods= ~ dfes$ablat, data=dfes)
summary(mr.mod)
forest(mr.mod)
funnel(mr.mod)
regplot(mr.mod, mod='dfes$ablat', ci=T)
```
