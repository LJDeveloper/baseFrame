//
//  baseVC.h
//  yyRemoteDiagnosis
//
//  Created by feetto on 2018/4/19.
//  Copyright © 2018年 feetto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseVC : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UIButton *backBar;
@property(nonatomic,assign)BOOL isCanSideBack;
@property(nonatomic,strong)AFHTTPSessionManager *afSession;
//获取设备唯一标识
- (NSString *)getUUID;
//隐藏tabbar
- (void)hiddenTabbar:(BOOL )tabbarHidden;
//设置view边框
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
//文本高度自适应
- (CGFloat)contentHeight:(NSString *)str fontSize:(NSInteger )fontsize widthSize:(NSInteger )widthSize;
//文本宽度自适应
- (CGFloat)contentWidth:(NSString *)str fontSize:(NSInteger )fontsize HeightSize:(NSInteger )HeightSize;
//检测token是否变化
-(void)isChangeTokenofrt:(NSString *)rt timestamp:(NSString *)timestamp;
//退出登录
- (void)backLogin:(NSString *)str;
//根据时间戳转换时间
-(NSString *)timestampSwitchTime:(NSString *)timestamp andFormatter:(NSString *)format;
@end
