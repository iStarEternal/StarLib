//
//  StarBannerPlayer.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/2.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "StarBannerPlayer.h"

@interface StarBannerPlayer () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, assign) BOOL timerScrolling;

@end

@implementation StarBannerPlayer

//重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadScrollView];
        [self loadImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame sourceArray:(NSArray<UIImage *> *)sourceArray scrollInterval:(NSTimeInterval)scrollInterval {
    self = [self initWithFrame:frame];
    if (self) {
        self.sourceArray = sourceArray;
        self.timeInterval = scrollInterval;
        [self loadImages:sourceArray];
        [self loadTimer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame URLStrings:(NSArray<NSString *> *)URLStrings scrollInterval:(NSTimeInterval)scrollInterval {
    self = [self initWithFrame:frame];
    if (self) {
        _URLStrings = URLStrings;
        _timeInterval = scrollInterval;
        [self loadTimer];
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect pageControlFrame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
    self.pageControl.frame = pageControlFrame;
    
    CGRect mainScrollViewFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.mainScrollView.frame = mainScrollViewFrame;
    self.mainScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    self.mainScrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    
    CGFloat width = 0;
    for (int imageViewIndex = 1; imageViewIndex <= 3; imageViewIndex++) {
        UIImageView *imgView = [self viewWithTag:imageViewIndex];
        imgView.frame = CGRectMake(width, 0, self.bounds.size.width, self.bounds.size.height);
        width += self.bounds.size.width;
    }
}

//初始化主滑动视图
- (void)loadScrollView {
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    self.mainScrollView.delegate = self;
    
    [self.mainScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    [self addSubview:self.mainScrollView];
    
}

//初始化imageview
- (void)loadImageView {
    
    CGFloat width = 0;
    for (int a = 0; a < 3; a++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor whiteColor];
        // imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = a + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgActive:)];
        [imageView addGestureRecognizer:tap];
        [self.mainScrollView addSubview:imageView];
        width += self.bounds.size.width;
    }
}

//自动布局创建自定义的pageController
- (void)loadMXPageControl:(NSUInteger)totalPageNumber {
    
    UIImageView *pageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageView@2x"]];
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    pageView.backgroundColor = [UIColor clearColor];
    [self addSubview:pageView];
    
    NSLayoutConstraint *constraintButtom = [NSLayoutConstraint constraintWithItem:pageView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.f
                                                                         constant:-5.f];
    
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:pageView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.f
                                                                        constant:-15.f];
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:pageView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.f
                                                                        constant:90.f / 375 * [UIScreen mainScreen].bounds.size.width * 0.55];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:pageView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.f
                                                                         constant:33.f / 667 * [UIScreen mainScreen].bounds.size.height * 0.55];
    
    [self addConstraints:@[constraintButtom,constraintRight,constraintWidth,constraintHeight]];
    
    UILabel *pageNumber = [[UILabel alloc]init];
    pageNumber.translatesAutoresizingMaskIntoConstraints = NO;
    pageNumber.layer.backgroundColor = [UIColor whiteColor].CGColor;
    pageNumber.text = @"1";
    pageNumber.textColor = [UIColor colorWithRed:88.f / 255.f green:157.f / 255.f blue:62.f / 255.f alpha:1.f];
    pageNumber.textAlignment = NSTextAlignmentCenter;
    pageNumber.font = [UIFont boldSystemFontOfSize:12.f / 375 * [UIScreen mainScreen].bounds.size.width];
    pageNumber.tag = 99;
    [self addSubview:pageNumber];
    pageNumber.layer.cornerRadius = 33.f / 667 * [UIScreen mainScreen].bounds.size.height * 0.5 / 2.f;
    pageNumber.layer.borderWidth = 0.5f;
    pageNumber.layer.borderColor = [UIColor colorWithRed:109.f / 255.f green:109.f / 255.f blue:109.f / 255.f alpha:1.f].CGColor;
    pageNumber.layer.masksToBounds = YES;
    
    NSLayoutConstraint *constraintPageRight = [NSLayoutConstraint constraintWithItem:pageNumber
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:pageView
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.f
                                                                            constant:4.f];
    
    NSLayoutConstraint *constraintPageCenter = [NSLayoutConstraint constraintWithItem:pageNumber
                                                                            attribute:NSLayoutAttributeCenterY
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:pageView
                                                                            attribute:NSLayoutAttributeCenterY
                                                                           multiplier:1.f
                                                                             constant:0.f];
    
    NSLayoutConstraint *constraintPageWidth = [NSLayoutConstraint constraintWithItem:pageNumber
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.f
                                                                            constant:33.f / 667 * [UIScreen mainScreen].bounds.size.height * 0.55];
    
    NSLayoutConstraint *constraintPageHeight = [NSLayoutConstraint constraintWithItem:pageNumber
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.f
                                                                             constant:33.f / 667 * [UIScreen mainScreen].bounds.size.height * 0.55];
    
    [self addConstraints:@[constraintPageCenter,constraintPageRight,constraintPageWidth,constraintPageHeight]];
    
    UILabel *totalPage = [[UILabel alloc] init];
    totalPage.translatesAutoresizingMaskIntoConstraints = NO;
    totalPage.textAlignment = NSTextAlignmentCenter;
    totalPage.font = [UIFont boldSystemFontOfSize:12.f / 375 * [UIScreen mainScreen].bounds.size.width];
    totalPage.textColor = [UIColor whiteColor];
    totalPage.text = [NSString stringWithFormat:@"of %lu",(unsigned long)totalPageNumber];
    totalPage.backgroundColor = [UIColor clearColor];
    [self addSubview:totalPage];
    
    NSLayoutConstraint *constrainttotalPageRight = [NSLayoutConstraint constraintWithItem:totalPage
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:pageView
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.f
                                                                                 constant:0.f];
    
    NSLayoutConstraint *constrainttotalPageCenter = [NSLayoutConstraint constraintWithItem:totalPage
                                                                                 attribute:NSLayoutAttributeCenterY
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:pageView
                                                                                 attribute:NSLayoutAttributeCenterY
                                                                                multiplier:1.f
                                                                                  constant:0.f];
    
    NSLayoutConstraint *constrainttotalPageWidth = [NSLayoutConstraint constraintWithItem:totalPage
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.f
                                                                                 constant:85.f / 375 * [UIScreen mainScreen].bounds.size.width * 0.55];
    
    NSLayoutConstraint *constrainttotalPageHeight = [NSLayoutConstraint constraintWithItem:totalPage
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.f
                                                                                  constant:33.f / 667 * [UIScreen mainScreen].bounds.size.height * 0.55];
    
    [self addConstraints:@[constrainttotalPageRight,constrainttotalPageCenter,constrainttotalPageWidth,constrainttotalPageHeight]];
    
}

- (void)loadPageControl:(NSUInteger)totalPageNumber {
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    self.pageControl.numberOfPages = totalPageNumber;
    self.pageControl.currentPage = 0;
    
}


//初始化一个定时器
- (void)loadTimer {
    
    if (self.timer == nil) {
        
        self.timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]
                                              interval:self.timeInterval
                                                target:self
                                              selector:@selector(timerActive:)
                                              userInfo:nil
                                               repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

//点击图片的回调
- (void)imgActive:(id)sender {
    if ([self.delegate respondsToSelector:@selector(bannnerPlayer:didSelectIndex:)]) {
        [self.delegate bannnerPlayer:self didSelectIndex:self.currentIndex];
    }
}

//定时器事件
- (void)timerActive:(id)sender {
    //    self.timerScrolling = true;
    //    self.mainScrollView.userInteractionEnabled = false;
    //    [UIView animateWithDuration:1.0 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
    [self.mainScrollView scrollRectToVisible:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height) animated:YES];
    //    } completion:^(BOOL finished) {
    //        self.timerScrolling = false;
    //        self.mainScrollView.userInteractionEnabled = true;
    //        [self scrollViewDidScroll:self.mainScrollView];
    //    }];
    
}

//动画开始时的回调
- (void)animationDidStart:(CAAnimation *)anim{
    
    UILabel *index = (UILabel *)[self viewWithTag:99];
    index.text = [NSString stringWithFormat:@"%lu",(unsigned long)(self.currentIndex + 1)];
    
}

//首次初始化图片
- (void)loadImages:(NSArray *)sourceArray {
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceArray];
    
    UIImageView *indexViewOne = (UIImageView *)[self.mainScrollView viewWithTag:1];
    UIImageView *indexViewTwo = (UIImageView *)[self.mainScrollView viewWithTag:2];
    UIImageView *indexViewThree = (UIImageView *)[self.mainScrollView viewWithTag:3];
    
    self.currentIndex = 0;
    for (id obj in tempArray) {
        if (![obj isKindOfClass:[UIImage class]]) {
            [tempArray removeObject:obj];
        }
    }
    
    if (tempArray.count > 0) {
        if (sourceArray.count == 1) {
            [tempArray addObject:[tempArray objectAtIndex:0]];
            [tempArray addObject:[tempArray objectAtIndex:0]];
            indexViewOne.image = [tempArray objectAtIndex:0];
            indexViewTwo.image = [tempArray objectAtIndex:0];
            indexViewThree.image = [tempArray objectAtIndex:0];
            
        }
        else if (sourceArray.count == 2) {
            [tempArray addObject:[tempArray objectAtIndex:0]];
            indexViewOne.image = [tempArray objectAtIndex:1];
            indexViewTwo.image = [tempArray objectAtIndex:0];
            indexViewThree.image = [tempArray objectAtIndex:1];
            
        }
        else {
            indexViewOne.image = [tempArray objectAtIndex:tempArray.count - 1];
            indexViewTwo.image = [tempArray objectAtIndex:0];
            indexViewThree.image = [tempArray objectAtIndex:1];
        }
        self.sourceArray = tempArray;
        [self loadPageControl:self.sourceArray.count];
        
    }
    else {
        NSLog(@"数据源错误，设置图片失败");
    }
    
}

//设置图片
- (void)setPicWithIndex:(NSUInteger)index withImage:(UIImage *)img {
    UIImageView *indexView = (UIImageView *)[self.mainScrollView viewWithTag:index];
    indexView.image = img;
}

//触摸后停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//触摸停止后再次启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self loadTimer];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    NSLog(@"scroll view offset%@", NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView != self.mainScrollView) {
        return;
    }
    
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        
    }
    else {
        
    }
    
    //    if (self.timerScrolling) {
    //        return;
    //    }
    //三个图uiimageview交替部分
    if (self.mainScrollView.contentOffset.x == 0) {
        
        if (self.currentIndex == 0) {
            self.currentIndex = self.sourceArray.count - 1;
            [self setPicWithIndex:2 withImage:[self.sourceArray objectAtIndex:self.currentIndex]];
            [self setPicWithIndex:1 withImage:[self.sourceArray objectAtIndex:self.currentIndex - 1]];
            [self setPicWithIndex:3 withImage:[self.sourceArray objectAtIndex:0]];
            [self.mainScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        }
        else {
            self.currentIndex --;
            [self setPicWithIndex:2 withImage:[self.sourceArray objectAtIndex:self.currentIndex]];
            if (self.currentIndex == 0) {
                [self setPicWithIndex:1 withImage:[self.sourceArray objectAtIndex:self.sourceArray.count - 1]];
            }
            else {
                [self setPicWithIndex:1 withImage:[self.sourceArray objectAtIndex:self.currentIndex - 1]];
            }
            [self setPicWithIndex:3 withImage:[self.sourceArray objectAtIndex:self.currentIndex + 1]];
            [self.mainScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        }
        
        //页码翻页动画
        // UILabel *index = (UILabel *)[self viewWithTag:99];
        // CATransition *animation = [CATransition animation];
        // animation.delegate = self;
        // [animation setDuration:0.5f];
        // [animation setType:@"oglFlip"];
        // [animation setSubtype:kCATransitionFromRight];
        // [animation setFillMode:kCAFillModeRemoved];
        // [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        // [index.layer addAnimation:animation forKey:nil];
        
        self.pageControl.currentPage = self.currentIndex;
    }
    else if (self.mainScrollView.contentOffset.x == self.bounds.size.width * 2) {
        
        if (self.currentIndex == self.sourceArray.count - 1) {
            self.currentIndex = 0;
            [self setPicWithIndex:2 withImage:[self.sourceArray objectAtIndex:self.currentIndex]];
            [self setPicWithIndex:1 withImage:[self.sourceArray objectAtIndex:self.sourceArray.count - 1]];
            [self setPicWithIndex:3 withImage:[self.sourceArray objectAtIndex:self.currentIndex + 1]];
            [self.mainScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        }
        else {
            self.currentIndex ++;
            [self setPicWithIndex:2 withImage:[self.sourceArray objectAtIndex:self.currentIndex]];
            [self setPicWithIndex:1 withImage:[self.sourceArray objectAtIndex:self.currentIndex - 1]];
            
            if (self.currentIndex == self.sourceArray.count - 1) {
                [self setPicWithIndex:3 withImage:[self.sourceArray objectAtIndex:0]];
            }
            else {
                [self setPicWithIndex:3 withImage:[self.sourceArray objectAtIndex:self.currentIndex + 1]];
            }
            [self.mainScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        }
        self.pageControl.currentPage = self.currentIndex;
        // 页码翻页动画
        //            UILabel *index = (UILabel *)[self viewWithTag:99];
        //            CATransition *animation = [CATransition animation];
        //            animation.delegate = self;
        //            [animation setDuration:0.5f];
        //            [animation setType:@"oglFlip"];
        //            [animation setSubtype:kCATransitionFromLeft];
        //            [animation setFillMode:kCAFillModeRemoved];
        //            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        //            [index.layer addAnimation:animation forKey:nil];
    }
    
}

@end


