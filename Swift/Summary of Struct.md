
<font color=gray size=2>*It will take about 5 minutes to finish reading this article.*</font>

# **<font size=5 >Summary of Structure</font>**
In Swift, Structures is general-purpose, flexible constructs that become the building blocks of your program’s code
We can define attributes (constants, variables) and add methods for the structure to extend its functions.

## **<font size=3 >1. Structure supports property defaults and initialization constructors</font>**
***
<details>
  <summary>Details</summary>
 We often use the following methods to initialize in OC.

```Swift 
// OCDemoModelBuilder.h
@interface OCDemoModelBuilder : NSObject
@property (nonatomic, copy, nonnull) NSString *a;
@property (nonatomic, copy, nonnull) NSString *b;
@property (nonatomic, copy, nonnull) NSString *c;
@property (nonatomic, copy, nonnull) NSString *d;
@property (nonatomic, copy, nonnull) NSString *e;
@end
// OCDemoModelBuilder.m
@implementation OCDemoModelBuilder

- (instancetype)init {
    if (self = [super init]) {
        _a = @"a";
        _b = @"b";
        _c = @"c";
        _d = @"d";
        _e = @"e";
    }
    return self;
}

@end

// OCDemoModel.h
@interface OCDemoModel : NSObject
@property (nonatomic, readonly, nonnull) NSString *a;
@property (nonatomic, readonly, nonnull) NSString *b;
@property (nonatomic, readonly, nonnull) NSString *c;
@property (nonatomic, readonly, nonnull) NSString *d;
@property (nonatomic, readonly, nonnull) NSString *e;

- (instancetype)initWithBuilder:(void(^)(OCDemoModelBuilder *builder))builderBlock;
@end

// OCDemoModel.m
@implementation OCDemoModel
- (instancetype)initWithBuilder:(void(^)(OCDemoModelBuilder *builder))builderBlock {
    if (self = [super init]) {
        OCDemoModelBuilder *builder = [[OCDemoModelBuilder alloc] init];
        if (builderBlock) {
            builderBlock(builder);
        }
        _a = builder.a;
        _b = builder.b;
        _c = builder.c;
        _d = builder.d;
        _e = builder.e;
    }
    return self;
}

@end

// Usage
OCDemoModel *ret = [[OCDemoModel alloc] initWithBuilder:^(OCDemoModelBuilder * _Nonnull builder) {
    builder.b = @"b1";
}];
```
However, Swift's Struct supports attribute default values and initialization constructors, which greatly simplifies the process. The code is as follows:

```Swift
struct SwiftDemoModel {
    var a = "a"
    var b = "b"
    var c = "c"
    var d = "d"
    var e = "e"
}

// Usage
let ret = SwiftDemoModel(b: "b1")
// ret = a,b1,c,d,e
```
</details>


## **<font size=3 >2. Second Title</font>**
***
 + 第一项
 + 第二项
 + 第三项







