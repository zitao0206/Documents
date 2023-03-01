
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5>The difference between nil in Objective-C and nil in Swift</font>**
 

## **<font size=4>1. Objective-C中的nil</font>**
## **<font size=2 >1.1 概念介绍</font>**
Objective-C 中的 nil（或Nil） 是一个指向空对象的指针。在 Objective-C 中，对象可以是一个实例或者一个类。当一个对象被创建时，它会被分配到内存中，并且会被初始化为零。如果没有将其初始化为其他值，则该对象指针的值为 nil。

在 Objective-C 中，对一个 nil 对象发送消息是有效的，因为该消息不会产生任何操作。这是因为 Objective-C 消息发送的实现方式是通过向对象发送消息的方法调用来实现的，而不是通过对象本身的方法。当对象为 nil 时，调用对象的方法不会有任何影响，因为它本质上是一个空指针。
 
下面是一个示例，展示了在 Objective-C 中使用 nil 的情况：
```Objective-C 
NSString *str = nil;
NSLog(@"The value of str is: %@", str);
```
输出结果：
```Objective-C
The value of str is: (null)
```

## **<font size=2 >1.2 实现原理</font>**
在底层实现上，Objective-C 中的 nil 实际上是一个预定义的宏，用于表示一个空对象指针。在 Objective-C 中，所有对象都是通过指针来访问的，而 nil 实际上就是一个值为 0 的指针。因此，当一个对象被赋值为 nil 时，它实际上是被赋予了一个值为 0 的指针，表示该对象不存在。
```
#define nil __DARWIN_NULL
```
其中，__DARWIN_NULL 是一个指向空地址的空指针常量，定义在 <stddef.h> 中，其代码如下：
```
#define __DARWIN_NULL ((void *)0)
```
因此，在 Objective-C 中，当我们使用 nil 时，实际上就是使用一个指向空地址的空指针常量，用于表示一个空的对象指针。

## **<font size=3 >2. Swift中的nil</font>**
## **<font size=2 >2.1 概念介绍</font>**
在 Swift 中，nil不是一个指向空对象的指针，表示一个缺少值的特殊类型，它不仅仅局限于对象。在 Swift 中，可以使用 nil 来表示任何类型的值，包括基本数据类型（如 Int、Double 等）以及对象类型。

Swift 中的 nil 用于可选类型。如果一个变量或者常量被声明为可选类型，那么它可以包含一个值，也可以是 nil。如果尝试将一个可选类型的变量或常量强制解包（即获取它的实际值），并且该变量或常量当前的值为 nil，那么程序就会崩溃。

下面是一个示例，展示了在 Swift 中使用 nil 的情况：
```Swift
var str: String? = nil
print("The value of str is: \(str)")
```
输出结果：
```Swift
The value of str is: nil
```
上面的代码如果改为如下就会报错：
```Swift
var str: String = nil
```
或者
```Swift
var str = nil
```
错误提示分别如下：
<image src="images/001.png">    
<image src="images/002.png">   
 
那是因为在 Swift 中，变量和常量的类型必须在声明时明确指定。当我们声明一个变量或常量，并将其初始化为 nil 时，Swift 编译器无法确定该变量或常量的类型，因为 nil 可以表示多种类型的缺失值。因此，我们需要通过类型注释或类型推断的方式告诉编译器该变量或常量的类型。

var str: String = nil 声明了一个类型为 String 的变量 str，并将其初始化为 nil。但是，Swift 编译器无法确定该变量的类型，因为 nil 可以表示多种类型的缺失值。因此，编译器会报错，提示我们需要提供上下文类型（Contextual Type）或者对于的可选类型。

## **<font size=2 >2.2 实现原理</font>**
在 Swift 中，所有的类型都可以使用可选类型来表示缺少值的情况。可选类型实际上是一个枚举类型，它有两个可能的值：有值和没有值。当可选类型的值为 nil 时，它实际上是一个特殊的枚举成员，表示该值缺失。
```Swift
enum Optional<T> {
    case none
    case some(T)
}

var str: String? = "hello"
str = nil

if let value = str {
    print("The value of str is: \(value)")
} else {
    print("The value of str is nil")
}
```
输出结果：
```Swift
The value of str is nil
```

## **<font size=3 >3. 总结</font>**

在 Objective-C 中，nil 表示一个指向空对象的指针，用于表示对象不存在。在 Swift 中，nil 表示一个缺少值的情况，可以用于表示任何类型的值。在底层实现上，Objective-C 中的 nil 是一个预定义的宏，表示一个空对象指针，而 Swift 中的 nil 是一个特殊的类型，表示一个可选类型（枚举类型）缺少值的情况。在实际开发中，开发者需要根据不同的情况选择适当的语言和数据类型来表示值的存在或者缺失，以确保程序的正确性和稳定性。