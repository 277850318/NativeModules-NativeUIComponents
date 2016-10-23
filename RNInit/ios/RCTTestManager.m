//
//  TestUIView.m
//  RNInit
//
//  Created by JackChen on 16/10/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RCTTestManager.h"
#import "TestView.h"

@implementation RCTTestManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  return [[TestView alloc] init];
}

@end
