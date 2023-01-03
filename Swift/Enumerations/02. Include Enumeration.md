
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 >Inclue Enumeration</font>**

We can also embed enumerations in structures or classes.

<strong>Example Code</strong>

```Swift
struct MyCharacter {
    enum CharacterType {
        case thief
        case warrior
        case knight
   }

   enum Weapon {
       case bow
       case sword
       case lance
       case dagger
   }

   let type: CharacterType
   let weapon: Weapon

}
```
Call as follows:
```Swift 
let warrior = MyCharacter(type: .warrior, weapon: .sword)
```




