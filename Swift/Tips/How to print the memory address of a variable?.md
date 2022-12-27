
<font color=gray size=2>*It will take about 1 minutes to finish reading this article.*</font>

# **<font size=4 color=#FFFFFF>How to print the memory address of a variable?</font>**

We can print the memory address of a variable like this:
```Swift
var a = 100
withUnsafePointer(to: &a) {ptr in print(ptr)}
//result: 0x00007ff7bfeff210
```
Or using the following method is OK:
```Swift
func printPointer<T>(ptr: UnsafePointer<T>) {
    print(ptr)
}
var a = 100
printPointer(ptr: &a)
//result: 0x00007ff7bfeff220
```