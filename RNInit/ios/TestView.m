//
//  TestView.m
//  RNInit
//
//  Created by JackChen on 16/10/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)layoutSubviews {
  UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
  myLabel.text = @"This is my test native UI component!";
  myLabel.backgroundColor = [UIColor yellowColor];
  [self addSubview:myLabel];
}

@end
