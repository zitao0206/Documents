
<font color=gray size=2>*It will take about 1 minutes to finish reading this article.*</font>

# **<font size=5 color=#FFFFFF> Three forms of Closures </font>**
As the Apple official documents says, closures take one of three forms:


### <font size=3 color=#4169E1>**1. Global functions**</font> 
Global functions are closures that have a name and don’t capture any values.
```Swift 
func setupBlock {
    print("Hello")
}
```
It is a special closure.

### <font size=3 color=#4169E1>**2. Nested functions**</font>
Nested functions are closures that have a name and can capture values from their enclosing function. 
```Swift 
func makeIncrementer() -> () -> Int {
    var runningTotal = 10
    // nested function，it is a closure too.
    func incrementer() -> Int{
        runningTotal += 1
        return runningTotal
    }
    return incrementer
}
```
### <font size=3 color=#4169E1>**3. Closure expressions**</font>
Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
```Swift 
{ (param) -> ReturnType in
    // Method body
}
```
Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
1. Inferring parameter and return value types from context
2. Implicit returns from single-expression closures
3. Shorthand argument names
4. Trailing closure syntax

## **<font color=gray size=3 >*Reference Documents*</font>**
<https://docs.swift.org/swift-book/LanguageGuide/Closures.html>  
