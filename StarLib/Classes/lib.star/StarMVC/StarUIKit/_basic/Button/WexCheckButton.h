//
//  WexCheckButton.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WexCheckButton : UIButton

@property (nonatomic, assign, getter=isChecked) BOOL checked;

@property (nonatomic, strong) UIImage *checkedImage;

@property (nonatomic, strong) UIImage *uncheckedImage;

@end
