//
//  tabbarVC.m
//  yyRemoteDiagnosis
//
//  Created by feetto on 2018/4/28.
//  Copyright © 2018年 feetto. All rights reserved.
//

#import "tabbarVC.h"
#import "loginVC.h"
#import "imageHallVC.h"
#import "consultingRoomVC.h"
#import "myVC.h"
#import "AppDelegate.h"
@interface tabbarVC ()
{
    UIImageView *imageView1;
    UILabel     *lable1;
    UIImageView *imageView2;
    UILabel     *lable2;
    UIImageView *imageView3;
    UILabel     *lable3;
}
@property (nonatomic,strong)UIButton *barItem1;
@property (nonatomic,strong)UIButton *barItem2;
@property (nonatomic,strong)UIButton *barItem3;
@end

@implementation tabbarVC
-(UIButton *)barItem1
{
    if (!_barItem1) {
        self.barItem1 = [[UIButton alloc]init];
    }
    return _barItem1;
}
-(UIButton *)barItem2
{
    if (!_barItem2) {
        self.barItem2 = [[UIButton alloc]init];
    }
    return _barItem2;
}
-(UIButton *)barItem3
{
    if (!_barItem3) {
        self.barItem3 = [[UIButton alloc]init];
    }
    return _barItem3;
}
- (UIView *)tabbarBgView
{
    if (!_tabbarBgView) {
        self.tabbarBgView = [[UIView alloc]init];
        if (kDevice_Is_iPhoneX == YES) {
            _tabbarBgView.frame = CGRectMake(0, SCREEN_HEIGHT-83, SCREEN_WIDTH, 83);
        }else
        {
            _tabbarBgView.frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
        }
        _tabbarBgView.backgroundColor = [UIColor redColor];
    }
    return _tabbarBgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTabbar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    //隐藏系统navigation
//    self.navigationController.navigationBar.hidden = NO;
//
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginState"] isEqualToString:@"yes"])
//    {
//
//        //NSLog(@"进入主页");
//    }else
//    {
//        loginVC *login = [[loginVC alloc]init];
//        [self presentViewController:login animated:YES completion:nil];
//    }
}
- (void)setTabbar
{
    
    //影像大厅
    imageHallVC *firstVC = [[imageHallVC alloc]init];
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:firstVC];
    
    //诊室
    consultingRoomVC *secondVC = [[consultingRoomVC alloc]init];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:secondVC];
    
    //个人中心
    myVC  *thirdVC = [[myVC alloc]init];
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:thirdVC];
    
    //隐藏系统tabbar
    self.tabBar.hidden=YES;
    self.viewControllers = @[navi1,navi2,navi3];
    
    
    //自定义tabbar
    self.tabbarBgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tabbarBgView];
    
    //tabbarItem1(底部按钮1)
    self.barItem1.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, self.tabbarBgView.frame.size.height);
    [_barItem1 addTarget:self action:@selector(handleBar1Action) forControlEvents:UIControlEventTouchUpInside];
    [_barItem1 setTitleColor:UIColorWithRGBA(0, 181, 74, 1) forState:UIControlStateNormal];
    [self.tabbarBgView addSubview:_barItem1];
    if (!imageView1) {
        imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2-15, 10, 30, 30)];
    }
//    imageView1.image = [UIImage imageNamed:@"主页(选中)"];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    [_barItem1 addSubview:imageView1];
    if (!lable1) {
        lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH/3, 14)];
    }
    lable1.text = @"影像大厅";
    lable1.font = [UIFont systemFontOfSize:14];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.textColor = [UIColor whiteColor];
    [_barItem1 addSubview:lable1];
    
    
    //tabbarItem2(底部按钮2)
    self.barItem2.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, self.tabbarBgView.frame.size.height);
    [_barItem2 addTarget:self action:@selector(handleBar2Action) forControlEvents:UIControlEventTouchUpInside];
    [_barItem2 setTitleColor:UIColorWithRGBA(0, 181, 74, 1) forState:UIControlStateNormal];
    [self.tabbarBgView addSubview:_barItem2];
    if (!imageView2) {
        imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2-15, 10, 30, 30)];
    }
//    imageView2.image = [UIImage imageNamed:@"主页(选中)"];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [_barItem2 addSubview:imageView2];
    if (!lable2) {
        lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH/3, 14)];
    }
    lable2.text = @"诊室";
    lable2.font = [UIFont systemFontOfSize:14];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.textColor = [UIColor whiteColor];
    [_barItem2 addSubview:lable2];
    
    
    //tabbarItem2(底部按钮3)
    self.barItem3.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, self.tabbarBgView.frame.size.height);
    [_barItem3 addTarget:self action:@selector(handleBar3Action) forControlEvents:UIControlEventTouchUpInside];
    [_barItem3 setTitleColor:UIColorWithRGBA(0, 181, 74, 1) forState:UIControlStateNormal];
    [self.tabbarBgView addSubview:_barItem3];
    if (!imageView3) {
        imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2-15, 10, 30, 30)];
    }
    imageView3.image = [UIImage imageNamed:@"个人中心"];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    [_barItem3 addSubview:imageView3];
    
    if (!lable3) {
        lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH/3, 14)];
    }
    lable3.text = @"我的";
    lable3.font = [UIFont systemFontOfSize:14];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.textColor = UIColorWithHex(0xdbdbdb);
    [_barItem3 addSubview:lable3];
    
    //隐藏tabbar,为以后扩展使用
    //[self.tabbarBgView removeFromSuperview];
}
//bar1按钮点击事件
- (void)handleBar1Action
{
    self.selectedIndex = 0;
//    imageView1.image = [UIImage imageNamed:@"主页(选中)"];
//    //    lable1.textColor = [UIColor whiteColor];
//    imageView2.image = [UIImage imageNamed:@"个人中心"];
//    //    lable2.textColor = UIColorWithHex(0xdbdbdb);
}

//bar2按钮点击事件
- (void)handleBar2Action
{
    self.selectedIndex = 1;
//    imageView1.image = [UIImage imageNamed:@"主页"];
//    imageView2.image = [UIImage imageNamed:@"个人中心(选中)"];
}
- (void)handleBar3Action
{
    self.selectedIndex = 2;
//    imageView1.image = [UIImage imageNamed:@"主页"];
//    imageView2.image = [UIImage imageNamed:@"个人中心(选中)"];
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
