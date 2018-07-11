//
//  StarDataEntity
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/8.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@interface StarDataEntity : JSONModel

@property (nonatomic, assign) BOOL isCache;

+ (id)tempData;
    
@end
