
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5>Merge Sort</font>**
 
<strong><font size=3>1. Description</font></strong>  
归并排序（Merge Sort）是一种基于分治法的排序算法，它的主要思想是将一个待排序的序列拆分成若干个子序列，对每个子序列进行排序，最后将排好序的子序列合并起来，得到完整的有序序列。

归并排序的原理是通过不断地将待排序序列一分为二，直到每个子序列中只有一个元素为止。然后，将相邻的子序列两两合并，合并时保证每个子序列都是有序的，直到最后合并成为完整的有序序列。

<strong><font size=3>2. Algorithm complexity</font> </strong>  
归并排序的时间复杂度计算过程如下：  
利用二分分割的后左右两侧的时间复杂度：T(n/2) + T(n/2)，合并过程的时间复杂度为C(n)，所以，最终的时间复杂度计算式为：n > 1时，T(n) = T(n/2) + T(n/2) + C(n) (n < 1时，T(n) = 0)。    
<strong>最优时间复杂度：  </strong> 
当刚好一个序列的最后一个值是另一个序列的最小值时， 
C(n) = n/2, T(n) = 2*T(n/2) + n/2 = 2 * (2 * T(n/4) + C(n/4))
= ... = 2^k * T(n/2^k) + k*n/2 
∵ 2^k = n, ∴ k = log₂n
= n * log₂n / 2 + n * T(1) = n*log₂n / 2 ∈ O(n*log₂n)       
<strong>最坏时间复杂度：  </strong> 
当两个序列各个元素的大小交叉排列时
C(n) = n-1，T(n) = 2 * T(n/2) + n - 1, 同理可得：
= n*log₂n + n - 1 ∈ O(n*log₂n)  
<strong>平均时间复杂度：O(n*log₂n)</strong>  
<strong>空间复杂度：O(n)  <strong>  
<strong>是否稳定：稳定<strong>
 

<strong><font size=3 >3. Implementation</font> </strong>  
```Swift 
func mergeSort<T: Comparable> (_ sourceArray: [T]) -> [T] {
    // 如果数组长度小于等于1，则无需排序，直接返回
    guard sourceArray.count > 1 else {
        return sourceArray
    }
    
    // 将数组一分为二
    let kCount = sourceArray.count
    let middleIndex = kCount / 2
    let leftArray = mergeSort(Array(sourceArray[0..<middleIndex]))
    let rightArray = mergeSort(Array(sourceArray[middleIndex..<kCount]))
    
    // 合并两个有序数组
    return merge(leftArray, rightArray)
}

// 合并两个有序数组
func merge<T: Comparable> (_ leftArray: [T], _ rightArray: [T]) -> [T] {
    // 左右两个数组的索引值
    var leftIndex = 0
    var rightIndex = 0
    
    // 合并后的有序数组
    var mergedArray = [T]()
    
    // 左右两个数组的长度
    let leftCount = leftArray.count
    let rightCount = rightArray.count
    
    // 比较左右两个数组中的元素，将较小的元素放入合并后的数组中
    while leftIndex < leftCount && rightIndex < rightCount {
        if leftArray[leftIndex] < rightArray[rightIndex] {
            mergedArray.append(leftArray[leftIndex])
            leftIndex += 1
        } else {
            mergedArray.append(rightArray[rightIndex])
            rightIndex += 1
        }
    }
    
    // 将剩余的元素放入合并后的数组中
    return mergedArray + Array(leftArray[leftIndex..<leftCount]) + Array(rightArray[rightIndex..<rightCount])
}
```
Execute as follows:
```Swift 
let sourceArray = [9, 7, 4, 2, 1, 8, 0, 3, 6, 5]
let sortedArray = mergeSort(sourceArray)
print(sortedArray) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

## **<font color=gray size=3 >*Reference Documents*</font>**
[[1] Swift实现八种经典排序算法](https://juejin.cn/post/6844903588754358280)   
[[2] 归并排序时间复杂度分析](https://zhuanlan.zhihu.com/p/341225128)

