  
### Set Read-only permission of the property
In Swift, there is no keyword "readonly" like Objective-C to set read-only access permissions. How can Swift implement read-only access permissions? The following code can be used:

```Swift 
class MyClass {
    private(set) var name: String = "Hello world"
} 
```
It is normal for external read access:
```Swift
let a = ClassA()
print(a.title)
```
But the following is wrong:
```Swift
a.title = "1234"
```
The following errors will be reported:
```Swift
Cannot assign to property: 'title' setter is inaccessible
```






