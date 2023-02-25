
<font color=gray size=2>*It will take about 1 minutes to finish reading this article.*</font>

# **<font size=5>Stability of algorithm</font>**  
 
Assuming that there are multiple records with the same keyword in the sequence of records to be sorted, if the relative order of these records remains unchanged after sorting, that is, in the original sequence, r [i]=r [j], and r [i] is before r [j], while in the sorted sequence, r [i] is still before r [j], this sorting algorithm is said to be stable; Otherwise, it is called unstable.

For example:  
```Swift 
 (4, 1) (3, 1) (3, 7)（5, 6）
```
  

In this case, it is possible to produce two different results. One is to keep the records of equal key values in relative order, while the other is not:   
```Swift  
(3, 1) (3, 7) (4, 1) (5, 6)（The order is not changed）  
(3, 7) (3, 1) (4, 1) (5, 6)（The order is changed）  
```

## **<font size=3 > Attention </font>**
<strong>Whether an algorithm is stable is not absolute.</strong>

For example, for the Bubble sorting algorithm, it was originally a stable sorting algorithm. If the condition of record exchange is changed to r[j] >= r[j+1], two equal records will exchange positions, thus becoming an unstable algorithm.
 


 