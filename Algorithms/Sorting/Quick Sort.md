
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5>Quick Sort</font>**
 
<strong><font size=3>1. Description</font></strong>  
快速排序（Quick Sort）是一种高效的排序算法，其基本思想是通过一趟排序将待排序序列分成两个子序列，其中一个子序列的所有元素都小于另一个子序列的所有元素，然后递归地对两个子序列进行排序，直到整个序列有序为止。

快速排序的原理是通过选定一个基准元素，将序列分成两个部分，一个部分所有元素小于等于基准元素，另一个部分所有元素大于等于基准元素。然后，对这两个部分递归地进行快速排序，直到整个序列有序为止。

<strong><font size=3>2. Complexity</font> </strong>  
<strong>最坏时间复杂度：O(n^2)</strong> 
当快排每次选择的枢轴元素都是待排序序列中的最小或最大值时，会导致快排的时间复杂度变为O(n^2)。这种情况下，快排每次只能将序列中的一个元素放到它最终的位置上，而其它元素则需要递归调用快排来排序。   
<strong>最优时间复杂度：O(nlogn) </strong>   
当待排序序列为有序序列或基本有序序列时，快速排序的时间复杂度最优，为O(nlogn)。此时每次划分的两个子序列的长度差最多为1，快排递归树的高度为logn，快排的总时间复杂度为O(nlogn)。   
<strong>平均时间复杂度: O(nlogn)</strong>   
这是由于快排每次划分后，可以将待排序序列分成两个规模相对均衡的子序列，并且每次划分所花费的时间复杂度为O(n)。因此，快排的时间复杂度可以表示为：T(n) = 2T(n/2) + O(n)，其中T(n/2)表示对子序列的递归调用。根据主定理（Master Theorem），可以得到快速排序的平均时间复杂度为O(nlogn)。
<strong>空间复杂度：O(logn)</strong>   
快速排序的空间复杂度为 O(logn)。这是因为快速排序需要递归调用，每次递归都会消耗一定的栈空间。在最坏情况下，即待排序序列已经有序时，快速排序需要递归调用 n 次，每次递归所消耗的栈空间为 O(1)，因此总的空间复杂度为 O(n)。但在平均情况下，每次递归所消耗的栈空间为 O(log n)，因此总的空间复杂度为 O(log n)。需要注意的是，快速排序是一种原地排序算法，即它不需要额外的空间来存储临时数据。因此，它的空间复杂度只需要考虑递归调用所需的栈空间即可。   
<strong>是否稳定：不稳定<strong>

<strong><font size=3 >3. Implementation</font> </strong>  
```Swift 
func quickSort(_ array: inout [Int], left: Int, right: Int) {
    guard left < right else {  // 如果左边界 >= 右边界，说明数组已经有序，直接返回
        return
    }
    
    // 分割数组，并获取基准元素的下标
    let pivotIndex = partition(&array, left: left, right: right)
    
    // 递归排序左半边
    quickSort(&array, left: left, right: pivotIndex - 1)
    // 递归排序右半边
    quickSort(&array, left: pivotIndex + 1, right: right)
}

func partition(_ array: inout [Int], left: Int, right: Int) -> Int {
    let pivot = array[right]  // 取最右边的元素为基准元素
    var i = left  // i 指向数组左边界
    
    for j in left..<right {  // 遍历数组
        if array[j] < pivot {  // 如果当前元素比基准元素小
            array.swapAt(i, j)  // 交换当前元素和 i 指向的元素
            i += 1  // i 向右移动一位
        }
    }
    
    array.swapAt(i, right)  // 将基准元素移动到中间位置
    return i  // 返回基准元素的下标
}

```
Execute as follows:
```Swift 
let sourceArray = [9, 7, 4, 2, 1, 8, 0, 3, 6, 5]
let sortedArray = mergeSort(sourceArray)
print(sortedArray) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

More concise code as follows:  
```Swift 
func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    // 当数组元素个数小于等于1时，直接返回原数组
    guard array.count > 1 else {
        return array
    }
    // 选择中间位置的元素作为基准值
    let pivot = array[array.count/2]
    // 将原数组分成三个部分：小于、等于和大于基准值
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    // 递归调用自身对小于和大于基准值的两部分进行排序
    return quickSort(less) + equal + quickSort(greater)
}
```

## **<font color=gray size=3 >*Reference Documents*</font>**
[[1] Swift实现八种经典排序算法](https://juejin.cn/post/6844903588754358280)   

