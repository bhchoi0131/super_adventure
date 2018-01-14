# Overview
- This repository is for CBRE.
- Please refer to the test.R file.
<br/>
<br/>

# Report
- 数値が正しいか確認する前に、20個のデータファイルを全部合併した後行数(nrow())がサンプルの数値(N=49,532)と違う結果になります。
  まず、sum(is.na()) =0　で、missing dataは無いのを確信しましたため、49530件のデータを元に処理を進行しました。
```  nrow(data_address)=49530
     nrow(data_hometown)=49530
     nrow(total_dt)=49530
     sum(is.na(total_dt))=0
```

- 数値を確認すると、出身都道府県別平均年齢が 0.002くらいで違う結果値になりますが、これはサンプル数の違いによると思っております。
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


## 出身都道府県別平均年齢
![Chart 1](https://github.com/bhchoi0131/super_adventure/blob/master/Screen%20Shot%202018-01-14%20at%209.24.54%20PM.png)

## 都道府県別同一域内にとどまっている割合
![Chart 2](https://github.com/bhchoi0131/super_adventure/blob/master/Screen%20Shot%202018-01-14%20at%209.25.14%20PM.png)

## 都道府県別平均年齢と同一域内にとどまっている割合の関係
![Chart 3](https://github.com/bhchoi0131/super_adventure/blob/master/Screen%20Shot%202018-01-14%20at%209.25.45%20PM.png)
