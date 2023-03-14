
<font color=gray size=2>*It will take about 3 minutes to finish reading this article.*</font>

# **<font size=5>Summary Of Memory Leak</font>**

Questions about Memory leak (memory leak), if the interview was asked this question and such questions, mainly related to the following 3 aspects.
- What are the common scenarios of memory leaks, and list a few common examples?
- How to locate and solve memory leaks that actually occur during development?
- How to avoid memory leaks in development and what are the methods?    

Below we summarize these 3 aspects respectively.

## **<font size=4>Common scenarios for Memory Leak</font>**
<strong>1. Circular References</strong>   
Under the ARC mechanism, circular references are a major cause of memory leaks, and it is also divided into many specific scenarios, such as
- Circular references between two class objects.
- Circular reference problems in Blocks (including GCD or other system Blocks, etc.).
- circular reference problem in Timer. 
- circular reference problem brought by delegate.
- scenarios such as property observation and listening classes.   
  
<strong>2. improper object life cycle management</strong>   
This kind needs to be analyzed in the context of actual business problems, e.g.
- Static fields or other global objects lead to improper holding causing memory leaks.
- The reference relationship of collection classes, etc. is improper or not released in time, etc.   

<strong>3. untimely release of objects</strong>   
Some objects require manual memory release, such as the Core Foundation (CF) and Core Graphics (CG) framework objects. If these objects are not released in time, it may lead to memory leaks.   

<strong>4. Untimely closure or release of resources</strong>   
Untimely closure (or failure to release) of resource classes is also a common memory leak scenario, for example
- The file is opened (FileHandle) and not closed in time.
- The URLSession object of a network request is not released in time.


## **<font size=4>How to locate and solve the memory leak</font>**

In fact, after finding the problem, it is basically easy to solve, for example:

Circular reference means to break the cycle by using weak; If the life cycle of the object is improper, the holder can be changed or the code needs to be redesigned; CF or CG objects need to be released manually; The occupation of resource class also needs to be released manually in time.

But the main problem is how to find the leaked code.

<strong>**<font size=3>1. Manual debugging method</font>**  </strong>

When we realize that there is a leak, there are usually obvious symptoms, such as VC Pop failure.

If we are familiar with the code, generally, I believe many people will directly find the code for manual debugging. Common means include:

- Override dealloc or deinit methods

We can try to add a log to the dealloc or deinit method breakpoint of some classes. If there is no expected execution, it is a suspected leak point.

- Manually check reference count

Manually checking the reference count of an object can help us find out whether there is a memory leak caused by a reference count error. We can manually check the reference count of an object using the retentCount property in Objective-C or Swift.

- Write some extra test code

If the memory leak point is relatively obscure, it can be reproduced by writing code of some test cases, such as 9999 consecutive cycles to expand the problem and cause memory exhaustion and crash, and then locate the code according to the stack, which is also a common method to locate probabilistic crashes;

- One-by-one ranking method

Comment out the code of the problem one by one until the problem point is found. Similar methods are often used to troubleshoot the crash problem during development. Although it looks very low, it is very effective.

<strong>**<font size=3>2. Tools</font>**  </strong>

There are many ways to use this, such as:

- Instruments toolbox, which uses Leaks tool or memory debugger Analyze to analyze;

- The Memory Graph in Xcode Memory Debugger can help us analyze the memory reference relationship of objects and find circular references and memory leaks.

- Third-party detection tools, such as MLeaksFinder, FBRetainCycleDetector, LeakDetector, HeapInspector, etc.

- Static analysis tools, such as Clang static analyzer, Infer, OCLint, SwiftLint and other tools. These tools generally find some memory leak code incidentally, which can give us some tips or warnings.
  
## **<font size=4>How to avoid Memory Leak?</font>**
In actual development, it is unlikely that writing a piece of code to run the tools of Instrument immediately, even some MLeaksFinder these often false alarm tools are too annoying to close directly.
Then How can we avoid and minimize the generation of problem code?

First, there should be some risk awareness. For example, Timer since the choice of it, you should know that its biggest risk is easy to cause memory problems. Know by heart some scenarios that can easily lead to leaks. Also, for example, be careful with global variables or single instances, etc.

Second, get into some habits. For example, after writing a piece of code or receiving a piece of code, make sure the object is expected to be released at the dealloc or deinit breakpoint. Also for example, Swift as far as possible to take the value type, rather than reference types; development after self-test, some memory detection tools are turned on as an aid to detection.

Third, good system design. Some business scenarios are easy to generate leakage, for example, once I participated in the development of a live business, the room VC and the room's only data model object dataModel is easy to refer to each other, because the dataModel carries a lot of business information, the business is extremely dependent on the dataModel, the object is therefore also passed very deep and wide, and a circular reference occurs easily. For this kind of improper design at the beginning, only a patch can be fixed later (maintain a dataModel weak reference collection, each time you use the id to query and get the corresponding room dataModel object, the business only needs to maintain an id String object or a dictionary object to store the least information). Similar business scenarios are commodity detail pages and so on.

Fourth, the regular project code to do a "physical examination", the general project volume is larger, this is very necessary, run the Instrumentation or Memory Graph, almost every time there are gains.
 

