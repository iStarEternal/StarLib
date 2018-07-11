//
//  WexIdentityCardKeyboard.m
//  WexWeiCaiFu
//
//  Created by nyezz on 16/1/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexIdentityCardKeyboard.h"
#import "StarExtension.h"
#define kLineWidth 0.5
#define kNumFont [UIFont systemFontOfSize:27]
@implementation WexIdentityCardKeyboard

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216);
        
        for (int i=0; i<4; i++) { // 行
            for (int j=0; j<3; j++) { // 列
                UIButton *button = [self creatButtonWithX:i Y:j];
                [self addSubview:button];
            }
        }
        
        UIColor *color = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        //
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3.f, 0, kLineWidth, 216)];
        line1.backgroundColor = color;
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3.f*2, 0, kLineWidth, 216)];
        line2.backgroundColor = color;
        [self addSubview:line2];
        
        for (int i = 0; i < 3; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54*(i+1), [UIScreen mainScreen].bounds.size.width, kLineWidth)];
            line.backgroundColor = color;
            [self addSubview:line];
        }
        
    }
    return self;
}

- (UIButton *)creatButtonWithX:(NSInteger)x Y:(NSInteger)y {
    UIButton *button;
    //
    CGFloat frameX = 0;
    CGFloat frameW = 0;
    switch (y) {
        case 0:
            frameX = 0.0;
            frameW = [UIScreen mainScreen].bounds.size.width/3.f;
            break;
        case 1:
            frameX = [UIScreen mainScreen].bounds.size.width/3.f;
            frameW = [UIScreen mainScreen].bounds.size.width/3.f;
            break;
        case 2:
            frameX = [UIScreen mainScreen].bounds.size.width/3.f*2;
            frameW = [UIScreen mainScreen].bounds.size.width/3.f;
            break;
            
        default:
            break;
    }
    CGFloat frameY = 54*x;
    
    //
    button = [[UIButton alloc] initWithFrame:CGRectMake(frameX, frameY, frameW, 54)];
    
    //
    NSInteger num = y+3*x+1;
    button.tag = num;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *colorNormal = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1];
    UIColor *colorHightlighted = [UIColor colorWithRed:186.0/255 green:189.0/255 blue:194.0/255 alpha:1.0];
    
    if (num == 10 || num == 12)
    {
        UIColor *colorTemp = colorNormal;
        colorNormal = colorHightlighted;
        colorHightlighted = colorTemp;
    }
    
    [button setBackgroundImage:colorNormal.solidImage forState:UIControlStateNormal];
    [button setBackgroundImage:colorHightlighted.solidImage forState:UIControlStateHighlighted];

    if (num < 10) { // "1"-"9"
        UILabel *labelNum = [[UILabel alloc] initWithFrame:CGRectMake(0,12, frameW, 28)];
        labelNum.text = [NSString stringWithFormat:@"%ld",(long)num];
        labelNum.textColor = [UIColor blackColor];
        labelNum.backgroundColor = [UIColor clearColor];
        labelNum.textAlignment = NSTextAlignmentCenter;
        labelNum.font = kNumFont;
        [button addSubview:labelNum];
        
    } else if (num == 10) { // "X"
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.text = @"X";
        label.font = [UIFont systemFontOfSize:22];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
    } else if (num == 11) { // "0"
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.text = @"0";
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kNumFont;
        [button addSubview:label];
    
    } else { // "delete"
        
        NSString *filename = [NSString stringWithFormat:@"%@.png", @"WexIdentityCardKeyboard_icon_delete"];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@""];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        UIImage *img = [UIImage imageWithData:imageData scale:1];
//        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(42, 19, 22, 17)];
//        arrow.image =
//        [button addSubview:arrow];
        [button setImage:img forState:UIControlStateNormal];
    }
    
    return button;
}


- (void)clickButton:(UIButton *)sender {
    if (sender.tag == 10) {
        NSString *num = @"X";
        [self.delegate numberKeyboardInput:num];
    } else if(sender.tag == 12) {
        [self.delegate numberKeyboardBackspace];
    } else {
        NSInteger num = sender.tag;
        if (sender.tag == 11) {
            num = 0;
        }
        [self.delegate numberKeyboardInput:[NSString stringWithFormat:@"%ld",(long)num]];
    }
}

@end


#pragma -- UITextField+ExtentRange
@implementation UITextField (ExtentRange)

/** 获取选定范围 */
- (NSRange)selectedRange {
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

/** 设置选中范围 */
- (void)setSelectedRange:(NSRange) range {
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}


/** 设置光标位置 */
- (void)insertSelectedRange:(NSRange)range {
    UITextPosition* beginning = self.beginningOfDocument;
    
    //    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location];
    
    [self setSelectedTextRange:[self textRangeFromPosition:endPosition toPosition:endPosition]];
}
@end
