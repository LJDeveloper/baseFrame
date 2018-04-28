//
//  Macro.h
//  yyRemoteDiagnosis
//
//  Created by feetto on 2018/4/19.
//  Copyright © 2018年 feetto. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//通过Red,Green,Blue设置颜色
#define UIColorWithRGBA(r,g,b,a)[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorWithRGB(r,g,b) UIColorWithRGBA(r,g,b,1.0)
//通过16进制数设置颜色值
#define UIColorWithHexA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:(a)]
#define UIColorWithHex(rgbValue)    UIColorWithHexA(rgbValue, 1.0)
//打印
#ifdef DEBUG
#   define DLog(...) NSLog((@"%s [Line %d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#   define SLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#   define SLog(...)
#endif
//去掉字符串两边的空格
#define FilterKG(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
//判断iPhone_X
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#endif /* Macro_h */
