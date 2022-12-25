
<font color=gray size=2>*It will take about 1 minutes to finish reading this article.*</font>

# **<font size=5 color=#FFFFFF>Define a singleton</font>**

We can define a singleton in OC like this:
```Swift
+ (instancetype) sharedManager {
    static Object *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[Object alloc] init];
    });
    return obj;
}
```
Use dispatch_once_t in GCD can ensure that the code in it is called only once, so as to ensure the safety of the singleton on the thread. However, since the original Dispatch once method is abandoned in Swift, dispatch_once_t cannot be used to create a singleton. 'Let' is a simpler way to ensure thread safety. So the final code is as follows：

<strong> Example Code</strong>
```Swift 
final class SingleOne {
    static let shared = SingleOne()
    private init() {}

    var first: Bool = false
    var second: String = ""
}
```

## **<font color=gray size=3 >*Reference Documents*</font>**
 <https://blog.csdn.net/LiqunZhang/article/details/115127156>
