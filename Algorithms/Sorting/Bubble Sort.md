
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5>Bubble Sort</font>**
 
<strong><font size=3>1. Description</font></strong>  
Bubble sort is a simple sorting algorithm that repeatedly traverses the array to be sorted, compares adjacent elements, and swaps them if necessary until the entire array is sorted in ascending or descending order. The name of the algorithm comes from the fact that larger elements "bubble" to the end of the array during each comparison.

<strong><font size=3>2. Algorithm complexity</font> </strong>  
Time Average Complexity: O(N^2)   
Worst Complexity: O(N^2)   
Best Complexity: O(N)   
Space Complexity: O(1)   
Stable Or Not: Yes 
 

<strong><font size=3 >3. Implementation</font> </strong>  
```Swift 
func bubbleSorting(_ sourceArray: [Int]) -> [Int] {
    // 判断数组长度是否大于1，如果不是，则返回原数组
    guard sourceArray.count > 1 else {
        return sourceArray
    }
    
    // 将原数组复制一份，避免修改原数组
    var sortedArray = sourceArray
    
    // 待排序数组的长度
    let kCount = sortedArray.count
    
    // 外层循环，控制循环次数
    for i in 0 ..< kCount {
        // 内层循环，每次都会将当前最大的元素移动到数组的末尾
        for j in 0 ..< kCount - 1 - i {
            // 如果前一个元素大于后一个元素，则交换它们的位置
            if sortedArray[j] > sortedArray[j+1] {
                let tempValue = sortedArray[j]
                sortedArray[j] = sortedArray[j+1]
                sortedArray[j+1] = tempValue
            }
        }
    }
    
    // 返回排序后的数组
    return sortedArray
}

```
Execute as follows:
```Swift 
let sourceArray = [9, 4, 7, 2, 1, 8, 0, 3, 6, 5]
let sortedArray = bubbleSorting(sourceArray)
print(sortedArray) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

Template code as follows:   
```Swift 
func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    var sortedArray = array
    let kCount = sortedArray.count
    for i in 0..<kCount {
        for j in 1..<kCount-i {
            if sortedArray[j] < sortedArray[j-1] {
                sortedArray.swapAt(j, j-1)
            }
        }
    }
    return sortedArray
}

```

## **<font color=gray size=3 >*Reference Documents*</font>**
<https://juejin.cn/post/6844903588754358280>  

