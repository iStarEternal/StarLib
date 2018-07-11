//
//  WexNavigationController.h
//  WexWeiCaiFu
//
//  Created by Mark on 15/10/27.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WexNavigationControllerDelegate <NSObject>

@optional
- (BOOL)popGestureEnabled;

@end

@interface WexNavigationController : UINavigationController

@end
