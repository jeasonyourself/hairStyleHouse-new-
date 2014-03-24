//
//  LoginView.m
//  发型屋
//
//  Created by apple on 13-7-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//



#import "LoginView.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@implementation LoginView
@synthesize tentenOAuth;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self cLoginView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

#pragma mark - Creat View
-(void)cLoginView//访问用户具体资料：
{
    self.backgroundColor = [UIColor whiteColor];
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
    [self addSubview:QQButton];
    [self addSubview:sinaButton];
    
    
    
    
//    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    (dele.xuanzheLoginType==NULL)?[self xuanzheView]:NULL;
//    ([dele.xuanzheLoginType isEqual:@"qq"])?[self qqBtnClick]:NULL;
////    ([dele.xuanzheLoginType isEqual:@"sina"])?[self sinaBtnClick]:NULL;
    
   
    
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
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"LoginView",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}
#pragma mark - Delegate
//-(void)qqBtnClick
//{
//    
//    
//}

//-(void)sinaBtnClick
//{
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    _sinaweibo = delegate.sinaweibo;
//    _sinaweibo.delegate=self;
//    delegate.loginType=@"sina";
//    [_sinaweibo logIn];
//    
//}

//- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response
//{
//    //    NSLog(@"%@",response);
//}
//
//- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
//{
//    //    NSLog(@"%@",error);
//}
//- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
//{
//    //    NSLog(@"%@",data);
//    //    NSString* str=[NSString stringWithUTF8String:data];
//    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//    
//    NSString*jsonString = [[NSString alloc]initWithBytes:[data bytes]length:[data length]encoding:NSUTF8StringEncoding];
//    
//    //    NSDictionary* dic=[jsonP objectWithString:jsonString];
//    NSDictionary* dic=[jsonP objectWithData:data];
//    sType=@"sina";
//    sImageUrl=[dic objectForKey:@"profile_image_url"];
//    //    NSLog(@"%@",sImageUrl);
//    sUserName=[dic objectForKey:@"name"];
//    //    NSLog(@"%@",sUserName);
//    sExpirationDate=(NSString*)[_sinaweibo expirationDate];
//    //    NSLog(@"sExpirationDate=====%@",sExpirationDate);
//    sAccess_token=[_sinaweibo accessToken];
//    //    sOpenId=[_sinaweibo userID];
//    //    sOpenId=[dic objectForKey:@"id"];
//    sOpenId=[_sinaweibo userID];
//    //    NSLog(@"sOpenId=========%@",sOpenId);
//    [self postSinaData];
//    
//}
//
//-(void)postSinaData
//{
//    [self cJiaZaiView];
//    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Index&a=login"]];
//    request.tag=2;
//    
//    [request setPostValue:sImageUrl forKey:@"head_photo"];
//    [request setPostValue:sUserName forKey:@"username"];
//    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    dele.userName=sUserName;
//    [request setPostValue:[_sinaweibo userID] forKey:@"sina_keyid"];
//    NSLog(@"%@",[_sinaweibo userID]);
//    [request setPostValue:@"" forKey:@"qq_keyid"];
//    
//    request.delegate=self;
//    [request startAsynchronous];
//}

-(void)getBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err
{
    interface =inter;
    sucfun = suc;
    errfun =err;
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
    
    expirationDate=(NSString*)_tencentOAuth.expirationDate;
    

    [self postTententData];
}

-(void)postTententData
{
//    [self cJiaZaiView];
    [self removeFromSuperview];

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

#pragma mark - Creat JiaZai View
//-(void)cJiaZaiView
//{
//    jiaZiaView=[[UIImageView alloc] init];
//    jiaZiaView.frame=CGRectMake(0, 0, 320, 362);
//    jiaZiaView.image=[UIImage imageNamed:@"加载@2x.png"];
//    [self addSubview:jiaZiaView];
//    UIActivityIndicatorView*aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
//    aiv.center = CGPointMake(jiaZiaView.bounds.origin.x + jiaZiaView.bounds.size.width/2, jiaZiaView.bounds.origin.y +jiaZiaView.bounds.size.height/2-15);
//    [aiv startAnimating];
//    [jiaZiaView addSubview:aiv];  //加载view中添加转圈
//}

-(void)requestFinished:(ASIHTTPRequest *)request
{

    if (request.tag==1)
    {
        NSLog(@"%@",request.responseString);
        //    if (request.tag==1||request.tag==2) {
        
        
        NSLog(@"1111111====%@",request.responseString);
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:request.responseString];
        backId=[dic objectForKey:@"uid"];
        AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
        appDel.type=[dic objectForKey:@"type"];
        appDel.touxiangImage=[dic objectForKey:@"head_photo"];
        appDel.uid=backId;//将值赋再appdelegat.uid上
//        appDel.city=[dic objectForKey:@"city"];
        //        if (request.tag==1) {
        //            appDel.loginType=@"qq";
        //        }
        //        else{
        //        appDel.loginType=@"sina";
        //        }
        //
        //NSuserDefaults
        NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:backId forKey:@"uid"];
        [ud setObject:[dic objectForKey:@"type"] forKey:@"type"];
        
        
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=coordinates"]]];
        request.delegate=self;
        request.tag=2;
        
        [request setPostValue:appDel.uid forKey:@"uid"];
        
        [request setPostValue:appDel.secret forKey:@"secret"];
        //         NSLog(@"%f",appDele.longitude);
        //        NSLog(@"%f",appDele.latitude);
        [request setPostValue:[NSString stringWithFormat:@"%f",appDel.longitude ] forKey:@"lng"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDel.latitude ] forKey:@"lat"];
        
        [request startAsynchronous];
        
        //    [interface performSelectorOnMainThread:successfun withObject:_rs waitUntilDone:YES];
        
        //        if (request.tag==1) {
        //            [ud setObject:@"qq"forKey:@"loginType"];
        //        }
        //        else{
        //            [ud setObject:@"sina"forKey:@"loginType"];
        //        }
        
        //    }
        //    AppDelegate* appdele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
    }
    
    else if(request.tag==2)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"修改经纬度dic:%@",dic);
        
        
        
        [interface performSelectorOnMainThread:sucfun withObject:nil waitUntilDone:NO];
    }
    

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
@end
