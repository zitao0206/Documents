
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 >Recursive Enumeration</font>**

Enumerations and cases can be marked as indirect, which means that their associated values are stored indirectly, which allows us to define recursive data structures.
<strong>Example Code</strong>

```Swift
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// or 
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```
Call as follows:
```Swift 
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right) // (5 + 4) * 2
    }
}
print(evaluate(product))

// “18”
```




