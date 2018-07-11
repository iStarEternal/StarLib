//
//  StarFilterControl.m
//  StarFilterControl
//
//  Created by Star on 16/10/25.
//  Copyright © 2016年 Star. All rights reserved.
//

#import "PythiaFilterControl.h"
#import "StarExtension.h"

#define BASELINE_LEFT_OFFSET    50
#define BASELINE_RIGHT_OFFSET   50
#define POINTER_LEFT_OFFSET     (BASELINE_LEFT_OFFSET + 25)
#define POINTER_RIGHT_OFFSET    (BASELINE_RIGHT_OFFSET + 25)

#define BASELINE_Y              20.
#define BASELINE_HEIGHT         4.

#define TITLE_Y                 (BASELINE_Y + BASELINE_HEIGHT + 10 + 20)

#define TitleLabelTag           350

@interface PythiaFilterControl (){
    CGPoint diffPoint;
    CGFloat bx;
}


@end

@implementation PythiaFilterControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _allowSlide             = true;
        _selectedIndex          = 0;
        
        self.backgroundColor    = [UIColor clearColor];
        
        _baselineColor          = [UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:1];
        _baselineEdgeHidden     = true;
        _baselineHeight         = 1;
        
        _pointerColor           = [UIColor orangeColor];
        _pointerSize            = CGSizeMake(12, 12);
        _anchorsColor           = [UIColor grayColor];
        _anchorsSize            = CGSizeMake(12, 12);
        
        _selectedTitleColor     = [UIColor orangeColor];
        _unselectedTitleColor   = [UIColor grayColor];
        
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleItemSelected:)];
        [self addGestureRecognizer:gest];
        [self loadPointer];
    }
    return self;
}

- (void)loadPointer {
    
    PythiaFilterPointer *pointer = [[PythiaFilterPointer alloc] init];
    [self addSubview:pointer];
    self.pointer        = pointer;
    self.pointer.frame  = CGRectMake(0 , 0, self.pointerSize.width, self.pointerSize.height);
    self.pointer.frame  = CGRectInset(self.pointer.frame, -6, -6);
    self.pointer.center = [self z_centerPointForPointerAtIndex:0];
    self.pointer.color  = self.pointerColor;
    self.pointer.adjustsImageWhenHighlighted = false;
    
    [self.pointer addTarget:self action:@selector(touchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [self.pointer addTarget:self action:@selector(touchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self.pointer addTarget:self action:@selector(touchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    
    bx = self.pointer.center.x;
}

- (void)loadTitleLabels {
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    
    for (int i = 0; i < self.titles.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.text              = self.titles[i];
        label.textAlignment     = NSTextAlignmentCenter;
        label.backgroundColor   = [UIColor clearColor];
        label.lineBreakMode     = NSLineBreakByTruncatingMiddle;
        label.tag               = i + TitleLabelTag;
        label.textColor         = i ? self.selectedTitleColor : self.unselectedTitleColor;
        label.font              = i ? self.selectedTitleFont : self.unselectedTitleFont;
        label.minimumScaleFactor= 8;
        label.adjustsFontSizeToFitWidth = true;
        label.hidden            = self.titleHidden;
        
        CGPoint center = [self z_centerPointForLabelAtIndex:i];
        label.frame             = CGRectMake(0, 0, 100, 25);
        label.center            = center;
    }
}


#pragma mark - 算法


- (CGPoint)z_centerPointForPointerAtIndex:(NSInteger)idx {
    CGFloat z_rate = idx / ((CGFloat)self.titles.count - 1);
    CGFloat x = (self.frame.size.width - POINTER_LEFT_OFFSET - POINTER_RIGHT_OFFSET) * z_rate + POINTER_LEFT_OFFSET;
    CGFloat y = BASELINE_Y + BASELINE_HEIGHT / 2;
    return CGPointMake(x, y);
}

- (CGPoint)z_centerPointForLabelAtIndex:(NSInteger)idx {
    CGPoint point = [self z_centerPointForPointerAtIndex:idx];
    point.y = TITLE_Y;
    return point;
}


- (NSInteger)z_selectedIndexInPoint:(CGPoint)point {
    
    CGFloat rx = point.x - POINTER_LEFT_OFFSET;
    
    CGFloat usable_width = (self.frame.size.width - POINTER_LEFT_OFFSET - POINTER_RIGHT_OFFSET);
    CGFloat space = usable_width / (self.titles.count - 1);
    
    NSInteger idx = rx / space;
    CGFloat wide = space - (space * (idx + 1) - rx);
    if (wide * 2 > space) {
        return idx + 1;
    }
    else {
        return idx;
    }
}


#pragma mark - Setter 设置样式

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self loadTitleLabels];
    [self setSelectedIndex:0 animated:false];
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:false];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    _selectedIndex = selectedIndex;
    [self moveTitlesToIndex:selectedIndex animated:animated];
    [self movePointerToIndex:selectedIndex animated:animated];
}


- (void)setBaselineColor:(UIColor *)baselineColor {
    _baselineColor = baselineColor;
    [self setNeedsDisplay];
}

- (void)setBaselineEdgeHidden:(BOOL)baselineEdgeHidden {
    _baselineEdgeHidden = baselineEdgeHidden;
    [self setNeedsDisplay];
}

- (void)setBaselineHeight:(CGFloat)baselineHeight {
    _baselineHeight = baselineHeight;
    [self setNeedsDisplay];
}


- (void)setPointerColor:(UIColor *)pointerColor {
    _pointerColor = pointerColor;
    self.pointer.color = pointerColor;
}

- (void)setPointerImage:(UIImage *)pointerImage {
    _pointerImage = pointerImage;
    [self.pointer setImage:pointerImage forState:UIControlStateNormal];
    [self.pointer setImage:pointerImage forState:UIControlStateHighlighted];
}

- (void)setPointerSize:(CGSize)pointerSize {
    _pointerSize = pointerSize;
    
    CGRect f = self.pointer.frame;
    f.origin.x += f.size.width / 2;
    f.origin.y += f.size.height / 2;
    f.size = pointerSize;
    f.origin.x -= f.size.width / 2;
    f.origin.y -= f.size.height / 2;
    self.pointer.frame = f;
}


- (void)setAnchorsColor:(UIColor *)anchorsColor {
    _anchorsColor = anchorsColor;
    [self setNeedsDisplay];
}

- (void)setAnchorsImage:(UIImage *)anchorsImage {
    _anchorsImage = anchorsImage;
    [self setNeedsDisplay];
}

- (void)setAnchorsSize:(CGSize)anchorsSize {
    _anchorsSize = anchorsSize;
    [self setNeedsDisplay];
}


- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    
    for (int i = 0; i < self.titles.count; i++) {
        if (i == self.selectedIndex) {
            UILabel *lbl = [self viewWithTag:i + TitleLabelTag];
            lbl.textColor = selectedTitleColor;
        }
    }
}

- (void)setSelectedTitleFont:(UIFont *)selectedTitleFont {
    _selectedTitleFont = selectedTitleFont;
    
    for (int i = 0; i < self.titles.count; i++) {
        if (i == self.selectedIndex) {
            UILabel *lbl = [self viewWithTag:i + TitleLabelTag];
            lbl.font = selectedTitleFont;
        }
    }
}

- (void)setUnselectedTitleColor:(UIColor *)unselectedTitleColor {
    _unselectedTitleColor = unselectedTitleColor;
    for (int i = 0; i < self.titles.count; i++) {
        if (i != self.selectedIndex) {
            UILabel *lbl = [self viewWithTag:i + TitleLabelTag];
            lbl.textColor = unselectedTitleColor;
        }
    }
}

- (void)setUnselectedTitleFont:(UIFont *)unselectedTitleFont {
    _unselectedTitleFont = unselectedTitleFont;
    for (int i = 0; i < self.titles.count; i++) {
        if (i != self.selectedIndex) {
            UILabel *lbl = [self viewWithTag:i + TitleLabelTag];
            lbl.font = unselectedTitleFont;
        }
    }
}

- (void)setTitleHidden:(BOOL)titleHidden {
    _titleHidden = titleHidden;
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *lbl = [self viewWithTag:i + TitleLabelTag];
        lbl.hidden = titleHidden;
    }
}


#pragma mark - Handle

- (void)handleItemSelected:(UITapGestureRecognizer *)handleItemSelected {
    NSInteger selectedIndex = [self z_selectedIndexInPoint:[handleItemSelected locationInView:self]];
    if (selectedIndex < 0 || selectedIndex >= self.titles.count) {
        return;
    }
    [self setSelectedIndex:selectedIndex animated:true];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    // 进度条
    bx = [self z_centerPointForPointerAtIndex:selectedIndex].x;
    [self setNeedsDisplay];
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
    
    NSInteger selectedIndex = [self z_selectedIndexInPoint:sender.center];
    if (selectedIndex < 0) {
        selectedIndex = 0;
    }
    if (selectedIndex >= self.titles.count) {
        selectedIndex = self.titles.count - 1;
    }
    [self moveTitlesToIndex:selectedIndex animated:true];
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    
    
    // 进度条
    bx = toPoint.x;
    [self setNeedsDisplay];
}

- (void)touchUp:(UIButton *)sender withEvent:(UIEvent *)event {
    
    if (!self.allowSlide) return;
    if (self.titles.count == 1) return;
    
    NSInteger selectedIndex = [self z_selectedIndexInPoint:sender.center];
    if (selectedIndex < 0) {
        selectedIndex = 0;
    }
    if (selectedIndex >= self.titles.count) {
        selectedIndex = self.titles.count - 1;
    }
    [self setSelectedIndex:selectedIndex animated:true];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    // 进度条
    bx = [self z_centerPointForPointerAtIndex:selectedIndex].x;
    [self setNeedsDisplay];
}


#pragma mark -

- (void)moveTitlesToIndex:(NSInteger)index animated:(BOOL)animated {
    
    [UIView animateWithDuration:animated ? 0.1 : 0 animations:^{
        for (int i = 0; i < self.titles.count; i++) {
            UILabel *lbl = [self viewWithTag:i + TitleLabelTag];
            lbl.textColor = (i == index) ? self.selectedTitleColor : self.unselectedTitleColor;
            lbl.font = (i == index) ? self.selectedTitleFont : self.unselectedTitleFont;
        }
    }];
}

- (void)movePointerToIndex:(NSInteger)index animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.1 : 0 animations:^{
        CGPoint toPoint = [self z_centerPointForPointerAtIndex:index];
        self.pointer.center = toPoint;
    }];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self setSelectedIndex:self.selected animated:true];
}

#pragma mark -
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat outline_width = 1.5;
    CGFloat x = BASELINE_LEFT_OFFSET + outline_width;
    CGFloat y = BASELINE_Y;
    CGFloat width = rect.size.width - BASELINE_LEFT_OFFSET - BASELINE_RIGHT_OFFSET - outline_width * 2;
    CGFloat height = BASELINE_HEIGHT;
    CGRect baseline_rect = CGRectMake(x, y, width, height);
    
    // 基准线
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:baseline_rect cornerRadius:baseline_rect.size.height * 0.5];
    [self.baselineColor set];
    [path fill];
    // 渐变色
    NSArray *colors = @[rgba(255,159,6,1), rgba(255,32,32,1)];
    [self setLineGradient:ctx path:path colors:colors];
    // 描边
    CGRect outline_rect = CGRectInset(baseline_rect, -outline_width * 0.5, -outline_width * 0.5);
    UIBezierPath *outline_path = [UIBezierPath bezierPathWithRoundedRect:outline_rect cornerRadius:outline_rect.size.height * 0.5];
    [rgba(253,209,209,1) set];
    outline_path.lineWidth = outline_width;
    [outline_path stroke];
    
    // 进度线
    CGFloat p_x = x;
    CGFloat p_y = y;
    CGFloat p_width = width - (width - (bx - BASELINE_LEFT_OFFSET - outline_width));
    p_width = p_width <= 0 ? 0 : p_width;
    p_width = p_width >= width ? width : p_width;
    CGFloat p_height = height;
    CGRect progress_rect = CGRectMake(p_x, p_y, p_width, p_height);
    UIBezierPath *b_path = [UIBezierPath bezierPathWithRoundedRect:progress_rect cornerRadius:progress_rect.size.height * 0.5];
    [rgba(255,255,255,1) set];
    [b_path fill];
}


- (void)setLineGradient:(CGContextRef)ctx path:(UIBezierPath *)path colors:(NSArray *)colors {
    
    NSArray *cg_colors = [colors map:^id(UIColor *element) {
        return (__bridge id)element.CGColor;
    }];
    CGRect pathRect = CGPathGetBoundingBox(path.CGPath);
    
    CGContextSaveGState(ctx);
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(baseSpace, (CFArrayRef)cg_colors, NULL);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    
    CGContextAddPath(ctx, [path.copy CGPath]);
    // CGContextReplacePathWith
    CGContextClip(ctx);
    
    
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    //
    CGContextRestoreGState(ctx);
    
}

- (void)drawColor:(CGContextRef)ctx {
    CGPoint centerPoint;
    
    for (int i = 0; i < self.titles.count; i++) {
        
        centerPoint = [self z_centerPointForPointerAtIndex:i];
        
        CGRect pointerFrame = CGRectMake(centerPoint.x - self.anchorsSize.width * 0.5,
                                         centerPoint.y - self.anchorsSize.height * 0.5,
                                         self.anchorsSize.width,
                                         self.anchorsSize.height);
        
        // Draw Selection Circles
        CGContextSetBlendMode(ctx, kCGBlendModeClear);
        CGContextFillEllipseInRect(ctx, pointerFrame); // 擦除
        
        CGContextSetBlendMode(ctx, kCGBlendModeNormal);
        CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
        CGContextFillEllipseInRect(ctx, pointerFrame); // 还原成背景
        
        CGContextSetStrokeColorWithColor(ctx, self.anchorsColor.CGColor);
        CGContextSetLineWidth(ctx, 1);
        CGContextStrokeEllipseInRect(ctx, CGRectInset(pointerFrame, 0.5, 0.5));
    }
}

- (void)drawImage:(CGContextRef)ctx {
    
    CGPoint centerPoint;
    
    UIImage *img = self.anchorsImage;
    
    for (int i = 0; i < self.titles.count; i++) {
        
        centerPoint = [self z_centerPointForPointerAtIndex:i];
        
        CGRect pointerFrame = CGRectMake(centerPoint.x - img.size.width * 0.5,
                                         centerPoint.y - img.size.height * 0.5,
                                         img.size.width,
                                         img.size.height);
        
        // Draw Selection Circles
        CGContextSetBlendMode(ctx, kCGBlendModeClear);
        CGContextFillEllipseInRect(ctx, pointerFrame); // 擦除
        
        CGContextSetBlendMode(ctx, kCGBlendModeNormal);
        CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
        CGContextFillEllipseInRect(ctx, pointerFrame);
        
        CGContextDrawImage(ctx, pointerFrame, img.CGImage);  // 绘制图片
    }
}

@end
