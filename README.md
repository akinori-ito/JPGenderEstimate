# JPGenderEstimate
日本語の名前の漢字と平仮名から性別を推定します。推定には`xgboost`を利用します。

```{r}
> library(JPGenderEstimate)
> genderEstimate("芳雄","よしお")
[1] 1.000199
> genderEstimate("和子","かずこ")
[1] 0.06099159
```
