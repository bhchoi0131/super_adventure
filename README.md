# Overview
- This repository is for CBRE.
- An English version can be provided upon request.
- Please refer to the test.R file; I've added some comments on each block of codes which explain my thought process on producing the graphs.



<br/>
<br/>


# Report
- 数値が正しいか確認する前に、20個のデータファイルを全部合併すると、行数(nrow())がサンプルの数値(N=49,532)と違う結果になります。
  まず、sum(is.na()) =0　で、missing dataは無いのを確信しましたため、49530件のデータを元に処理を進行しました。
```
  nrow(data_address)=49530
  nrow(data_hometown)=49530
  nrow(total_dt)=49530
  sum(is.na(total_dt))=0
```


- 一番目のグラフの数値を確認すると、出身都道府県別平均年齢が 0.02くらいが違う結果値になりますが、これはサンプル数の違いによると思っております。
```
  > total_dt1$avg_age[match("富山県", total_dt1$出身地)]
[1] 40.14148　　

　> total_dt1$avg_age[match("山梨県", total_dt1$出身地)]
[1] 39.93554

　> total_dt1$avg_age[match("愛媛県", total_dt1$出身地)]
[1] 39.72601

　> total_dt1$avg_age[match("群馬県", total_dt1$出身地)]
[1] 39.62681
```


- 二番目の数値を確認すると、都道府県別同一域内にとどまっている割合が 0.01くらいが違うか、同一な結果値になりますが、
　これはサンプル数の違いによると思っております。
```
> eval_stay_dt$stay_perc[match("愛知県", eval_stay_dt$出身地)]
[1] 2.829268

> eval_stay_dt$stay_perc[match("岩手県", eval_stay_dt$出身地)]
[1] 2.610442

> eval_stay_dt$stay_perc[match("熊本県", eval_stay_dt$出身地)]
[1] 2.392344

> eval_stay_dt$stay_perc[match("山形県", eval_stay_dt$出身地)]
[1] 2.293121
```


## 出身都道府県別平均年齢
![Chart 1](https://github.com/bhchoi0131/super_adventure/blob/master/Screen%20Shot%202018-01-14%20at%209.24.54%20PM.png)

## 都道府県別同一域内にとどまっている割合
![Chart 2](https://github.com/bhchoi0131/super_adventure/blob/master/Screen%20Shot%202018-01-14%20at%209.25.14%20PM.png)

## 都道府県別平均年齢と同一域内にとどまっている割合の関係
![Chart 3](https://github.com/bhchoi0131/super_adventure/blob/master/Screen%20Shot%202018-01-14%20at%209.25.45%20PM.png)
