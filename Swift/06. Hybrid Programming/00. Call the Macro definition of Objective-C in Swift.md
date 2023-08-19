
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5 >Call the Macro definition of Objective-C in Swift</font>**
There are usually lots of macro definitions in Objective-C projects, as follows:
```Swift 
#define kScreenScale [UIScreen mainScreen].scale
#define kOnePixelPointValue (1.0f / kScreenScale)
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kApplicationWidth  MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kApplicationHeight MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kScreenCenterX kScreenWidth / 2.0
#define kScreenCenterY kScreenHeight / 2.0
```
Actually, Swift cannot directly use the macro definitions of OC. We need to do some conversions For Swift.

## **<font size=3 >1. Overwrite them with Swift language entirely</font>**

```Swift 
public struct SizeDefault {
    public static let screenScale = UIScreen.main.scale
    public static let onePixelPointValue = (1.0 / screenScale)
    public static let screenWidth = UIScreen.main.bounds.size.width
    public static let screenHeight = UIScreen.main.bounds.size.height
    public static let applicationWidth = min(screenWidth, screenHeight)
    public static let applicationHeight = max(screenWidth, screenHeight)
    public static let screenCenterX = screenWidth / 2.0
    public static let screenCenterY = screenHeight / 2.0
    ...
}
extension UIDevice {
    public static let ako = SizeDefault.self
}
```
I overwrited all the code and wrapped them in the UIDevice extension, then I can use them as follows:
```Swift 
let height = UIDevice.ako.applicationHeight
print(height)
```
This is what I recommend if you have enough time. 

## **<font size=3 >2. Convert them with inline function simply</font>**
In fact, there are some macros that comprise complicated logic code and you don not have enough time or confidence to overwrite them. Therefore, there is a compromise method to meet our requirement quickly and safely.

```Swift
#define isIPhoneXSeries ({  \
    BOOL iPhoneXSeries = NO;  \
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone) { \
        return iPhoneXSeries; \
    } \
    if (@available(iOS 11.0, *)) { \
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window]; \
        if (mainWindow.safeAreaInsets.bottom > 0.0) { \
            iPhoneXSeries = YES; \
        } \
    } \
    iPhoneXSeries; \
})
```
We can just convert it with incline function like that:

```Swift
static inline BOOL isIPhoneXSeries()
{
    BOOL iPhoneXSeries = NO;
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
```
or like this:
```Swift
static inline CGFloat AKOApplicationWidth()
{
    return kApplicationWidth;
}

static inline CGFloat AKOApplicationHeight()
{
    return kApplicationHeight;
}
```
It is very convenient. And then We can use it in our Project like this:
```Swift
isIPhoneXSeries()
```
We can also add it to UIDevice extension like as below:

```Swift
public struct SizeDefault {
  ...
  public static let isIPhoneXSeries = AKOISIPhoneXSeries()
  ...

```




