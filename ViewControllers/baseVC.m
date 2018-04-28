//
//  baseVC.m
//  yyRemoteDiagnosis
//
//  Created by feetto on 2018/4/19.
//  Copyright © 2018年 feetto. All rights reserved.
//

#import "baseVC.h"
#import "AppDelegate.h"
@interface baseVC ()
@end

@implementation baseVC

-(AFHTTPSessionManager *)afSession
{
    self.afSession = [AFHTTPSessionManager manager];
    _afSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //去除null
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    [_afSession setResponseSerializer:serializer];
    //添加头部信息
    NSDictionary *useDict = [[NSUserDefaults standardUserDefaults] objectForKey: @"userDict"];
    [_afSession.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    //头部添加uid
    if ([useDict objectForKey:@"uid"])
    {
        [_afSession.requestSerializer setValue:[NSString stringWithFormat:@"%@",[useDict objectForKey:@"uid"]] forHTTPHeaderField:@"uid"];
    }
    //头部添加equipment
    [_afSession.requestSerializer setValue:[self getUUID] forHTTPHeaderField:@"equipment"];
    //获取当前时间戳
    NSDate *senddate = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    //头部添加timestamp
    [_afSession.requestSerializer setValue:timeStamp forHTTPHeaderField:@"timestamp"];
    //加密token
    //NSString *newToken = [Security AesEncrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] Key:[NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@",[timeStamp substringToIndex:9]],@"!@ftyl@"]];
    //头部添加token
    //[_afSession.requestSerializer setValue:newToken forHTTPHeaderField:@"token"];
    //NSLog(@"uid:%@++timestamp:%@++equipment:%@++token:%@",[NSString stringWithFormat:@"%@",[[useDict objectForKey:@"data"] objectForKey:@"uid"]],timeStamp,[self getUUID],newToken);
    return _afSession;
}
-(UILabel *)lable
{
    if (!_lable)
    {
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        _lable.textAlignment=NSTextAlignmentCenter;
        _lable.textColor=[UIColor blackColor];
        _lable.font = [UIFont systemFontOfSize:16];
        self.navigationItem.titleView=_lable;
    }
    return _lable;
}
- (UIButton *)backBar
{
    if (!_backBar) {
        self.backBar = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBar.frame = CGRectMake(0, 12, 40, 20);
        [_backBar setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
        [_backBar addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //不隐藏系统navigation
    self.navigationController.navigationBar.hidden = NO;
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    if (kDevice_Is_iPhoneX)
    {
        //设置导航条背景
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bannerx"] forBarMetrics:(UIBarMetricsDefault)];
    }else
    {
        //设置导航条背景
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner"] forBarMetrics:(UIBarMetricsDefault)];
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBar];
    self.navigationItem.leftBarButtonItem = backItem;
    if (@available(iOS 11.0, *))
    {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
    // Fallback on earlier versions
    }
    [self networkDog];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
    //是否隐藏tabbar
- (void)hiddenTabbar:(BOOL )tabbarHidden
{
    //    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //    tabbarVC * tabbar =(tabbarVC *) window.rootViewController;
    //    tabbar.tabbarBgView.hidden = tabbarHidden;
}
    //网络监听
-(void)networkDog
{
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //NSLog(@"当前网络未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                {
                    [SVProgressHUD dismiss];
                    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"当前没有网络" message:@"请检查网络连接" preferredStyle:UIAlertControllerStyleAlert];
                    alertView.view.center=weakSelf.view.center;
                    
                    UIAlertAction *canCleAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alertView addAction:canCleAction];
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [delegate.window.rootViewController presentViewController:alertView animated:YES completion:nil];
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //NSLog(@"当前wifi连接网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //NSLog(@"当前手机流量连接网络");
                break;
            default:
                break;
        }
    }];
}
//设置View任意边框
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top)
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left)
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom)
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right)
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}
//文本高度自适应
- (CGFloat)contentHeight:(NSString *)str fontSize:(NSInteger )fontsize widthSize:(NSInteger )widthSize
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(widthSize, 10000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontsize]} context:nil];
    return CGRectGetHeight(rect);
}
//文本宽度自适应
- (CGFloat)contentWidth:(NSString *)str fontSize:(NSInteger )fontsize HeightSize:(NSInteger )HeightSize
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, HeightSize) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontsize]} context:nil];
    return CGRectGetWidth(rect);
}
//获取设备UUID
- (NSString *)getUUID
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
//检测token是否变化
-(void)isChangeTokenofrt:(NSString *)rt timestamp:(NSString *)timestamp
{
//    NSString *key =[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@",timestamp] substringToIndex:9],@"!@ftyl@"];
//    NSString *token = [Security AesDecrypt:rt Key:key];
//    //判断token是否变化
//    if ([token isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]])
//    {
//
//    }else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
//    }
}
//退出登录
- (void)backLogin:(NSString *)str
{
    
//    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *canCleAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        //记录退出登录状态
//        NSUserDefaults *loginUD=[NSUserDefaults standardUserDefaults];
//        [loginUD setObject:@"no" forKey:@"loginState"];
//
//        loginVC *login = [[loginVC alloc]init];
//        [self.navigationController pushViewController:login animated:NO];
//
//    }];
//    [alertView addAction:canCleAction];
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate.window.rootViewController presentViewController:alertView animated:YES completion:nil];
}
//根据时间戳转换时间
-(NSString *)timestampSwitchTime:(NSString *)timestamp andFormatter:(NSString *)format{
    
    NSTimeInterval interval=[timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
