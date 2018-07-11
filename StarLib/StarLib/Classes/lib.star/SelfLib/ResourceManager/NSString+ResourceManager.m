//
//  NSString+ResManager.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSString+ResourceManager.h"
#import "XCResourceManager.h"
#import "StarExtension.h"

@implementation NSString(ResourceManager)


- (UIFont *)xc_font {
    return [[XCResourceManager sharedManager] fontWithKey:self];
}

- (UIColor *)xc_color {
    return [[XCResourceManager sharedManager] colorWithKey:self];
}

- (UIColor *(^)(CGFloat))xc_colorWithAlpha {
    return self.xc_color.colorWithAlpha;
}

- (UIImage *)xc_image {
    return [[XCResourceManager sharedManager] imageWithKey:self];
}

- (UIImage *)xc_resizableImage {
    return self.xc_image.resizableImage;
}

@end



@implementation UILabel (AmountAdvanceDecline)


- (NSString *)xc_changeAmount {
    return self.text;
}

- (void)setXc_changeAmount:(NSString *)xc_changeAmount {
    self.text = xc_changeAmount;
    
    // <
    if ([self.text isLessThanPrice:@"0"]) {
        self.textColor = @"#55C360".xc_color;
    }
    // >
    else if ([self.text isGreaterThanPrice:@"0"]) {
        self.textColor = @"#FF2020".xc_color;
    }
    // =
    else {
        self.textColor = @"#A5A5A5".xc_color;
    }
}

@end
