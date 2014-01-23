//
//  anwserCenterViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "anwserCenterViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface anwserCenterViewController ()

@end

@implementation anwserCenterViewController
@synthesize _hidden;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    dic=[[NSDictionary alloc] init];
//    questionButton=[[UIButton alloc] init];
//    questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [questionButton.layer setMasksToBounds:YES];
//    [questionButton.layer setCornerRadius:10.0];
//    [questionButton.layer setBorderWidth:1.0];
//    [questionButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 1, 0, 0, 1 })];//边框颜色
//    [questionButton setTitle:@"我要提问" forState:UIControlStateNormal];
//    [questionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [questionButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [questionButton addTarget:self action:@selector(questionButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    questionButton.frame = CGRectMake(10, 240, 300, 40);
//    
//    
//    anwserButton=[[UIButton alloc] init];
//    anwserButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [anwserButton.layer setMasksToBounds:YES];
//    [anwserButton.layer setCornerRadius:10.0];
//    [anwserButton.layer setBorderWidth:1.0];
//    [anwserButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 1, 0, 0, 1 })];//边框颜色
//    [anwserButton setTitle:@"我的问题" forState:UIControlStateNormal];
//    [anwserButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [anwserButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [anwserButton addTarget:self action:@selector(anwserButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    anwserButton.frame = CGRectMake(10, 300, 300, 40);
    
    questionButton=[[UIButton alloc] init];
    questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionButton.layer setMasksToBounds:YES];
    [questionButton.layer setCornerRadius:5.0];
    [questionButton.layer setBorderWidth:1.0];
    [questionButton setBackgroundColor:[UIColor colorWithRed:88.0/256.0 green:193.0/256.0 blue:189.0/256.0 alpha:1.0]];
    [questionButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
       [questionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [questionButton addTarget:self action:@selector(questionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    questionButton.frame = CGRectMake(5, 200, 310, 40);
    
    
    anwserButton=[[UIButton alloc] init];
    anwserButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [anwserButton.layer setMasksToBounds:YES];
    [anwserButton.layer setCornerRadius:5.0];
    [anwserButton.layer setBorderWidth:1.0];
    [anwserButton setBackgroundColor:[UIColor colorWithRed:244.0/256.0 green:22.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [anwserButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
   
    [anwserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [anwserButton addTarget:self action:@selector(anwserButtonClick) forControlEvents:UIControlEventTouchUpInside];
    anwserButton.frame = CGRectMake(5, 260, 310, 40);
    

    [self.view addSubview:questionButton];
    [self.view addSubview:anwserButton];
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"问答中心"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([appDele.type isEqualToString:@"1"]) {
        [questionButton setTitle:@"我要提问" forState:UIControlStateNormal];
        
    }
    else
    {
        [questionButton setTitle:@"同城问题" forState:UIControlStateNormal];
        
    }
    if ([appDele.type isEqualToString:@"1"]) {
        [anwserButton setTitle:@"我的问题" forState:UIControlStateNormal];
        
    }
    else
    {
        [anwserButton setTitle:@"我的回答" forState:UIControlStateNormal];
        
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"问答中心"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}
-(void)getSmameCityQuestion
{
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSURL * urlString= [NSURL URLWithString:@"hhttp://wap.faxingw.cn/index.php?m=Problem&a=findissue"];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:appDele.city forKey:@"city"];
    [request startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        dic=[jsonP objectWithString:jsonString];
        NSLog(@"获取同城问题dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {

            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView._hidden =@"yes";
            talkView.talkOrQuestion=@"question";
            talkView.sameCityQuestion=@"samecity";
            talkView.questionId= [dic objectForKey:@"pid"];
            talkView.uid = [dic objectForKey:@"uid"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView ];
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"获取同城问题出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)questionButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
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

    if ([appDele.type isEqualToString:@"1"])
    {
        pubQ = nil;
        pubQ = [[pubQViewController alloc] init];
        pubQ._hidden  =@"yes";
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:pubQ];
    }
    else//发型师的同城提问
    {
        [self getSmameCityQuestion];
    }
    }
    
}

-(void)anwserButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

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


    if ([appDele.type isEqualToString:@"1"]) {
        myAnwserView= nil;
        myAnwserView = [[myAnwserCenterViewController alloc] init];
        myAnwserView._hidden  =@"yes";
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        myAnwserView.uid = appDele.uid;
        
        myAnwserView.whoLookQuestion=@"self";
        [appDele pushToViewController:myAnwserView  ];
    }
     else//发型师的回答
    {
        myAnwserList = nil;
        myAnwserList= [[myAnwserListViewController alloc] init];
        myAnwserList._hidden = @"yes";
//        myAnwserList.questionId = [[dresserArray  objectAtIndex:_index] objectForKey:@"id"];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:myAnwserList  ];
    }
        
    }
   
}
-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    leftButton.frame = CGRectMake(12,20, 60, 25);
    leftButton.frame = CGRectMake(0,0, 0, 0);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
   
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    
    
    Lab.text = @"问答中心";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
