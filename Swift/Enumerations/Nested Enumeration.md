
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 >Nested Enumeration</font>**
 
 <strong>Example Code</strong>

```Swift
enum Character {
  enum Weapon {
    case Bow
    case Sword
    case Lance
    case Dagger
  }
  enum Helmet {
    case Wooden
    case Iron
    case Diamond
  }
  case Thief
  case Warrior
  case Knight
}
//Access like this:
let character = Character.Thief
let weapon = Character.Weapon.Bow
let helmet = Character.Helmet.Iron
```
When accessing nested enumeration members, it is not necessary to enter such a long level every time to access them. You can use convenient methods to access them directly.

```Swift
func strength(of character: Character, 

              with weapon: Character.Weapon, 

              and armor: Character.Helmet) {

}
strength(of: .thief, with: .bow, and: .wooden)

```






