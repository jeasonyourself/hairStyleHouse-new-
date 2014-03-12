//
//  rigViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-23.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "rigViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "dresserViewController.h"
#import "BaiduMobStat.h"
@interface rigViewController ()

@end

@implementation rigViewController
@synthesize tentenOAuth;
@synthesize dresserFatherController;
@synthesize _backsign;
@synthesize _hidden;
@synthesize _leftButtonhidden;

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
    self.view.backgroundColor=[UIColor whiteColor];
    [self refreashNavLab];
    if ([_leftButtonhidden isEqualToString:@"yes"])
    {
        [self refreashNav1];
    }
    else
    {
        [self refreashNav];
    }
    userInforArr = [[NSMutableArray alloc] init];
    userInfor= [[NSMutableDictionary alloc] init];
}
-(void)viewDidAppear:(BOOL)animated
{
//    if ([_backsign isEqualToString:@"qq"])
//    {
//        [self QQButtonClick];
//    }
//    else
//    {
//        [self sinaButtonClick];
//    }

    NSString* cName = [NSString stringWithFormat:@"绑定"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];

    self.view.backgroundColor = [UIColor whiteColor];
    QQButton=[[UIButton alloc] init];
    QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQButton.layer setMasksToBounds:YES];
    [QQButton.layer setCornerRadius:10.0];
    [QQButton.layer setBorderWidth:1.0];
    [QQButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 1, 0, 0, 1 })];//边框颜色
    [QQButton setTitle:@"QQ登陆" forState:UIControlStateNormal];
    [QQButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [QQButton addTarget:self action:@selector(QQButtonClick) forControlEvents:UIControlEventTouchUpInside];
    QQButton.frame = CGRectMake(10, 240, 300, 40);
    
    
    sinaButton=[[UIButton alloc] init];
    sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaButton.layer setMasksToBounds:YES];
    [sinaButton.layer setCornerRadius:10.0];
    [sinaButton.layer setBorderWidth:1.0];
    [sinaButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 1, 0, 0, 1 })];//边框颜色
    [sinaButton setTitle:@"新浪登陆" forState:UIControlStateNormal];
    [sinaButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [sinaButton addTarget:self action:@selector(sinaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    sinaButton.frame = CGRectMake(10, 300, 300, 40);
    [self.view addSubview:QQButton];
    [self.view addSubview:sinaButton];
    
    if ([_backsign isEqualToString:@"qq"])
    {
        sinaButton.hidden = YES;
    }
    else
    {
        QQButton.hidden = YES;
        
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"绑定"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}
-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"绑定";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
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
    [self.navigationController popViewControllerAnimated:YES];

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
-(void)refreashNav1
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:0.0];
    [leftButton.layer setBorderWidth:0.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    //    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,0, 0, 0);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}



-(void)QQButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    _tencentOAuth=[[TencentOAuth alloc] initWithAppId:@"100478968" andDelegate:self];
    appDele.tententOAuth=_tencentOAuth;
    
    _permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_share", nil];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [_tencentOAuth authorize:_permissions inSafari:NO];
    delegate.loginType=@"qq";
}

-(void)sinaButtonClick
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _sinaweibo = delegate.sinaweibo;
    _sinaweibo.delegate=self;
    delegate.loginType=@"sina";
    [_sinaweibo logIn];
}

- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //    NSLog(@"%@",response);
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    //    NSLog(@"%@",error);
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    //    NSLog(@"%@",data);
    //    NSString* str=[NSString stringWithUTF8String:data];
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    
    //    NSString*jsonString = [[NSString alloc]initWithBytes:[data bytes]length:[data length]encoding:NSUTF8StringEncoding];
    
    //    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSDictionary* dic=[jsonP objectWithData:data];
    sType=@"sina";
    sImageUrl=[dic objectForKey:@"profile_image_url"];
    //    NSLog(@"%@",sImageUrl);
    sUserName=[dic objectForKey:@"name"];
    //    NSLog(@"%@",sUserName);
    sExpirationDate=(NSString*)[_sinaweibo expirationDate];
    //    NSLog(@"sExpirationDate=====%@",sExpirationDate);
    sAccess_token=[_sinaweibo accessToken];
    //    sOpenId=[_sinaweibo userID];
    //    sOpenId=[dic objectForKey:@"id"];
    sOpenId=[_sinaweibo userID];
    //    NSLog(@"sOpenId=========%@",sOpenId);
    [self postSinaData];
    
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)postSinaData
{
    //    [self cJiaZaiView];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=binding"]];
    request.tag=2;
    
    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [request setPostValue:dele.uid forKey:@"uid"];
    [request setPostValue:[_sinaweibo userID] forKey:@"sina_keyid"];
       request.delegate=self;
    [request startAsynchronous];
}

#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    //将获取的信息打印 log。
    
    [_sinaweibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:_sinaweibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
    
    //    NSLog(@"______%@",sinaweibo.userID);
    
    
    
    
}

//- (void)addShareResponse:(APIResponse*) response {
//    NSLog(@"xxxxx");
//	if (response.retCode == URLREQUEST_SUCCEED)
//	{
//		
//		
//		NSMutableString *str=[NSMutableString stringWithFormat:@""];
//		for (id key in response.jsonResponse) {
//			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
//		}
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
//							  
//													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles:nil];
//		[alert show];
//		
//		
//		
//	}
//	else {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
//							  
//													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
//		[alert show];
//	}
//	
//	
//}




-(void)sinaButtonClick1//最新新浪sdk登陆调用这个
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
    [appDele getSinaLoginBack:self andSuc:@selector(sinaLoginAndPutData) andErr:nil];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"LoginView",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    appDele.loginType=@"sina";
    
    //    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)getBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err
{
    interface =inter;
    sucfun = suc;
    errfun =err;
}

-(void)sinaLoginAndPutData
{
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    [interface performSelectorOnMainThread:sucfun withObject:nil waitUntilDone:NO];
}



#pragma mark - OAuth Delegate
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    NSLog(@"登录不成功 没有获取accesstoken") ;
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"取消登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)tencentDidNotNetWork
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络链接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)tencentDidLogin
{
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        // 记录登录用户的OpenID、Token以及过期时间
        NSLog(@"tencentOAuth.accessToken====%@",_tencentOAuth.accessToken);
    }
    else
    {
        NSLog(@"登录不成功 没有获取accesstoken") ;
    }
    //    NSLog(@"appid==%@",_tencentOAuth.appId);
    [_tencentOAuth getListAlbum];
    
    [_tencentOAuth getUserInfo];//获取用户信息参数
    
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    id yy = [response jsonResponse];
    
    imageUrl=[yy objectForKey:@"figureurl_qq_2"];//简单的头像
    
    openId=_tencentOAuth.openId;
    
    type=@"qq";
    access_token=_tencentOAuth.accessToken;
    userName=[yy objectForKey:@"nickname"];
    NSLog(@"xxxxxxx===%@",yy);
    
    //    expirationDate=(NSString*)_tencentOAuth.expirationDate;
    
    [self postTententData];
    
    
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    //    [self.navigationController popViewControllerAnimated:YES];
    //    self.navigationController.navigationBar.hidden=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)postTententData
{
  
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Index&a=login"]];
    
    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    request.delegate=self;
    request.tag=1;
    [request setPostValue:dele.uid forKey:@"uid"];
    [request setPostValue:openId forKey:@"qq_keyid"];
    //    [request setPostValue:@"" forKey:@"sina_keyid"];
    [request startAsynchronous];
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1) {
        
        NSLog(@"%@",request.responseString);
        //    if (request.tag==1||request.tag==2) {
        
        
        NSLog(@"1111111====%@",request.responseString);
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:request.responseString];
        NSLog(@"是否绑定成功:%@",dic);
//        if ([[dic objectForKey:@"code"] isEqualToString:@"201"])
//        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该账号已被其他用户绑定，请重新绑定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
//        }
//        else
//        {
        //NSuserDefaults
        
//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSLog(@"path = %@",path);
        NSString * plistString = [NSString stringWithFormat:@"userInfor"];
        NSString *filename=[path stringByAppendingPathComponent:plistString];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
        
        userInforArr = [NSMutableArray arrayWithArray:dataArray];
        userInfor =[dataArray objectAtIndex:0];
        
//        [userInfor setObject:[_tencentOAuth accessToken]  forKey:@"tencentOAuth_accesstoken"];
//        [userInfor setObject:[_tencentOAuth openId]  forKey:@"tencentOAuth_openId"];
//        [userInfor setObject:[_tencentOAuth expirationDate]  forKey:@"tencentOAuth_expirationDate"];
//        }
        [userInforArr addObject:userInfor];
        [userInforArr writeToFile:filename atomically:YES];
        
        NSLog(@"tencentOAuth_accesstoken:%@", [[dataArray objectAtIndex:0] objectForKey:@"tencentOAuth_accesstoken"]);
        NSLog(@"tencentOAuth_accesstoken:%@", [[dataArray objectAtIndex:0] objectForKey:@"tencentOAuth_openId"]);

        NSLog(@"tencentOAuth_accesstoken:%@", [[dataArray objectAtIndex:0] objectForKey:@"tencentOAuth_expirationDate"]);

        }
    else if(request.tag==2)
    {
        NSLog(@"%@",request.responseString);
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:request.responseString];
        
        NSLog(@"是否绑定成功:%@",dic);

//        if ([[dic objectForKey:@"code"] isEqualToString:@"201"])
//        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该账号已被其他用户绑定，请重新绑定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
//        }
//        else
//        {
//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSLog(@"path = %@",path);
        NSString * plistString = [NSString stringWithFormat:@"userInfor"];
        NSString *filename=[path stringByAppendingPathComponent:plistString];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
        userInforArr = [NSMutableArray arrayWithArray:dataArray];
        userInfor =[dataArray objectAtIndex:0];
        
        //        }
        
        [userInfor setObject:[_sinaweibo accessToken]  forKey:@"sina_accesstoken"];
        [userInfor setObject:[_sinaweibo userID]  forKey:@"sina_userId"];
        [userInfor setObject:[_sinaweibo expirationDate] forKey:@"sina_expirationDate"];
        
        [userInforArr addObject:userInfor];
        [userInforArr writeToFile:filename atomically:YES];
        NSLog(@"sina_accesstoken:%@", [[dataArray objectAtIndex:0] objectForKey:@"sina_accesstoken"]);
        NSLog(@"sina_userId:%@", [[dataArray objectAtIndex:0] objectForKey:@"sina_userId"]);
        
        NSLog(@"sina_expirationDate:%@", [[dataArray objectAtIndex:0] objectForKey:@"sina_expirationDate"]);
//        }
        
    }
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

