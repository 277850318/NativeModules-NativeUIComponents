# 原生模块和原生组件

> 前言：鄙人愚钝，经过一个多星期的夜晚，才算对原生模块和原生UI组件有了初步的认识。虽然有些其他原因夹在其中，但是个人觉得这两个东西确实难以理解，对于小白来说，这篇文章还是有些用处的。

## 原生模块

Objective-C中自定义的一些类，这些类当中有实现一些功能的方法，这就是原生模块。而之所以叫原生模块，是因为我们要用rn的思想，在js代码中调用这些方法。

首先，要想在js使用原生模块，自定义的类必须满足以下三个条件：  
1. 实现`RCTBridgeModule`协议  
2. 包含`RCT_EXPORT_MODULE`宏  
3. 包含`RCT_EXPORT_METHOD`宏  

下面我通过一个很简单的练习来讲解原生模块。

### OC代码

=> Test.h

```
#import <Foundation/Foundation.h>
#import <RCTBridgeModule.h>

@interface Test : NSObject <RCTBridgeModule> //必须实现这个协议

@end

```

实现`RCTBridgeModule`协议时需要导入`RCTBridgeModule.h`文件——导入时根据实际情况而定，有可能是双引号也有可能是尖括号。 

=> Test.m

```
#import "Test.h"
#import <RCTLog.h>

@implementation Test
//必须包含这个宏。
//括号中的Test是Javascript中访问这个模块的名字，可以改成其他名字。如果写成"RCT_EXPORT_MODULE()"，则默认就会使用这个Objective-C类的名字,即Test。
RCT_EXPORT_MODULE(Test);

//必须包含这个宏。
//在js中调用时，默认方法名为括号中的第一部分，即"printAction"。方法的定义跟Objective-C相同，只是默认为对象方法，并且没有返回值。
RCT_EXPORT_METHOD(printAction) {
  RCTLogInfo(@"This is my test module!");
}

@end

```
### JS代码

=> index.ios.js

```
import React, { Component } from 'react';
import { AppRegistry, View, NativeModules } from 'react-native';

var Test = NativeModules.Test;  //获取OC代码中的Test类
Test.printAction();  //调用Test类中的printAction方法

class TestX extends Component {


    render() {
        return (
            <View style={{padding: 10}} />
        );
    }
}

AppRegistry.registerComponent('RNInit', () => TestX);

```

运行结果需要在模拟器的调试状态下才能看出。（如果不懂如何调试，请自行从网络上查询）  
或者将文中的 `RCTLogInfo(@"This is my test module!");` 改成 `NSLog(@"This is my test module!");`

## 原生UI组件

如果原生模块理解了，那么原生UI组件就容易理解了。原生UI组件就是使用rn思想，在js代码中使用的iOS开发中的自定义的UIView。

首先，要想在js使用原生UI组件，自定义UI组件时有以下两个步骤：  
1. 自定义一个UIView  
2. 创建RCTViewManager的子类(一定要按照rn的命名规则来规定类名，如下面的RCTTestManager类)  

其中，RCTViewManager的子类必须满足以下两个条件：  
1. 包含RCT_EXPORT_MODULE()宏  
2. 实现-(UIView *)view方法  

代码如下：

### OC代码

=> TestView.m

```
@implementation TestView

- (void)layoutSubviews {
  UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
  myLabel.text = @"This is my test native UI component!";
  myLabel.backgroundColor = [UIColor yellowColor];
  [self addSubview:myLabel];
}

@end

```

=> RCTTestManager.h

```
#import "RCTTestManager.h"

@interface RCTTestManager : RCTViewManager

@end

```

=> RCTTestManager.m

```
#import "RCTTestManager.h"
#import "TestView.h"

@implementation RCTTestManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  return [[TestView alloc] init];
}

@end

```

### JS代码

=> RCTTest.js

```
import React, { Component } from 'react';
var { requireNativeComponent } = require('react-native');

// 将OC代码中的RCTTestManager返回的原生UI组件与react-native中自定义的TestView组件关联起来
var RCTTest = requireNativeComponent('RCTTest', TestView);

export default class TestView extends Component {
    render() {
        return <RCTTest/>;
    }
}

```



=> index.ios.js

```
import React, { Component } from 'react';
import { AppRegistry, View } from 'react-native';
import TestView  from './RCTTest';

class TestX extends Component {


    render() {
        return (
            <View style={{padding: 10}}>
                <TestView style={{width: 500, height: 50, backgroundColor: 'green'}} />
            </View>
        );
    }
}

AppRegistry.registerComponent('RNInit', () => TestX);

```

> 注意：调试过程中，若果对OC代码进行了编写，一定要在xcode中重新编译，切忌直接在模拟器中`command+r`;

[demo](https://github.com/izhentou/NativeModules-NativeUIComponents/tree/master)




# 运行方法

1. 解压后，打开终端，切换到项目根目录，输入`npm install`.
2. 启动npm——`npm start`.
3. 将项目安装iOS模拟器并运行——`react-native run-ios`
