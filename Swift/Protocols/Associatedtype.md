  
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 >Summary of the keyword 'associatedtype'</font>**

In Swift, When defining a protocol, we can’t use generics in a protocol as in a class. The following code is incorrect and will be reported as an error.

<strong> Example Code </strong>
```Swift 
protocol Stackble <Element> { 
    mutating func push(_ element:Element)
    mutating func pop()->Element
    func top() ->Element
    func size() ->Int
}
```
  
Therefore, associated types can solve this problem in Swift. It’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that’s used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.

<strong> Example Code </strong>
```Swift 
protocol Stackble {    
    associatedtype Element 
    mutating func push(_ element:Element)
    mutating func pop()->Element
    func top() ->Element
    func size() ->Int
}
```
Associated types can be applied in situations as follows:
## **<font size=3 >1. Associated type be replaced by concrete type </font>**
 
<strong> Example Code </strong>
```Swift 
class StringStack:Stackble {
    //typealias String = Element
    var elements = [String]()
    func push(_ element:String){   
        
        elements.append(element)
    }
    func pop()->String{
        elements.removeLast()
    }
    func top() ->String{
        elements.last!
    }
    func size() ->Int{
        elements.count
    }
}
```
Thanks to Swift’s type inference, we don’t actually need to declare a concrete Element of String as part of the definition of StringStack. 

## **<font size=3 >2. Associated type be replaced by generic type </font>**
In a class with generics, generic types replace association types.

<strong> Example Code </strong>
```Swift 
class Stack <E>: Stackble {
    //typealias E = Element
    var elements = [E]()  
     func push(_ element:E) {   
        elements.append(element)
    }
     func pop()->E{
        elements.removeLast()
    }
    func top() ->E{
        elements.last!
    }
    func size() ->Int{
        elements.count
    }
}
```

## **<font size=3 >3. Points for Attention </font>**

A protocol contains associated types cannot be used as return values and function parameters.
```Swift 
 protocol Runnable {
    // without any associated types
 }
 class Person : Runnable {
     
 }
 class Car : Runnable {
     
 }
 func get(_ type:Int) -> Runnable {
     if(0 == type) {
         return Person()
     }
     return Car()
 }
 //call as follows:
var r1 = get(0) 
var r2 = get(1)
print("r1=",r1)
print("r2=",r2)
//everything is ok now
 ```
The following is the code of compilation error.
```Swift
protocol Runnable {
    associatedtype Speed
    var speed : Speed {get}
    
}
class Person:Runnable {
    var speed: Double = 0.0
}
class Car:Runnable {
    var speed: Double = 0.0
}

// this code will be reported an error
 fun get (run: Runnable) {}
// this code will be reported an error too.
func get(_ type:Int) -> Runnable { 
    if(0 == type ){
        return Person()
    }
    return Car()
}
```
We can fix this point just by a generic Type that conform to the protocol.
```Swift 
func get<T:Runnable>(_ type:Int)-> T {  
    if  0 == type {
        let result = Person() as! T
        return result
    }
    return Car() as! T
}
```






