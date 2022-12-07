  
### Generation of random numbers
In Swift, we can still use the ** arc4random ** method to obtain random numbers. However, it should be noted that:
> Arc4random() uses the key stream generator encrypted by Arc4 password to generate a random number in the interval [0, 2 ^ 32). The return type of this function is always UInt32.

```Swift 
let faceCount = 6
let randomResult = Int(arc4random()) % faceCount + 1
print(randomResult)
```
The above code is not a problem on 64 bit machines, but there is a risk of crash if you may encounter iPhone 5 and its previous devices. In this case, it is relatively safe to use an improved version:

```Swift
func arc4random_uniform(_: UInt32) -> UInt32
```
It accepts a UInt32 type number as input, and reduces the result to 0 to n-1.
```Swift
let faceCount: UInt32 = 6
let randomResult = Int(arc4random_uniform(faceCount)) + 1
print(randomResult)
```
The following is a best practice based on Range:
```Swift
func random(in range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return  Int(arc4random_uniform(count)) + range.startIndex
}
for _ in 0...100 {
    let range = Range<Int>(1...6)
    print(random(in: range))
}
```
 






