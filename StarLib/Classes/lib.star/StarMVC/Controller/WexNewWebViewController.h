//
//  PythiaWebViewModel.h
//  Pythia
//
//  Created by 星星 on 2017/4/13.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "WexNewViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>


@interface WexNewWebViewController : WexNewViewController <UIWebViewDelegate>


+ (instancetype)webvcWithURLString:(NSString *)URLString;


@property (nonatomic, weak) UIWebView *webView;

/**
 *  if HTMLString is nil, webView will be send -[UIWebView loadRequest:]
 *  if HTMLString is not nil, webView will be send -[UIWebView loadHTMLString:baseURL:]
 */
@property (nonatomic, copy) NSString *URLString;

/**
 *  if not nil webView will be send -[UIWebView loadHTMLString:baseURL:]
 *  if HTMLString is not nil and URLString is not nil, the baseURL is URLString
 */
@property (nonatomic, copy) NSString *HTMLString;

/**
 *
 */
@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *MIMEType;


/**
 *  default is true
 */
@property (nonatomic, assign, getter=isAutoTitle) BOOL autoTitle;

@property (nonatomic, assign) BOOL scalesPageToFit;




typedef void (^PythiaJavascriptCallback)(JSValue *js_this, NSArray *js_args);
typedef void (^PythiaJavascriptCallbackReturn)(JSValue *js_this, NSArray *js_args);
/**
 *  监听js调用
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, PythiaJavascriptCallback> *javascriptObservers;

@end


