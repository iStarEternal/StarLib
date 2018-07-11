//
//  StarLibExtension.h
//  Pods
//
//  Created by 星星 on 2018/7/11.
//

#ifndef StarLibExtension_h
#define StarLibExtension_h

#import "MASForbearance.h"
#import "MASConstraintMaker+Forbearance.h"
#import "UIView+Forbearance.h"
#import "NSArray+Sudoku.h"

#import "View+StarShorthandAdditions.h"
#import "NSArray+StarShorthandAdditions.h"

#define equalTo(...)                     mas_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        mas_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           mas_lessThanOrEqualTo(__VA_ARGS__)
#define offset(...)                      mas_offset(__VA_ARGS__)


#endif /* StarLibExtension_h */
