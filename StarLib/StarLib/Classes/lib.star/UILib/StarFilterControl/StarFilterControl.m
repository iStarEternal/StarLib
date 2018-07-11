//
//  StarFilterControl.m
//  StarFilterControl
//
//  Created by Star on 16/10/25.
//  Copyright © 2016年 Star. All rights reserved.
//

#import "StarFilterControl.h"
#import "StarExtension.h"
#define LEFT_OFFSET 0
#define RIGHT_OFFSET 0
#define LineBottomSpacing 10
#define TitleLabelTagFlag 50
#define PointerSize CGSizeMake(12, 12)

@interface StarFilterControl (){
    CGPoint diffPoint;
    float titleLabelWidth;
}

@property (nonatomic, strong) StarFilterPointer *pointer;

@end

@implementation StarFilterControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.progressColor = [UIColor colorWithRed:203/255.f green:203/255.f blue:203/255.f alpha:1];
        self.allowSlide = true;
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleItemSelected:)];
        [self addGestureRecognizer:gest];
        [self loadPointer];
    }
    return self;
}

- (void)loadPointer {
    
    StarFilterPointer *pointer = [[StarFilterPointer alloc] init];
    [self addSubview:pointer];
    self.pointer = pointer;
    self.pointer.frame = CGRectMake(0 , 0, PointerSize.width, PointerSize.height);
    self.pointer.frame = CGRectInset(self.pointer.frame, -6, -6);
    CGPoint point = [self centerPointForPointerAtIndex:0];
    self.pointer.center = point;
    self.pointer.color = xrgb(0xf5a623);
    self.pointer.adjustsImageWhenHighlighted = false;
    [self.pointer addTarget:self action:@selector(touchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [self.pointer addTarget:self action:@selector(touchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self.pointer addTarget:self action:@selector(touchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    
}

- (void)loadTitleLabels {
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    titleLabelWidth = (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (self.titles.count);
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, titleLabelWidth, 25);
        label.center = [self centerPointForLabelAtIndex:i];
        label.font = [UIFont fontWithName:@"Helvetica" size:14];
        label.text = self.titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        label.adjustsFontSizeToFitWidth = true;
        label.minimumScaleFactor = 8;
        label.tag = i + TitleLabelTagFlag;
        label.textColor = i ? xrgb(0x999999) : xrgb(0xf5a623);
        // @"label_hint_color".xc_color : @"label_orange_color_2".xc_color;
        [self addSubview:label];
    }
}


#pragma mark -

- (CGPoint)centerPointForPointerAtIndex:(NSInteger)idx {
    CGFloat rate = ((idx + 1) * 2 - 1) / (CGFloat)(self.titles.count * 2);
    return CGPointMake(rate * (self.frame.size.width - RIGHT_OFFSET - LEFT_OFFSET) + LEFT_OFFSET,
                       self.frame.size.height - LineBottomSpacing);
}

- (CGPoint)centerPointForLabelAtIndex:(NSInteger)idx {
    CGFloat rate = ((idx + 1) * 2 - 1) / (CGFloat)(self.titles.count * 2);
    return CGPointMake(rate * (self.frame.size.width - RIGHT_OFFSET - LEFT_OFFSET) + LEFT_OFFSET,
                       self.frame.size.height * 0.5 - 5);
}

- (NSInteger)selectedIndexInPoint:(CGPoint)point {
    return round((point.x - LEFT_OFFSET) / titleLabelWidth - 0.5);
}


#pragma mark - Setter

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self loadTitleLabels];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:false];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    _selectedIndex = selectedIndex;
    [self moveTitlesToIndex:selectedIndex animated:true];
    [self movePointerToIndex:selectedIndex animated:true];
}

- (void)setPointerColor:(UIColor *)color {
    self.pointer.color = color;
}

- (void)setTitlesColor:(UIColor *)color{
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *lbl = [self viewWithTag:i + TitleLabelTagFlag];
        lbl.textColor = color;
    }
}

- (void)setTitlesFont:(UIFont *)font{
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *lbl = [self viewWithTag:i + TitleLabelTagFlag];
        lbl.font = font;
    }
}


#pragma mark - Handle

- (void)handleItemSelected:(UITapGestureRecognizer *)handleItemSelected {
    NSInteger selectedIndex = [self selectedIndexInPoint:[handleItemSelected locationInView:self]];
    if (selectedIndex < 0 || selectedIndex >= self.titles.count) {
        return;
    }
    [self setSelectedIndex:selectedIndex animated:true];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)touchDown:(UIButton *)sender withEvent:(UIEvent *)event {
    CGPoint currPoint = [[[event allTouches] anyObject] locationInView:self];
    diffPoint = CGPointMake(currPoint.x - sender.center.x, currPoint.y - sender.center.y);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)touchMove:(UIButton *)sender withEvent:(UIEvent *)event {
    
    if (!self.allowSlide) return;
    if (self.titles.count == 1) return;
    
    CGPoint currPoint = [[[event allTouches] anyObject] locationInView:self];
    CGPoint toPoint = CGPointMake(currPoint.x - diffPoint.x, self.pointer.center.y);
    self.pointer.center = toPoint;
    
    NSInteger selectedIndex = [self selectedIndexInPoint:sender.center];
    if (selectedIndex < 0 || selectedIndex >= self.titles.count)
        return;
    [self moveTitlesToIndex:selectedIndex animated:true];
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}

- (void)touchUp:(UIButton *)sender withEvent:(UIEvent *)event {
    
    if (!self.allowSlide) return;
    if (self.titles.count == 1) return;
    
    NSInteger selectedIndex = [self selectedIndexInPoint:sender.center];
    if (selectedIndex < 0 || selectedIndex >= self.titles.count)
        return;
    [self setSelectedIndex:selectedIndex animated:true];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


#pragma mark -

- (void)moveTitlesToIndex:(NSInteger)index animated:(BOOL)animated {
    
    [UIView animateWithDuration:animated ? 0.1 : 0 animations:^{
        for (int i = 0; i < self.titles.count; i++) {
            UILabel *lbl = [self viewWithTag:i + TitleLabelTagFlag];
            lbl.textColor = (i == index) ? xrgb(0xf5a623) :xrgb(0x999999);
        }
    }];
}

- (void)movePointerToIndex:(NSInteger)index animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.1 : 0 animations:^{
        CGPoint toPoint = [self centerPointForPointerAtIndex:index];
        self.pointer.center = toPoint;
    }];
}



#pragma mark -

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Fill Line
    CGContextSetFillColorWithColor(context, xrgb(0xECEEF0).CGColor);
    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height - LineBottomSpacing, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 1));
    CGContextSaveGState(context);
    
    
    CGPoint centerPoint;
    
    for (int i = 0; i < self.titles.count; i++) {
        
        centerPoint = [self centerPointForPointerAtIndex:i];
        
        CGRect pointerFrame = CGRectMake(centerPoint.x - PointerSize.width * 0.5,
                                         centerPoint.y - PointerSize.height * 0.5,
                                         PointerSize.width,
                                         PointerSize.height);
        
        // Draw Selection Circles
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextFillEllipseInRect(context, pointerFrame);
        
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        CGContextFillEllipseInRect(context, pointerFrame);
        CGContextSetStrokeColorWithColor(context, xrgb(0xECEEF0).CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextStrokeEllipseInRect(context, CGRectInset(pointerFrame, 0.5, 0.5));
    }
}

- (void)dealloc {
    
    [self.pointer removeTarget:self action:@selector(touchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [self.pointer removeTarget:self action:@selector(touchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self.pointer removeTarget:self action:@selector(touchMove:withEvent: ) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
}

@end
