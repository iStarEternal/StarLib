//
//  WexPickerModel.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/31.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WexPickerModel : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;
+ (instancetype)pickerModelWithKey:(NSString *)key value:(NSString *)value;
@end
