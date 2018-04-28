//
//  tabbarVC.h
//  yyRemoteDiagnosis
//
//  Created by feetto on 2018/4/28.
//  Copyright © 2018年 feetto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tabbarVC : UITabBarController
@property(nonatomic,strong)UIView *tabbarBgView;
@property(nonatomic,strong)AFHTTPSessionManager *afSession;
@end
