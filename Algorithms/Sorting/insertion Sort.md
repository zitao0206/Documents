
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5>Inserting Sort</font>**
 
<strong><font size=3>1. Description</font></strong>  
插入排序是一种简单直观的排序算法，其基本思想是将一个待排序的序列分为有序区和无序区，每次从无序区中取出一个元素，将其插入到有序区中的合适位置，最终完成排序。由于插入排序的思想类似于打扑克牌时整理牌的过程，因此也称为扑克牌排序。

<strong><font size=3>2. Complexity</font> </strong>  
<strong>最坏时间复杂度：O(n^2)</strong>    
此时，每个元素都需要依次和前面的所有元素进行比较，因此总的比较次数为1+2+...+(n-1) = n(n-1)/2，即时间复杂度为O(n^2)

<strong>最优时间复杂度：O(n) </strong>   
当待排序序列已经有序时，插入排序的时间复杂度为O(n)。此时，只需要将每个元素依次插入到有序区的末尾即可。

<strong>平均时间复杂度: O(n^2) </strong>   
插入排序的平均时间复杂度为O(n^2)。虽然最优情况下的时间复杂度为O(n)，但在大多数情况下，插入排序需要进行大量的比较和移动操作，因此平均时间复杂度为O(n^2)。   
<strong>空间复杂度：O(1)</strong>   
算法只需要一个辅助变量来保存当前元素的值，而不需要额外的空间来存储序列中的元素。   
<strong>是否稳定：稳定<strong>

<strong><font size=3 >3. Implementation</font> </strong>  
```Swift 
func insertionSort<T: Comparable>(_ sourceArray: [T]) -> [T] {
    var sortedArray = sourceArray
    guard sortedArray.count > 1 else {
        return sourceArray
    }
    for i in 1..<sortedArray.count {
        let currentValue = sortedArray[i]  // 当前值
        var j = i - 1 // 有序区间的最后一个元素
        
        while j >= 0 && sortedArray[j] > currentValue { // 找到插入位置
            sortedArray[j + 1] = sortedArray[j] // 移动元素
            j -= 1
        }
        
        sortedArray[j + 1] = currentValue // 插入元素到合适的位置
    }
    return sortedArray
}
```
Execute as follows:
```Swift 
let sourceArray = [9, 7, 4, 2, 1, 8, 0, 3, 6, 5]
let sortedArray = insertionSort(sourceArray)
print(sortedArray) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

## **<font color=gray size=3 >*Reference Documents*</font>**
[[1] Swift实现八种经典排序算法](https://juejin.cn/post/6844903588754358280)   

