  
### 随机数的生成
在Swift中仍然可以使用arc4random生成随机数。但是要注意：
> arc4random()使用了arc4密码加密的key stream生成器，产生一个[0, 2^32)区间的随机数，这个函数的返回类型永远是UInt32。

所以下面的代码是有风险的：
```Swift 
let diceCount = 6
let randomResult = Int(arc4random()) % diceCount + 1
print(randomResult)
```
在iPhone 5s以及以上的设备没问题，但是在iPhone 5以及前任32位的设备时，有崩溃的风险。可以采用arc4random的改良版本：
```Swift 
func arc4random_uniform(_: UInt32) -> UInt32
```
它接受一个UInt32的类型数字作为输入，并将结果归化到0到n-1之间。
```Swift
let diceCount: UInt32 = 6
let randomResult = Int(arc4random_uniform(diceCount)) + 1
print(randomResult)
```
下面是一个基于Range的最佳事件代码：
```Swift
func random(in range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return Int(arc4random_uniform(count)) + range.startIndex
}
for _ in 0...100 {
    let range = Range<Int>(1...6)
    print(random(in: range))
}
```






