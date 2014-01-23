//
//  loginViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "loginViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "dresserViewController.h"
#import "BaiduMobStat.h"
@interface loginViewController ()

@end

@implementation loginViewController
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
    userInfor = [[NSMutableDictionary alloc] init];
    userInforArr = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (appDele.uid)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        
        
        
        
        [self cLoginView];
        
    }
}
-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"登陆"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (appDele.uid)
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
    else
    {
        
    }
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"登陆"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"登陆";
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
    if (dresserFatherController) {
//         [dresserFatherController fromFouceCancelBack:_backsign];
    }
   

    
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

#pragma mark - Creat View
-(void)cLoginView//访问用户具体资料：
{
    self.view.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    
    introLable = [[UILabel alloc] init];
    introLable.numberOfLines = 0;
    introLable.textColor = [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0];
    introLable.font = [UIFont systemFontOfSize:16.0];
    introLable.text = @"登陆之后，您可以";
    introLable.frame=CGRectMake(20, 90, 280, 30);
    
    firstLable = [[UILabel alloc] init];
    firstLable.numberOfLines = 0;
    firstLable.textColor = [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0];
    firstLable.font = [UIFont systemFontOfSize:16.0];
    firstLable.text = @"1、上传自己的发型和作品";
    firstLable.frame=CGRectMake(20, 120, 280, 30);
    
    
    secondLable = [[UILabel alloc] init];
    secondLable.numberOfLines = 0;
    secondLable.textColor = [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0];
    secondLable.font = [UIFont systemFontOfSize:16.0];
    secondLable.text = @"2、预约同城发型师或设置自己的预约";
    secondLable.frame=CGRectMake(20, 150, 280, 30);
    
    
    thirdLable = [[UILabel alloc] init];
    thirdLable.numberOfLines = 0;
    thirdLable.textColor = [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0];
    thirdLable.font = [UIFont systemFontOfSize:16.0];
    thirdLable.text = @"3、可以在问答中心发布和回答问题";
    thirdLable.frame=CGRectMake(20, 180, 280, 30);
    
    
    forthLable = [[UILabel alloc] init];
    forthLable.numberOfLines = 0;
    forthLable.textColor = [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0];
    forthLable.font = [UIFont systemFontOfSize:16.0];
    forthLable.text = @"4、收藏、评论、分享您喜欢的发型";
    forthLable.frame=CGRectMake(20, 210, 280, 30);
    [self.view addSubview:introLable];
    [self.view addSubview:firstLable];
    [self.view addSubview:secondLable];
    [self.view addSubview:thirdLable];
    [self.view addSubview:forthLable];
    
     AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    _tencentOAuth=[[TencentOAuth alloc] initWithAppId:@"100478968" andDelegate:self];
    appDele.tententOAuth=_tencentOAuth;
    _permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_share", nil];

    
    
    QQButton=[[UIButton alloc] init];
    QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQButton.layer setMasksToBounds:YES];
    [QQButton.layer setCornerRadius:5.0];
    [QQButton.layer setBorderWidth:1.0];
    [QQButton setBackgroundColor:[UIColor colorWithRed:88.0/256.0 green:193.0/256.0 blue:189.0/256.0 alpha:1.0]];
    [QQButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [QQButton setTitle:@"腾讯QQ登陆" forState:UIControlStateNormal];
    [QQButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [QQButton addTarget:self action:@selector(QQButtonClick) forControlEvents:UIControlEventTouchUpInside];
    QQButton.frame = CGRectMake(5, 270, 310, 40);
    
    
    sinaButton=[[UIButton alloc] init];
    sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaButton.layer setMasksToBounds:YES];
    [sinaButton.layer setCornerRadius:5.0];
    [sinaButton.layer setBorderWidth:1.0];
    [sinaButton setBackgroundColor:[UIColor colorWithRed:244.0/256.0 green:22.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [sinaButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sinaButton setTitle:@"新浪微博登陆" forState:UIControlStateNormal];
    [sinaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [sinaButton addTarget:self action:@selector(sinaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    sinaButton.frame = CGRectMake(5, 330, 310, 40);
    
    [self.view addSubview:QQButton];
    [self.view addSubview:sinaButton];
    
    
    
    
    //    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    (dele.xuanzheLoginType==NULL)?[self xuanzheView]:NULL;
    //    ([dele.xuanzheLoginType isEqual:@"qq"])?[self qqBtnClick]:NULL;
    ////    ([dele.xuanzheLoginType isEqual:@"sina"])?[self sinaBtnClick]:NULL;
    
    
    
}

-(void)QQButtonClick
{
    
    
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    _tencentOAuth=[[TencentOAuth alloc] initWithAppId:@"100478968" andDelegate:self];
//    appDele.tententOAuth=_tencentOAuth;
    
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
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Index&a=login"]];
    request.tag=2;
    
    [request setPostValue:sImageUrl forKey:@"head_photo"];
    [request setPostValue:sUserName forKey:@"username"];
    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    dele.userName=sUserName;
    [request setPostValue:[_sinaweibo userID] forKey:@"sina_keyid"];
    NSLog(@"%@",[_sinaweibo userID]);
    [request setPostValue:@"" forKey:@"qq_keyid"];
    
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

- (void)addShareResponse:(APIResponse*) response {
    
	
	
}




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
//    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"取消登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    
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
        //    NSLog(@"appid==%@",_tencentOAuth.appId);
        [_tencentOAuth getListAlbum];
        
        [_tencentOAuth getUserInfo];//获取用户信息参数
    }
    else
    {
        NSLog(@"登录不成功 没有获取accesstoken") ;
    }
   
    
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

}


-(void)postTententData
{
    //    [self cJiaZaiView];
    //    [self.view removeFromSuperview];
    
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Index&a=login"]];
    //
    //    qq_keyid
    //    sina_keyid
    //    username
    //    head_photo
    
    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    dele.userName=userName;
    
    request.delegate=self;
    request.tag=1;
    [request setPostValue:imageUrl forKey:@"head_photo"];
    [request setPostValue:userName forKey:@"username"];
    [request setPostValue:openId forKey:@"qq_keyid"];
    //    [request setPostValue:@"" forKey:@"sina_keyid"];
    [request startAsynchronous];
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1)//qq登陆
    {
        
        NSLog(@"%@",request.responseString);
        //    if (request.tag==1||request.tag==2) {
        
        
        NSLog(@"1111111====%@",request.responseString);
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:request.responseString];
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
        appDele.uid=[dic objectForKey:@"uid"];
        
        
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSLog(@"path = %@",path);
        NSString * plistString = [NSString stringWithFormat:@"userInfor"];
        NSString *filename=[path stringByAppendingPathComponent:plistString];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
        if (!dataArray)
        {
            //1. 创建一个plist文件
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:filename contents:nil attributes:nil];
        }
        else
        {
        userInfor=[dataArray objectAtIndex:0];
        }
//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
        [userInfor setObject:@"qq" forKey:@"loginType"];
        [userInfor setObject:[_tencentOAuth accessToken]  forKey:@"tencentOAuth_accesstoken"];
        [userInfor setObject:[_tencentOAuth openId]  forKey:@"tencentOAuth_openId"];
        [userInfor setObject:[_tencentOAuth expirationDate]  forKey:@"tencentOAuth_expirationDate"];
        
//        [userInforArr addObject:userInfor];
//        [userInforArr writeToFile:filename atomically:YES];
//        
        if ([[dic objectForKey:@"type"] isEqualToString:@"0"])
        {
            [userInforArr addObject:userInfor];
            [userInforArr writeToFile:filename atomically:YES];
            if ([_leftButtonhidden isEqualToString:@"yes"])
            {
                completeView = nil;
                completeView = [[mustCompleteViewController alloc] init];
                completeView._hidden = @"yes";
                [completeView getBack:self andSuc:@selector(firstCompleteInfo) andErr:nil];
                 AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
                [appDele pushToViewController:completeView];
            }
            else
            {
                completeView = nil;
                completeView = [[mustCompleteViewController alloc] init];
                completeView._hidden = @"no";
                [self.navigationController pushViewController:completeView animated:NO];

            }
        }
        else//已有type
        {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
        appDele.type=[dic objectForKey:@"type"];
        appDele.touxiangImage=[dic objectForKey:@"head_photo"];
        appDele.uid=[dic objectForKey:@"uid"];//将值赋再appdelegat.uid上

//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
//            if (![[dic objectForKey:@"uid"] isEqualToString:[userInfor objectForKey:@"uid"]])
//            {
//                [userInfor removeObjectForKey:@"sina_accesstoken"];
//                [userInfor removeObjectForKey:@"sina_userId"];
//                [userInfor removeObjectForKey:@"sina_expirationDate"];
//            }
//            else
//            {
//                [appDele.sinaweibo setAccessToken:[userInfor objectForKey:@"sina_accesstoken"]] ;
//                [appDele.sinaweibo setUserID:[userInfor objectForKey:@"sina_userId"]] ;
//                [appDele.sinaweibo setExpirationDate:[userInfor objectForKey:@"sina_expirationDate"]] ;
//            }
        [userInfor setObject:[dic objectForKey:@"uid"] forKey:@"uid"];
        [userInfor setObject:[dic objectForKey:@"type"] forKey:@"type"];
        [userInfor setObject:@"qq" forKey:@"loginType"];
        [userInfor setObject:[_tencentOAuth accessToken]  forKey:@"tencentOAuth_accesstoken"];
        [userInfor setObject:[_tencentOAuth openId]  forKey:@"tencentOAuth_openId"];
        [userInfor setObject:[_tencentOAuth expirationDate]  forKey:@"tencentOAuth_expirationDate"];
            [userInforArr addObject:userInfor];
            [userInforArr writeToFile:filename atomically:YES];
            
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=coordinates"]]];
        request.delegate=self;
        request.tag=3;
        
        [request setPostValue:appDele.uid forKey:@"uid"];

        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ] forKey:@"lng"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
        
        [request startAsynchronous];
            
            [interface performSelectorOnMainThread:sucfun withObject:nil waitUntilDone:NO];
            [self.navigationController popViewControllerAnimated:NO];

        }
        
    }
    else if(request.tag==2)
    {
        NSLog(@"%@",request.responseString);
        //    if (request.tag==1||request.tag==2) {
        
        
        NSLog(@"1111111====%@",request.responseString);
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:request.responseString];
        
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
        appDele.uid=[dic objectForKey:@"uid"];
//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSLog(@"path = %@",path);
        NSString * plistString = [NSString stringWithFormat:@"userInfor"];
        NSString *filename=[path stringByAppendingPathComponent:plistString];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
        if (!dataArray)
        {
            //1. 创建一个plist文件
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:filename contents:nil attributes:nil];
        }
        
        [userInfor setObject:@"sina" forKey:@"loginType"];
        
        [userInfor setObject:[_sinaweibo accessToken]  forKey:@"sina_accesstoken"];
        [userInfor setObject:[_sinaweibo userID]  forKey:@"sina_userId"];
        [userInfor setObject:[_sinaweibo expirationDate] forKey:@"sina_expirationDate"];
        if ([[dic objectForKey:@"type"] isEqualToString:@"0"])
        {
            [userInforArr addObject:userInfor];
            [userInforArr writeToFile:filename atomically:YES];
            if ([_leftButtonhidden isEqualToString:@"yes"])
            {
                completeView = nil;
                completeView = [[mustCompleteViewController alloc] init];
                completeView._hidden = @"yes";
                [completeView getBack:self andSuc:@selector(firstCompleteInfo) andErr:nil];
                AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
                [appDele pushToViewController:completeView];
            }
            else
            {
                completeView = nil;
                completeView = [[mustCompleteViewController alloc] init];
                completeView._hidden = @"no";
                [self.navigationController pushViewController:completeView animated:NO];
                
            }
        }
        else
        {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
        appDele.type=[dic objectForKey:@"type"];
        appDele.touxiangImage=[dic objectForKey:@"head_photo"];
        appDele.uid=[dic objectForKey:@"uid"];//将值赋再appdelegat.uid上
        
//        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
            
//            if (![[dic objectForKey:@"uid"] isEqualToString:[userInfor objectForKey:@"uid"]])
//            {
//                [userInfor removeObjectForKey:@"tencentOAuth_accesstoken"];
//                [userInfor removeObjectForKey:@"tencentOAuth_openId"];
//                [userInfor removeObjectForKey:@"tencentOAuth_expirationDate"];
//            }
//       else
//       {
//           
           
//           [appDele.tententOAuth setAccessToken:[userInfor objectForKey:@"tencentOAuth_accesstoken"]] ;
//           [appDele.tententOAuth setOpenId:[userInfor objectForKey:@"tencentOAuth_openId"]] ;
//           [appDele.tententOAuth setExpirationDate:[userInfor objectForKey:@"tencentOAuth_expirationDate"]] ;
           
           
//       }
        [userInfor setObject:[dic objectForKey:@"uid"] forKey:@"uid"];
        [userInfor setObject:[dic objectForKey:@"type"] forKey:@"type"];
        [userInfor setObject:@"sina" forKey:@"loginType"];
        
        [userInfor setObject:[_sinaweibo accessToken]  forKey:@"sina_accesstoken"];
        [userInfor setObject:[_sinaweibo userID]  forKey:@"sina_userId"];
        [userInfor setObject:[_sinaweibo expirationDate] forKey:@"sina_expirationDate"];
            [userInforArr addObject:userInfor];
            [userInforArr writeToFile:filename atomically:YES];
        
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=coordinates"]]];
        request.delegate=self;
        request.tag=3;
        
        [request setPostValue:appDele.uid forKey:@"uid"];
        //         NSLog(@"%f",appDele.longitude);
        //        NSLog(@"%f",appDele.latitude);
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ] forKey:@"lng"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
        
        [request startAsynchronous];
            
            [interface performSelectorOnMainThread:sucfun withObject:nil waitUntilDone:NO];
            //可改成请求个人信息成功后返回继续执行下一步
            [self.navigationController popViewControllerAnimated:NO];

        }

    }
    
    else if(request.tag==3)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"修改经纬度dic:%@",dic);
        
    }

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)firstCompleteInfo
{
    [interface performSelectorOnMainThread:sucfun withObject:nil waitUntilDone:NO];
  
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
