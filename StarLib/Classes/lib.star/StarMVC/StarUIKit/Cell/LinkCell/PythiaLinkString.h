//
//  PythiaLinkString.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PythiaLinkString : NSObject

@property (nonatomic, copy)     NSString    *string;
@property (nonatomic, strong)   UIColor     *color;
@property (nonatomic, strong)   UIFont      *font;

@property (nonatomic, assign)   BOOL        isLink;
@property (nonatomic, copy)     NSString    *linkFlag;


// 图片
@property (nonatomic, strong) UIImage *image;
// 按钮
@property (nonatomic, strong) UIButton *button;

@end
