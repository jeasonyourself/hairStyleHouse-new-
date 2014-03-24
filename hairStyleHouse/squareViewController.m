//
//  squareViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "squareViewController.h"
#import "AppDelegate.h"
#import "myShowViewController.h"
#import "BaiduMobStat.h"
@interface squareViewController ()

@end

@implementation squareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
        Lab.text = @"问答中心";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView* myStyleMyShow=[[UIImageView alloc] init];
    myStyleMyShow.frame=CGRectMake(10, 90, 300, 130);
    myStyleMyShow.image=[UIImage imageNamed:@"我型我秀.png"];
//    [self.view addSubview:myStyleMyShow];
    
    UIImageView* hotTalk=[[UIImageView alloc] init];
    hotTalk.frame=CGRectMake(10, 240, 145, 70);
    hotTalk.image=[UIImage imageNamed:@"热门话题.png"];
//    [self.view addSubview:hotTalk];
    
    
    UIImageView* information=[[UIImageView alloc] init];
    information.frame=CGRectMake(165, 240, 145, 70);
    information.image=[UIImage imageNamed:@"行业情报.png"];
//    [self.view addSubview:information];
    
    UIImageView* saleBeaspeak=[[UIImageView alloc] init];
    saleBeaspeak.frame=CGRectMake(10, 320, 145, 70);
    saleBeaspeak.image=[UIImage imageNamed:@"特惠预约.png"];
//    [self.view addSubview:saleBeaspeak];
    
    UIImageView* anwser=[[UIImageView alloc] init];
    anwser.frame=CGRectMake(165, 320, 145, 70);
    anwser.image=[UIImage imageNamed:@"问答中心.png"];
//    [self.view addSubview:anwser];
    
    UIImageView* sameCity=[[UIImageView alloc] init];
    sameCity.frame=CGRectMake(10, 400, 145, 70);
    sameCity.image=[UIImage imageNamed:@"同城.png"];
//    [self.view addSubview:sameCity];
    
    UIImageView* inviteInfor=[[UIImageView alloc] init];
    inviteInfor.frame=CGRectMake(165, 400, 145, 70);
    inviteInfor.image=[UIImage imageNamed:@"招聘信息.png"];
//    [self.view addSubview:inviteInfor];
    
    
    //kechu shijian  Tag
    myStyleMyShow.userInteractionEnabled=YES;
    hotTalk.userInteractionEnabled=YES;
    information.userInteractionEnabled=YES;
    saleBeaspeak.userInteractionEnabled=YES;
    anwser.userInteractionEnabled=YES;
    sameCity.userInteractionEnabled=YES;
    inviteInfor.userInteractionEnabled=YES;
    
    
    myStyleMyShow.tag=0;
    hotTalk.tag=1;
    information.tag=2;
    saleBeaspeak.tag=3;
    anwser.tag=4;
    sameCity.tag=5;
    inviteInfor.tag=6;
    //shoushi
    UITapGestureRecognizer* tapZore=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [myStyleMyShow addGestureRecognizer:tapZore];
    
    UITapGestureRecognizer* tapOne=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [hotTalk addGestureRecognizer:tapOne];
    
    UITapGestureRecognizer* tapTwo=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [information addGestureRecognizer:tapTwo];
    
    UITapGestureRecognizer* tapThree=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [saleBeaspeak addGestureRecognizer:tapThree];
    
    UITapGestureRecognizer* tapFour=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [anwser addGestureRecognizer:tapFour];
    
    UITapGestureRecognizer* tapFive=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [sameCity addGestureRecognizer:tapFive];
    
    UITapGestureRecognizer* tapSix=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [inviteInfor addGestureRecognizer:tapSix];
	// Do any additional setup after loading the view.
    
    
    //新版
    anwserCenter = nil;
    anwserCenter= [[anwserCenterViewController alloc] init];
    anwserCenter._hidden = @"yes";
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"问答中心"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
[self.navigationController pushViewController:anwserCenter animated:NO];
}
//#pragma mark - View lifecycle
//
//-(void) viewDidAppear:(BOOL)animated
//{
//    NSString* cName = [NSString stringWithFormat:@"%@",  self.tabBarItem.title, nil];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
//    
//}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"问答中心"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)tapView:(UITapGestureRecognizer* )tap
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    switch (tap.view.tag) {
        case 0:
            myShow = nil;
            myShow = [[myShowViewController alloc] init];
            [ appDele pushToViewController:myShow];
            break;
        case 1:
            if (!appDele.uid)
            {
                loginView=nil;
                loginView=[[loginViewController alloc] init];
                loginView._hidden=@"yes";
                loginView.view.frame=self.view.bounds;
//                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
                //        loginView.userInteractionEnabled=YES;
                //        [self.view addSubview:loginView];
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                
                [appDele pushToViewController:loginView ];
            }
            else
            {
                hotView = nil;
                hotView= [[hotTalkViewController alloc] init];
                hotView._hidden = @"yes";
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                [appDele pushToViewController:hotView ];
            }
            break;
        case 2:
            if (!appDele.uid)
            {
                loginView=nil;
                loginView=[[loginViewController alloc] init];
                loginView._hidden=@"yes";
                loginView.view.frame=self.view.bounds;
                //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
                //        loginView.userInteractionEnabled=YES;
                //        [self.view addSubview:loginView];
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                
                [appDele pushToViewController:loginView ];
            }
            else
            {
                wayView = nil;
                wayView= [[wayInforViewController alloc] init];
                wayView._hidden = @"yes";
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                [appDele pushToViewController:wayView ];
            }
            break;
        case 3:
        {
            saleView = nil;
            saleView= [[saleBeaspeaskViewController alloc] init];
            saleView._hidden = @"yes";
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            [appDele pushToViewController:saleView ];
        }
            break;
        case 4:
            if (!appDele.uid)
            {
                loginView=nil;
                loginView=[[loginViewController alloc] init];
                loginView._hidden=@"yes";
                loginView.view.frame=self.view.bounds;
                //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
                //        loginView.userInteractionEnabled=YES;
                //        [self.view addSubview:loginView];
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                
                [appDele pushToViewController:loginView ];
            }
            else
            {
                
                anwserCenter = nil;
                anwserCenter= [[anwserCenterViewController alloc] init];
                anwserCenter._hidden = @"yes";
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                [appDele pushToViewController:anwserCenter ];
            }
            break;
        case 5:
        {
            
            sameCityView = nil;
            sameCityView= [[sameCityViewController alloc] init];
            sameCityView._hidden = @"yes";
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            [appDele pushToViewController:sameCityView ];
        }
            break;
           
        case 6:
            
            if (!appDele.uid)
            {
                loginView=nil;
                loginView=[[loginViewController alloc] init];
                loginView._hidden=@"yes";
                loginView.view.frame=self.view.bounds;
                //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
                //        loginView.userInteractionEnabled=YES;
                //        [self.view addSubview:loginView];
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                
                [appDele pushToViewController:loginView ];
            }
            else
            {
                inviteView = nil;
                inviteView= [[inviteViewController alloc] init];
                inviteView._hidden = @"yes";
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
                [appDele pushToViewController:inviteView ];
            }
            break;
        default:
            
            break;
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
