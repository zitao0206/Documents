  
### Lazy loading and Anonymous function 
In Swift, we use the lazy keyword before the property to simply implement delayed loading, for example,

```Swift 
lazy var str: String = {
    let str = "Hello" 
    print("Only access the output for the first time")
    return str
}()
```
This style of writing is similar to closure, but it is actually an kind of anonymous function. We can use anonymous functions to initilize data. As shown below, it is an anoymous function creation call operation:
```Swift
{
	//anonymous function code
}()
```
We can try to print the type of this type.
```Swift
func test() {

}
func TestCase() {
    let a: () = {}()
    let b = test
    print(type(of: a))
    print(type(of: b))
}
```
The result is:
```
()
() -> ()
```



