//
//  dresserMySetSingleCellViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-31.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserMySetSingleCellViewController.h"
#import "mySetViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface dresserMySetSingleCellViewController ()

@end

@implementation dresserMySetSingleCellViewController
@synthesize fatherController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)tencentDidLogin
{
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{}
- (void)tencentDidNotNetWork
{}
- (void)viewDidLoad
{
    [super viewDidLoad];
    inforDic = [[NSMutableDictionary alloc] init];
    _changeInforView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _changeInforView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _changeInforView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _changeInforView.layer.masksToBounds = YES;//设为NO去试试
    
    _beaspeakSetView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _beaspeakSetView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _beaspeakSetView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _beaspeakSetView.layer.masksToBounds = YES;//设为NO去试试
    
    _messageView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _messageView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _messageView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _messageView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _sinaView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sinaView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sinaView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sinaView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _tencentView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _tencentView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _tencentView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _tencentView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _SuggestView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _SuggestView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _SuggestView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _SuggestView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _userHelpView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _userHelpView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _userHelpView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _userHelpView.layer.masksToBounds = YES;//设为NO去试试
    
    _clearAllView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _clearAllView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _clearAllView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _clearAllView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _updateLevelView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _updateLevelView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _updateLevelView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _updateLevelView.layer.masksToBounds = YES;//设为NO去试试
    
    _updateLevelView.hidden = YES;
    
    
    _sigoutButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sigoutButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sigoutButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sigoutButton.layer.masksToBounds = YES;//设为NO去试试
   
    
    [self getData];
    userInforArr = [[NSMutableArray alloc] init];
    userInfor = [[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"设置"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"设置"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    ASIHTTPRequest* request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=site&uid=%@",appDele.uid]]];
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
        NSLog(@"是否绑定dic:%@",dic);
        inforDic = [dic objectForKey:@"user_info"];
        [self freashView];
    }
}
-(void)freashView
{
    if ([inforDic objectForKey:@"qq_keyid"])
    {
        _tencentLable.text=@"已绑定";
        _tencentButton.enabled= NO;
    }
    else
    {
        _tencentLable.text=@"未绑定";
        _tencentButton.enabled= YES;
    }
    
    if ([inforDic objectForKey:@"sina_keyid"])
    {
        _sinaLable.text=@"已绑定";
        _sinaButton.enabled= NO;
        
    }
    else
    {
        _sinaLable.text=@"未绑定";
        _sinaButton.enabled= YES;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeInforButtonClick:(id)sender {
    personInfor = nil;
    personInfor =[[personInforViewController alloc] init];
    personInfor._hidden =@"no";
    [fatherController pushToViewController:personInfor];
}

- (IBAction)beaspeakButtonClick:(id)sender
{
    setBeaspeakView = nil;
    setBeaspeakView =[[setBeaspeakViewController alloc] init];
    setBeaspeakView._hidden =@"no";
    [fatherController pushToViewController:setBeaspeakView];
}

- (IBAction)messageButtonClick:(id)sender
{
    setOpenOrCloseView= nil;
    setOpenOrCloseView =[[setOpenOrCloseViewController alloc] init];
    setOpenOrCloseView._hidden =@"no";
    [fatherController pushToViewController:setOpenOrCloseView];
}

- (IBAction)sinaButtonClick:(id)sender
{
    rigView = nil;
    rigView  = [[rigViewController alloc] init] ;
    rigView._hidden = NO;
    rigView._backsign = @"sina";
    [fatherController pushToViewController:rigView];
}

- (IBAction)tencentButtonClick:(id)sender
{
    rigView = nil;
    rigView  = [[rigViewController alloc] init] ;
    rigView._hidden = NO;
    rigView._backsign = @"qq";
    [fatherController pushToViewController:rigView];
}

- (IBAction)suggestButtonClick:(id)sender
{
    adviceView = nil;
    adviceView =[[adviceViewController alloc] init];
    adviceView._hidden =@"no";
    [fatherController pushToViewController:adviceView];
}

- (IBAction)userHelpButtonClick:(id)sender
{
    helpView = nil;
    helpView =[[helpViewController alloc] init];
    helpView._hidden =@"no";
    [fatherController pushToViewController:helpView];
}

- (IBAction)clearAllButtonClick:(id)sender
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"清除缓存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)updateLevelButtonClick:(id)sender
{
    
}

- (IBAction)sinoutButtonClick:(id)sender
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    appDele.uid = nil;
    appDele.uid = nil;
    appDele.type = nil;
    appDele.loginType = nil;
    [appDele.tententOAuth logout:self];
    appDele.tententOAuth=nil;
    

//    appDele.sinaweibo=nil;
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString * plistString = [NSString stringWithFormat:@"userInfor"];
    NSString *filename=[path stringByAppendingPathComponent:plistString];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    
    userInforArr = [NSMutableArray arrayWithArray:dataArray];
    userInfor =[dataArray objectAtIndex:0];
    [userInfor removeObjectForKey:@"type"];
    [userInforArr addObject:userInfor];
    [userInforArr writeToFile:filename atomically:YES];
    
    //    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    //    //    [ud removeObjectForKey:@"uid"];
    //    [ud removeObjectForKey:@"type"];
    
    [fatherController pushToRoot];
    
}
@end
