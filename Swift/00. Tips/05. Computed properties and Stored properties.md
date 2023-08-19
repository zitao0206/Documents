
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 color=#FFFFFF>Computed properties and Stored properties</font>**
<strong> Example Code </strong>
```Swift 
//arr1
var arr1:[Int] =  {
    return [1,2,3];
}()
//arr2
var arr2:[Int] {
    return [1,2,3];
}
//arr3
var arr3:[Int] {
    get {
        return [1,2,3];
    }
}
//arr4
var arr4:[Int] {
    get {
        return [1];
    }
    set {
        print(newValue);
    }
}
```
> arr1 declares a Stored-Property assigned value through a closure operation.    
> arr2 declares a read-only Computed-Property.    
> arr3 declares a read-only Computed-Property too.    
> arr4 declares a read-write Computed-Property too.

It can be seen that the Stored-Property can be directly read and written. The Computed-Property cannot be operated directly. It is only used for calculation and has no specific value.

> Note:
> 1. Computed-Properties can be used for classes, structures, and enumerations, while Stored-Properties can only be used for classes and structures.    
> 2. The Stored-Properties can be defined with the keyword 'var' or the keyword let'. The Computed-Property can only be defined with the keyword 'var'.   
> 3. Computed-Properties do not directly store values, but provide a getter and an optional setter to indirectly obtain and set the values of other properties or variables.

 
## **<font color=gray size=3 >*Reference Documents*</font>**
<https://cloud.tencent.com/developer/article/1610855>  
