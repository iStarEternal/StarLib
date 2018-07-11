//
//  UIResponder+Extensions.m
//  Pythia
//
//  Created by 星星 on 2017/4/28.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "UIResponder+Extensions.h"

static __weak id wex_currentFirstResponder;
@implementation UIResponder (Extensions)


+ (id)wex_currentFirstResponder {
    wex_currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(wex_findFirstResponder:) to:nil from:nil forEvent:nil];
    return wex_currentFirstResponder;
}

- (void)wex_findFirstResponder:(id)sender {
    wex_currentFirstResponder = self;
}

@end
