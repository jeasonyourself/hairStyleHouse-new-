//
//  setOpenOrCloseViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-22.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "setOpenOrCloseViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface setOpenOrCloseViewController ()

@end

@implementation setOpenOrCloseViewController
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
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"推送设置";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    
    _saveButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _saveButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _saveButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _saveButton.layer.masksToBounds = YES;//设为NO去试试
    [self refreashNav];
        [self getData];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"推送设置"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"推送设置"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
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
    leftButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
    
}

-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"])
    {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=settinginfo"]];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:appDele.uid forKey:@"uid"];
    //    [request setPostValue:self.orderId forKey:@"order_id"];
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
        NSLog(@"设置开关dic:%@",dic);
        
        if ([[dic objectForKey:@"iscomment"] isEqualToString:@"1"]) {
            _firstSwitch.on=YES;
        }
        else
        {
            _firstSwitch.on=NO;

        }
        if ([[dic objectForKey:@"ismessage"] isEqualToString:@"1"]) {
            _secondSwitch.on=YES;
        }
        else
        {
            _secondSwitch.on=NO;
            
        }
        if ([[dic objectForKey:@"isfans"] isEqualToString:@"1"]) {
            _thirdSwitch.on=YES;
        }
        else
        {
            _thirdSwitch.on=NO;
            
        }
        if ([[dic objectForKey:@"isreserve"] isEqualToString:@"1"]) {
            _forthSwitch.on=YES;
        }
        else
        {
            _forthSwitch.on=NO;
            
        }
        
    }
    if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"设置开关成功dic:%@",dic);
    }
    
}
- (IBAction)saveButtonClick:(id)sender
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=setting"]];
    request.delegate=self;
    request.tag=2;
    [request setPostValue:appDele.uid forKey:@"uid"];
    if (_firstSwitch.on==YES) {
        [request setPostValue:@"1" forKey:@"iscomment"];
        
    }
    else
    {
    [request setPostValue:@"0" forKey:@"iscomment"];
    }
    
    if ( _secondSwitch.on==YES) {
        [request setPostValue:@"1" forKey:@"ismessage"];
    }
    else
    {
        [request setPostValue:@"0" forKey:@"ismessage"];

    }
    
    if (_thirdSwitch.on==YES) {
        [request setPostValue:@"1" forKey:@"isfans"];

    }
    else
    {
        [request setPostValue:@"0" forKey:@"isfans"];

    }
    
    if (_forthSwitch.on==YES) {
        [request setPostValue:@"1" forKey:@"isreserve"];

    }
    else
    {
        [request setPostValue:@"0" forKey:@"isreserve"];

    }
    
    //    [request setPostValue:self.orderId forKey:@"order_id"];
    [request startAsynchronous];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
