
<font color=gray size=2>*It will take about 5 minutes to finish reading this article.*</font>

# **<font size=5 color=#4169E1>Common Crash Scenarios</font>**  
<font size=2 color=#4169E1>Catalogue：</font>    
<font size=2 color=#4169E1>1. "Unrecognized selector sent to instance"</font>     
<font size=2 color=#4169E1>2. "EXC_BAD_ACCESS"</font>      
<font size=2 color=#4169E1>3. Caused by Collection Related</font>   
<font size=2 color=#4169E1>4. "Out of Memory"</font>   
<font size=2 color=#4169E1>5. "Type Cast Exception" or "Type Mismatch"</font>     
<font size=2 color=#4169E1>6. Caused by Deadlock</font>     
<font size=2 color=#4169E1>7. Caused by Stack Overflow</font>    
<font size=2 color=#4169E1>8. Caused by KVO</font>   
<font size=2 color=#4169E1>9. Caused by Multi-threaded</font>   
<font size=2 color=#4169E1>10. Caused by Long connection of Socket</font>   
<font size=2 color=#4169E1>11. Caused by Watch Dog Timeout</font>  

-----------------
### <font size=3 color=#4169E1>**1. "Unrecognized selector sent to instance"**</font> 
<strong>问题分析：</strong>     
"unrecognized selector sent to instance" 是一个 Objective-C 异常，表示尝试调用一个不存在的方法或者消息。这个异常通常会发生在以下情况：
- 在使用 performSelector: 方法时，指定的方法不存在；    
- 在使用 KVO（键值观察）时，观察的属性不存在；  
- 在使用 NSNotificationCenter（通知中心）时，监听的事件不存在；         
- 在使用 NSInvocation（消息调用）时，指定的方法不存在；     
- 在使用 Category（类别）扩展类的时候，没有在头文件中声明方法，而直接在实现文件中实现了方法；       
等等。         

<strong>示例代码：</strong>
<details>
<summary>Objective-C</summary>

```Swift
@interface MyClass : NSObject
- (void)doSomething;
@end

@implementation MyClass
@end

@interface MyOtherClass : NSObject
@end

@implementation MyOtherClass
- (void)doSomethingElse {
    NSLog(@"Doing something else...");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyClass *object = [[MyClass alloc] init];
        [object performSelector:@selector(doSomethingElse)]; // unrecognized selector sent to instance
    }
    return 0;
}
```
</details>

<strong>解决方案：</strong>     
- 方法调用前进行respondsToSelector判断，或者Release模式下使用ProtocolKit给协议添加默认实现防止崩溃，Debug模式下关闭默认实现。
- 利用OC的动态特性，用消息转发的几个方法进行兜底处理。

### <font size=3 color=#4169E1>**2. "EXC_BAD_ACCESS"**</font> 
<strong>问题分析：</strong>         
导致的问题原因有很多：
- 出现悬挂指针（空指针、野指针）
- 对象没有被初始化
- 访问的对象被释放
- 访问越界的集合元素
等等。  

<strong>示例代码：</strong>     
略      
<strong>解决方案：</strong>   
 1、Debug阶段开启僵尸模式，Release时关闭僵尸模式；  
 2、使用Xcode的Address Sanitizer检查地址访问越界；  
 3、创建对象的时候记得初始化；  
 4、对象的属性使用正确的修饰方式（应该用strong/weak，误用了assign）；   
 5、调用block等对象前的时候，做判断；     

### <font size=3 color=#4169E1>**3. Caused by Collection Related**</font> 
<strong>问题分析：</strong>  
导致Crash的场景也有很多：   
1、数组越界，访问下标大于数组的个数；   
2、向数组中添加空数据；     
3、多线程环境中，一个线程在读取，一个线程在移除；        
4、多线程中操作可变数组（数组的扩容、访问僵尸对象）；   

<strong>示例代码：</strong>  

```Swift 
// 越界访问，会导致 Crash
let array = [1, 2, 3]
let item = array[3] // 越界访问，会导致 Crash
```

```Swift
// 强制解包可选类型时，如果值为 nil，会导致 Crash
var dict: [String: String?] = ["key1": "value1", "key2": "value2"]
let value = dict["key1"]! 
```
```Swift
// 强制解包可选类型时，如果值为 nil，会导致 Crash
var set: Set<String?> = ["value1", "value2", nil]
let value = set.first! // 强制解包可选类型时，如果值为 nil，会导致 Crash
```

<strong>解决方案：</strong>  
1、在使用字典和集合时，检查键和值是否为nil（使用 guard、if let等语法来避免强制解包时的Crash）；
2、使用扩展重写原来的方法，在内部做判断；   
3、在OC中，使用Runtime把原来的方法替换成自定义的安全方法；  
4、多线程操作数组时，要保证读写操作的原子性，例如加锁或者其他保护措施；

```Swift
//使用 Swift 提供的 safe subscript 扩展来避免访问数组越界
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

let array = [1, 2, 3]
let item = array[safe: 3] // 不会导致 Crash，item 为 nil
```


### <font size=3 color=#4169E1>**4. "Out of Memory"**</font> 
<strong>问题分析：</strong>  
在iOS应用程序中，如果应用程序分配了太多的内存而导致系统内存不足，就会出现OOM错误。在 iOS 设备上，每个应用程序都有其自己的内存限制。当应用程序需要分配更多内存时，如果没有足够的可用内存，系统就会自动触发 OOM 错误，终止应用程序并将其从内存中释放。
- 应用程序尝试在内存不足的情况下分配大量的内存；
- 应用程序内存泄漏，导致内存占用过高；
- 应用程序使用的内存与系统资源不匹配，导致内存占用过高；    
等等。

<strong>示例代码：</strong>  
```Swift
var array = [Int]()
while true {
    array.append(1)
}
```

<strong>解决方案：</strong>  
为避免 OOM，可以采取以下措施：  
1、使用合适的数据结构，避免不必要的内存占用；   
2、排查内存泄漏；
3、及时释放不需要的内存，比如在使用完大内存对象后，调用 autoreleasepool 进行释放；  
4、减少对象的创建，可以使用对象池等技术，重复使用已有的对象，而不是频繁地创建和销毁对象；   
5、对于大内存对象，可以使用 lazy-loading 等技术，在需要时才进行加载，减少内存占用。
 

### <font size=3 color=#4169E1>**5. "Type Cast Exception"or "Type Mismatch"**</font> 
<strong>问题分析：</strong>   
Type Cast Exception或Type Mismatch 是指在类型转换过程中发生异常，导致应用程序崩溃。在 iOS 开发中，常见的场景包括：     
- 从一个类型的实例向另一个类型的实例进行转换时，类型不匹配导致崩溃；
- 从 AnyObject 向具体类型进行转换时，类型不匹配导致崩溃；
- 从可选类型向非可选类型进行强制解包时，变量为 nil 导致崩溃。

<strong>示例代码：</strong>  
```Swift
 let array: [Any] = ["A", "B", "C"]
 let str = array[0] as! Int
 //Error: Could not cast value of type 'Swift.String' (0x7ff8553bc178) to 'Swift.Int' (0x7ff8553be0e0).
```

<strong>解决方案：</strong>  
- 在进行类型转换前，先判断对象是否是目标类型的实例，可以使用 is 关键字进行判断；
- 使用可选绑定，避免在类型转换时发生异常。
  
比如在上面的示例中，可以使用以下代码进行改进：
```Swift
let array: [Any] = ["A", "B", "C"]
if let obj = array[0] as? Int {
    
}
```

### <font size=3 color=#4169E1>**6. Caused by Deadlock**</font> 
<strong>问题分析：</strong>   
Deadlock 是指两个或多个线程在互相等待对方完成操作，导致程序无法继续执行的情况。在 iOS 中，最常见的 Deadlock 是在主线程中执行了一个同步操作，该操作需要等待另一个线程执行完毕才能继续，而另一个线程正好在等待主线程执行完毕，从而导致死锁。

<strong>示例代码：</strong>  
在下面的代码中，当主线程调用 queue.sync 方法时，它会等待 Block 1 的执行完成。而在 Block 1 中，又会调用 queue.sync 方法，导致线程进入等待状态。由于 Block 2 依赖于线程释放锁才能执行，因此整个程序陷入死锁状态，无法继续执行。
```Swift
let queue = DispatchQueue(label: "com.example.queue")
queue.sync {
    print("Block 1")
    queue.sync {
        print("Block 2")
    }
}
print("Done")
```
<image src="images/001.png">

<strong>解决方案：</strong> 
- 避免在主线程中执行长时间的同步操作，可以将其放到后台线程中执行；
- 避免在同一个队列中执行互相等待的同步操作，可以使用异步操作代替同步操作；
- 避免在多个队列中使用同步操作导致死锁，可以使用异步操作代替同步操作，或者使用 dispatch_group 等技术解决；

在上面的示例中，可以将同步操作替换为异步操作，代码如下：
```Swift
let queue = DispatchQueue(label: "com.example.queue")
queue.async {
    print("Block 1")
    queue.async {
        print("Block 2")
    }
}
print("Done")

```

### <font size=3 color=#4169E1>**7. Caused by Stack Overflow**</font> 
<strong>问题分析：</strong>   
Stack Overflow（栈溢出）通常发生在递归调用中，如果递归没有终止条件或终止条件不正确，则递归深度会一直增加，直到栈空间被耗尽，导致栈溢出。
另外，如果一个方法调用另一个方法时，调用栈深度过深也会导致栈溢出。
<strong>示例代码：</strong>  
```Swift
func recursiveFunction() {
    recursiveFunction()
}
recursiveFunction() 
```
<strong>解决方案：</strong>  
- 优化算法：优化递归算法，减少调用栈的深度。例如，使用迭代而不是递归算法。  
- 增加栈空间：可以通过更改线程栈大小或使用 GCD 的 dispatch_set_concurrency 函数来增加可用栈空间。
- 减少栈空间使用：可以通过减少函数调用时分配的局部变量、减少嵌套调用或使用尾递归等技术来减少栈空间使用。
- 使用尾递归：尾递归是指递归函数中的最后一个操作是递归调用本身。在 Swift 中，可以使用 @_optimize(speed) 和 @_optimize(safety) 属性标记函数，以便编译器能够进行尾递归优化。
- 避免无限递归：确保递归算法有正确的终止条件，否则递归深度将无限增加，最终导致栈溢出。
- 使用栈空间更小的数据结构：对于大量递归算法，可以使用栈空间更小的数据结构，例如链表或队列等。

### <font size=3 color=#4169E1>**8. Caused by KVO**</font> 
<strong>问题分析：</strong>   
KVO（Key-Value Observing）是Cocoa框架中的一种观察者模式，可以让对象在其他对象的属性值发生改变时得到通知。当使用KVO时，如果没有及时移除观察者，或者观察者对象已经被释放，那么就会导致Crash。
<strong>示例代码：</strong>  
略（Objective-C）       
<strong>解决方案：</strong>  
1. 及时移除观察者以及观察者对象需要存在；
2. 使用KVO的最佳实践：
- 只在需要的时候使用KVO，避免滥用；
- 使用Swift的Property Observers替代KVO；
- 使用闭包或Notification Center替代KVO；
- 在移除观察者时使用正确的方法，避免遗漏；
- 避免使用字符串作为keyPath，可以使用静态变量或常量替代，或者使用Swift 4引入的#keyPath()方法获取keyPath。

### <font size=3 color=#4169E1>**9. Caused by Multi-threaded**</font> 
<strong>问题分析：</strong>   
iOS中由多线程引起的Crash是一个常见的问题，可能会在不同的场景下发生。以下是一些可能导致多线程Crash的场景、示例代码和解决方案的介绍。         
- 多个线程同时访问同一个共享的数据结构或变量，没有进行同步或加锁。
- 在多线程环境下使用不安全的数据结构或API，比如使用非线程安全的可变集合类Array。
- 在一个线程中调用了一个需要长时间运行的操作（比如网络请求或I/O操作），导致UI线程被阻塞。
- 在子线程中更新UI；    

一般多线程发生的Crash，会收到SIGSEGV信号，表明试图访问未分配给自己的内存, 或试图往没有写权限的内存地址写数据。
<strong>示例代码：</strong>  
下面是一个简单的示例代码，展示了由多线程引起的Crash的场景和问题：   
```Swift
var array = [Int]()
DispatchQueue.global().async {
    for i in 0..<100 {
        array.append(i)
    }
}

DispatchQueue.global().async {
    for i in 100..<200 {
        array.append(i)
    }
}
```
运行后：
<image src="images/002.jpeg">

<strong>解决方案：</strong>  
下面是三个可能的解决方案，可以帮助您避免多线程Crash的问题：
1. 使用线程安全的数据结构或API，比如使用NSLock或dispatch_semaphore_t等方式进行同步。
```Swift
let lock = NSLock()
DispatchQueue.global().async {
    lock.lock()
    for i in 0..<100 {
        array.append(i)
    }
    lock.unlock()
}
DispatchQueue.global().async {
    lock.lock()
    for i in 100..<200 {
        array.append(i)
    }
    lock.unlock()
}
```
2. 使用GCD进行线程间通信，避免在主线程上进行长时间运行的操作。
```Swift
DispatchQueue.global().async {
    let data = getData() // 长时间运行的操作
    DispatchQueue.main.async {
        self.updateUI(with: data) // 在主线程上更新UI
    }
}
```
上面的代码在后台线程上执行长时间运行的操作，并使用GCD将结果发送到主线程以更新UI。
3. 使用串行队列确保对同一对象的操作按顺序执行。
```Swift
let serialQueue = DispatchQueue(label: "com.example.serialQueue")

serialQueue.async {
    self.updateUI(with: data1) // 操作1
}

serialQueue.async {
    self.updateUI(with: data2) // 操作2
}
```

### <font size=3 color=#4169E1>**10. Caused by Long connection of Socket**</font> 
<strong>问题分析：</strong>  
当服务器close一个连接时，若client端接着发数据。根据TCP协议的规定，会收到一个RST响应，client再往这个服务器发送数据时，系统会发出一个SIGPIPE信号给进程，告诉进程这个连接已经断开了，不要再写了。而根据信号的默认处理规则，SIGPIPE信号的默认执行动作是terminate(终止、退出),所以client会退出。

<strong>示例代码：</strong>  
```Swift
class SocketManager {
    
    private var inputStream: InputStream?
    private var outputStream: OutputStream?
    private let host: String = "localhost"
    private let port: Int = 12345
    
    func connect() {
        Stream.getStreamsToHost(withName: host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        inputStream?.open()
        outputStream?.open()
    }
    
    func disconnect() {
        inputStream?.close()
        outputStream?.close()
    }    
}

```

<strong>解决方案：</strong> 
下面是三个可能的解决方案，可以避免由Socket长连接导致的Crash问题：   
第一、在应用进入后台时，立即关闭Socket连接；
```Swift
func applicationWillResignActive(_ application: UIApplication) {
    socketManager.disconnect()
}
```
第二、在应用中使用后台运行模式时，正确处理Socket连接的情况。
```Swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    if application.backgroundTimeRemaining < 60 {
        socketManager.disconnect()
    }
    
    // 在这里执行后台任务
}

```
上面的代码展示了在使用Background Fetch时，检查应用的剩余后台运行时间，如果不足1分钟就关闭Socket连接。

第三、使用signal(SIGPIPE,SIG_IGN)，将SIGPIP交给系统处理，这么做将SIGPIPE设为SIG_IGN，使客户端不执行默认操作，即不退出。

### <font size=3 color=#4169E1>**11. Caused by Watch Dog Timeout**</font> 
<strong>问题分析：</strong>   
Watchdog Timeout是iOS系统自带的一个监控机制，用于检测应用程序在主线程中执行的代码是否超过了规定的时间。如果超时，则系统会自动终止应用程序的执行，以避免应用程序因为卡顿而给用户带来不好的使用体验。
Watchdog Timeout一般会发生在执行耗时操作时，比如网络请求、IO操作、大量数据的处理等。如果不正确地处理这些耗时操作，就容易导致Watchdog Timeout的出现，从而导致应用程序Crash。

<strong>示例代码：</strong>  
例如，在主线程中执行以下操作，有可能触发Watchdog超时。
```Swift
func doHeavyWork() {
    for i in 1...1000000000 {
        // 执行大量的循环操作
    }
}
```

<strong>解决方案：</strong>     
第一、将耗时操作放到子线程中执行。这样可以避免占用主线程时间过长，从而避免Watchdog Timeout的出现。可以使用GCD或者NSOperationQueue等方式来实现。         
第二、使用异步方式执行耗时操作，并且使用合适的队列来管理执行。比如，使用DispatchQueue.global()来创建全局队列，然后使用async方法异步执行任务。另外，也可以使用NSOperationQueue来管理任务。           
第三、使用定时器或者RunLoop等方式，周期性地执行耗时操作，并且在执行之前判断一下是否超过了Watchdog Timeout设置的时间。如果超时，则停止执行，并且将任务放到下一次执行。       
第四、如果必须在主线程中执行耗时操作，可以使用NSRunLoop来控制执行时间，并且定期调用run方法，保证Watchdog Timeout设置的时间不被超过。


## **<font color=gray size=3 >*Reference Documents*</font>**
1. [iOS中常见Crash总结](https://juejin.cn/post/6844903775203753997)   
2. [iOS中常见Crash总结以及解决方案](https://juejin.cn/post/6978014329333350430)  
 

