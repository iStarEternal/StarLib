//
//  WexRichString.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WexRichString : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) BOOL isLink;
@property (nonatomic, copy) NSString *linkFlag;

@end
