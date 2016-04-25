#Hodor

This library provides some unversal features a group of categories for UIKit and Foundation. all the categories and features are very usefull and universal, but every one is too small , so we put them together.
it provides:  
* Annotation support for objc, like [java annotation](https://en.wikipedia.org/wiki/Java_annotation)  
* Class Manager for COC(convention over configuration) design or construct some unconfig solution  
* extend GCD features  
* basical categories 

#How to use
##How to use HClassManager

sometimes you want to get all the `sub class of a baseClass`, or you want to get all the `imp class of a protocal`. try this !

first you need register a class to a key

```objective-c   
#define TestProRegKey @"TestProRegKey"

@protocol TestPro <NSObject>

@end


#define AClassRegKey @"AClassRegKey"
@interface A : NSObject

@end

@interface B : A

@end

@interface C : A

@end

@interface D : A

@end



@implementation B
HReg3(AClassRegKey, HRegInfo(TestProRegKey, @"some attr"))
@end

@implementation C
HReg2(AClassRegKey, @{@"attr":@"value"})
@end

@implementation D
HReg(TestProRegKey)
@end

```

then you can find it anywhere like this  
```objective-c  

[HClassManager scanClassForKey:AClassRegKey fetchblock:^(__unsafe_unretained Class aclass, id userInfo) {
	NSLog(@"get sub class: %@, userInfo:%@", NSStringFromClass(aclass), userInfo);
}];
[HClassManager scanClassNameForKey:TestProRegKey fetchblock:^(NSString *aclassName, id userInfo) {
	NSLog(@"get implement class: %@, userInfo:%@", aclassName, userInfo);
}];            
```
and there are some other register/get function for protocal specially
```objective-c  
define HRegForProtocal(pro)
+ (id)getObjectOfProtocal:(Protocol *)protocal;
```


##How to use annotation category
if you want to set some special property to your property of some class.like  
@property (nonatomic, `customkey`) NSString *str;  
and you can do some thing according to this customkey.
there is not a very beautiful solution , but relatively simple.

this is a header file
```objective-c   
@interface AnnotationTestObj : NSNumber
@property (nonatomic) NSString *str;
@property (nonatomic) id ID;
@property (nonatomic) char c;
@property (nonatomic) int *p;
@property (nonatomic) BOOL b;

- (void)func1;
- (void)func2:(int)a withb:(NSString *)b;
+ (void)func3;
- (void)func4;
@end

```
write some annotion like this
```
@implementation AnnotationTestObj

ppx(str, @"a", @(1), @[@"c",@"d"], @{@"e":@(2)})
ppx(ID, @"f")
ppx(c, @"g")
ppx(p,@(2))

ppx(func1, @[@"h",@"i"])
- (void)func1
{
    
}

ppx(func2_withb_, @{@"j":@"k"})
- (void)func2:(int)a withb:(NSString *)b;
{
    
}

ppx(func3, @(5))
+ (void)func3
{
    
}

- (void)func4
{
    
}
@end
```

then you can get these annotions like this

```objective-c 
Class theClass = [AnnotationTestObj class];
while (theClass != [NSObject class]) {
    NSArray *ppList = [NSObject ppListOfClass:theClass];
    for (NSString *ppName in ppList)
    {
        NSArray *ants = [theClass annotations:ppName];
        if (ants) NSLog(@"property:%@ annotations:%@", ppName, ants);
    }

    NSArray *instanceMethods = [NSObject hInstanceMethodNames:theClass];
    NSArray *classMethods = [NSObject hClassMethodNames:theClass];
    NSArray *methods = [instanceMethods arrayByAddingObjectsFromArray:classMethods];
    for (NSString *name in methods)
    {
        NSArray *ants = [theClass annotations:hFormateAnnotationName(name)];
        if (ants) NSLog(@"function:%@ annotations:%@", name, ants);
    }
    theClass = class_getSuperclass(theClass);
}
```

##How to use extend invoke feature
Is your appDelegate very very large? and you want to put these code to a coherenct place. if you has a object , you can use notification to meet the requirement. but if you don't has a object, how ?

you can try use this solution: "extend invoke". it can dispatch invoke to your coherenct place.

first you need add a extend invoke

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //EDI
    H_ExtendInvoke3(&application,&launchOptions);
    
    return YES;
}

```


then in another module write a category like this
```objective-c

@implementation AppDelegate (moduleA)

- (BOOL)moduleA_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"## moduleA extend 'didFinishLaunchingWithOptions'");
    return YES;
}
@end


@implementation AppDelegate (moduleB)

- (BOOL)moduleB_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"## moduleB extent 'didFinishLaunchingWithOptions'");
    return YES;
}
@end

```

##Other categories

Just look at the code. there are some very intersting categories
* `-[NSObject jsonString]` : everything (include your custom object) could be json encode  
* `methodSwizzle`  
* `-[UIApplication getKeyWindowRootController]`  
* `-[UIButton hSetColor:font:title:]`  
* `-[UIColor colorWithHex:]`,`-[UIColor random]`  
* `-[UILabel hSetColor:font:text:]`   
* `UIView.x UIView.y UIView.width, UIView.height, UIView.xmax UIView.ymax`, all the property could read and write  
* `UIView.userInfo` you can save some context info
* `-[UIView removeAllSubViews]`
