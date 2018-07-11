//
//  WexCheckButton.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexCheckButton.h"

@interface WexCheckButton ()
{}


@end

@implementation WexCheckButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (BOOL)isChecked {
    return self.selected;
}

- (void)setChecked:(BOOL)checked {
    self.selected = checked;
}

- (UIImage *)checkedImage {
    return self.wex_selectedImage;
}

- (void)setCheckedImage:(UIImage *)checkedImage {
    self.wex_selectedImage = checkedImage;
}

- (UIImage *)uncheckedImage {
    return self.wex_normalImage;
}

- (void)setUncheckedImage:(UIImage *)uncheckedImage {
    self.wex_normalImage = uncheckedImage;
}


- (void)handleTouchUpInside:(WexCheckButton *)sender {
    sender.selected = !sender.selected;
}
@end
