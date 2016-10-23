//
//  Test.m
//  RNInit
//
//  Created by JackChen on 16/10/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

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
