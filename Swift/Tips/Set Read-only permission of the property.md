  
<font color=gray size=2>*It will take about 1 minutes to finish reading this article.*</font>

# **<font size=5 >Set Read-only permission of the property</font>**
  
In Swift, there is no keyword "readonly" like Objective-C to set read-only access permissions. How can Swift implement read-only access permissions? We can do this as follows:

```Swift 
class MyClass {
    private(set) var name: String?
} 
```
External access is normal:
```
let a = ClassA()
print(a.title)
```
But the following is wrong:
```
a.title = "1234"
```
The following errors will be reported:
```
Cannot assign to property: 'title' setter is inaccessible
```













