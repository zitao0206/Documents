
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 >NSString and String</font>**
 

## **<font size=3 >1. Mutual Transformation</font>**
NSString and String can transform to each other.   
<strong> Example Code </strong>
```Swift 
func StringToNSString()  {
    let a = String("1234567890")
    let b = a as NSString
    print(b.integerValue)
    print(b.length)
}

func NSStringToString()  {
    let a : NSString = "1234567890"
    let b = a as String
    print(b)
}
```
## **<font size=3 >2. Differences between NSString and String</font>**
NSString is a subclass of NSObject and that is to say, it is a class that is a reference type.
```Swift 
open class NSString : NSObject, NSCopying, NSMutableCopying, NSSecureCoding {

    open var length: Int { get }
    ...
}
```

However, String is a value type which is a kind of struct.
```Swift 
@frozen public struct String {  
    @inlinable public init()
    ...
}
```
They have some identical APIs, but they also have their own independent APIs.  
```Swift
    var str = String()
    str = "123456"
    var nsStr = NSString();
    nsStr = "123456";
```

<strong>1.1 Similar or Identical APIs</strong>
<details>
<summary>Sample Code</summary>

```Swift
//1. Get the number of characters in the string
print(str.count);   //6
print(nsStr.length);   //6
//2. Prefix/Suffix Operations
var str = "123456";
str.hasPrefix("12") //true
str.hasSuffix("56") //true

var nsStr = NSString(stringLiteral: "123456");
nsStr.hasPrefix("12")   //true
nsStr.hasSuffix("56")   //true
//3. Prefix/Suffix Operations
var str = "123456-11";
str.components(separatedBy: "-");   //["123456", "11"]
var nsStr = NSString(stringLiteral: "123456-22");
nsStr.components(separatedBy: "-"); //["123456", "22"]
//4. Letter case conversion ops for uppercased/lowercased/capitalized
var str = "abc";
print(str.uppercased());    //ABC
print(str.lowercased());    //abc

var nsStr = NSString(stringLiteral: "cba");
print(nsStr.uppercased);    //CBA
print(nsStr.lowercased);    //cba

var str = "abc";
print(str.capitalized);    //Abc

var nsStr = NSString(stringLiteral: "cba");
print(nsStr.capitalized);    //Cba
//5. Strip specific strings ops for trimmingCharacters
let str = "\r abc ";
let strTrimed = str.trimmingCharacters(in: .whitespacesAndNewlines)
print(strTrimed);   //abc

let nsStr = NSString(stringLiteral: "\r cba ");
let nsStrTrimed = nsStr.trimmingCharacters(in: .whitespacesAndNewlines);
print(nsStrTrimed); //cba
//6. Character substitution ops for replacingOccurrences:of:with
let str = "hello String";
let str1 = str.replacingOccurrences(of: "String", with: "world")
print(str1) //"hello world"

let nsStr = NSString(stringLiteral:"hello NSString");
let nsStr1 = nsStr.replacingOccurrences(of: "NSString", with: "world")
print(nsStr1)   //"hello world"

//7. Convert decimal hexadecimal octal data to string
let hexStr = String().appendingFormat("%x",16)//10->16，result:"10"
let oStr = String().appendingFormat("%o",16)//10->8，result:"20"
let dStr = String().appendingFormat("%d",0x10)//16->10，result:"16"
let dStr1 = String(format: "%d", 0o10)//8->10，result: "8"

let hexNSStr = NSString().appendingFormat("%x", 16)//10->16，result:"10"
let oNSStr = NSString().appendingFormat("%o",16)//10->8，result:"20"
let dNSStr = NSString().appendingFormat("%d",0x10)//16->10，result:"16"
let dNSStr1 = NSString(format: "%d", 0o10)//8->10，result: "8"
 
```
</details>

<strong>1.2 Independent APIs</strong>  
1.2.1 Independent APIs of String    
<details>
<summary>Sample Code</summary>

```Swift
//1. isEmpty
var str = String();
str = "123456";
print(str.isEmpty);
//2. sorted()
var str = "215423";
print(str.sorted()); //["1", "2", "2", "3", "4", "5"]

//3. filter()
let str = "12 34 56";
let filter = str.filter { (char) -> Bool in
    char != " "
};
print(filter);//123456

//4. enumerated()
let str = "123456";
for data in str.enumerated() {
    print(data);
}
```
</details>

1.2.2 Independent APIs of NSString
<details>
<summary>Sample Code</summary>

```Swift
// 1. initialize methods
var nsStr = NSString(stringLiteral: "123456");
var nsStr = NSString.init(string: "123456");

// 2. boolValue
var nsStr = NSString(stringLiteral: "123456");
print(nsStr.boolValue);//true

// 3. isEqual()
var nsStr = NSString(stringLiteral: "123456");
print(nsStr.isEqual(to: "123456"));//true

// 4. Numeric Ops
var nsStr = NSString(stringLiteral: "123456")
print(nsStr.intValue);
print(nsStr.floatValue);
print(nsStr.doubleValue);
```
</details>