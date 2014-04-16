//
//  inviteDetailViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "inviteDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "SBJsonParser.h"

#import "MobClick.h"
@interface inviteDetailViewController ()

@end

@implementation inviteDetailViewController
@synthesize inforDic;
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
    jobDetailDic = [[NSDictionary alloc] init];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"招聘详情"];
    [MobClick beginLogPageView:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"招聘详情"];
    [MobClick endLogPageView:cName];
}
-(void)leftButtonClick
{
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
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 24, 26);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    
    
    Lab.text = @"招聘详情";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}
-(void)getData
{

    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=jobs&a=jobsView"]]];
   
    
    [request setPostValue:[inforDic objectForKey:@"id"] forKey:@"id"];
    
    
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"招聘详情dic:%@",dic);
        
        jobDetailDic = [dic objectForKey:@"jobs_info"];

        [self freashView];
    }
}

-(void)freashView
{
    NSString * headStr= [jobDetailDic objectForKey:@"head_photo"];
    NSString * nameStr = [jobDetailDic objectForKey:@"username"];
    NSString * storeNameStr = [jobDetailDic objectForKey:@"store_name"];
     NSString * workPlaceStr = [jobDetailDic objectForKey:@"job"];
    NSString * workAddressStr = [jobDetailDic objectForKey:@"city"];
    NSString * numStr = [jobDetailDic objectForKey:@"number"];
    NSString * moneyStr = [jobDetailDic objectForKey:@"money"];
    NSString * addressStr = [jobDetailDic objectForKey:@"address"];
    NSString * mobileStr = [jobDetailDic objectForKey:@"telephone"];
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = [NSString stringWithFormat:@"%@", nameStr ];
    _storeNameLable.text = [NSString stringWithFormat:@"店铺名称: %@", storeNameStr ];
    _workPlaceLable.text= [NSString stringWithFormat:@"招聘职位: %@", workPlaceStr ];
    _workCityLable.text= [NSString stringWithFormat:@"工作城市: %@", workAddressStr ];
    _numOfNeedLable.text= [NSString stringWithFormat:@"招聘人数: %@", numStr ];
    _moneyLable.text= [NSString stringWithFormat:@"薪酬待遇: %@", moneyStr ];
    _storeAddressLable.text =[NSString stringWithFormat:@"店铺地址: %@", addressStr ] ;
    _telephoneLable.text= [NSString stringWithFormat:@"联系电话: %@", mobileStr ];
//    _talkButton
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)talkButtonClick:(UIButton *)sender {
    

    talkView=nil;
    talkView = [[talkViewController alloc] init];
    talkView.uid = [jobDetailDic objectForKey:@"uid"];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (![appDele.uid isEqualToString:talkView.uid]) {
        [self.navigationController pushViewController:talkView animated:NO];
        
    }

}
@end
