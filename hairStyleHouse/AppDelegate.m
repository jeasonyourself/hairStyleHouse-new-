//
//  AppDelegate.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "AppDelegate.h"
#import "SBJson.h"
#import "ASIFormDataRequest.h"

#import "BaiduMobStat.h"
@implementation AppDelegate
@synthesize wbtoken;
@synthesize sinaweibo;
@synthesize tententOAuth;
@synthesize uid;
@synthesize loginType;
@synthesize xuanzheLoginType;
@synthesize type;
@synthesize longitude;
@synthesize latitude;
@synthesize touxiangImage;
@synthesize city;
@synthesize hostReach;
@synthesize isReachable;

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host//重要！！！
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = @"ReplaceMeWithYourChannel";//设置您的app的发布渠道
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendWifiOnly = YES; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 35;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s,测试时使用1S可以用来测试日志的发送。
//    statTracker.shortAppVersion  = IosAppVersion; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    statTracker.enableDebugOn = YES; //打开sdk调试接口，会有log打印
    [statTracker startWithAppId:@"2f279376bb"];//设置您在mtj网站上添加的app的appkey
    
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    userInfor = [[NSMutableDictionary alloc] init];
    
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
    
    
    
//    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    
//    NSLog(@"ud:%@",ud);
    if ([[dataArray objectAtIndex:0] objectForKey:@"uid"]&&[[dataArray objectAtIndex:0] objectForKey:@"type"])
    {
        self.uid =[[dataArray objectAtIndex:0] objectForKey:@"uid"];
        self.type = [[dataArray objectAtIndex:0] objectForKey:@"type"];
        self.loginType = [[dataArray objectAtIndex:0] objectForKey:@"loginType"];
        
        
//        tententOAuth =[[TencentOAuth alloc] initWithAppId:@"100478968" andDelegate:self];

            [self.tententOAuth setAccessToken:[[dataArray objectAtIndex:0] objectForKey:@"tencentOAuth_accesstoken"]] ;
            [self.tententOAuth setOpenId:[[dataArray objectAtIndex:0] objectForKey:@"tencentOAuth_openId"]] ;
            [self.tententOAuth setExpirationDate:[[dataArray objectAtIndex:0] objectForKey:@"tencentOAuth_expirationDate"]] ;

            [self.sinaweibo setAccessToken:[[dataArray objectAtIndex:0] objectForKey:@"sina_accesstoken"]] ;
            [self.sinaweibo setUserID:[[dataArray objectAtIndex:0] objectForKey:@"sina_userId"]] ;
            [self.sinaweibo setExpirationDate:[[dataArray objectAtIndex:0] objectForKey:@"sina_expirationDate"]] ;
        
//        NSLog(@"tencentOAuth_accesstoken:%@",tententOAuth.accessToken);
//        NSLog(@"tencentOAuth_openId:%@",tententOAuth.openId);
//
//        NSLog(@"tencentOAuth_expirationDate:%@",tententOAuth.expirationDate);

//        NSLog(@"sina_accesstoken:%@",sinaweibo.accessToken);
//        NSLog(@"sina_userId:%@",sinaweibo.userID);
//        
//        NSLog(@"sina_expirationDate:%@",sinaweibo.expirationDate);
        

     }

    
    
    findStyleController=[[findStyleViewController alloc] init];
    dresserController=[[dresserViewController alloc] init];
    squareController=[[squareViewController alloc] init];//老版本
   
    anwserCenter= [[anwserCenterViewController alloc] init];//新版本
    
    mineController=[[mineViewController alloc] init];
    
//    signStr = [[NSString alloc] init];
    
    firstNav = [[UINavigationController alloc] initWithRootViewController:findStyleController];
    secondNav = [[UINavigationController alloc] initWithRootViewController:dresserController];
    thirdNav = [[UINavigationController alloc] initWithRootViewController:anwserCenter];
    forthNav = [[UINavigationController alloc] initWithRootViewController:mineController];
//[firstNav.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    [secondNav.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    [thirdNav.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    [forthNav.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    [rootNav.navigationBar setBarStyle:UIBarStyleBlackOpaque];

    NSMutableArray* tabArray=[[NSMutableArray alloc] init];
    [tabArray addObject:firstNav];
    [tabArray addObject:secondNav];
    [tabArray addObject:thirdNav];
    [tabArray addObject:forthNav];
    
    
    rootTab=[[UITabBarController alloc] init];
    rootTab.delegate=self;
    rootTab.viewControllers=tabArray;
    rootTab.selectedIndex = 0;

    tabImageView=[[UIImageView alloc] init];
    tabImageView.frame=CGRectMake(0,-1, 320, 50);
    NSLog(@"tabImageView.frame:%@",NSStringFromCGRect(tabImageView.frame));
    NSLog(@"tabbar.frame:%@",NSStringFromCGRect(rootTab.tabBar.frame));
    tabImageView.image=[UIImage imageNamed:@"找发型新.png"];
    
    firstLable= [[UILabel alloc] init];
//    firstLable.text = @"找发型";
    firstLable.textAlignment = NSTextAlignmentCenter;
    [firstLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    firstLable.backgroundColor = [UIColor clearColor];
    firstLable.font = [UIFont systemFontOfSize:12.0];
    firstLable.frame = CGRectMake(0, 32, 80, 19);
    
    secondLable= [[UILabel alloc] init];
//    secondLable.text = @"发型师";
    secondLable.textAlignment = NSTextAlignmentCenter;
    secondLable.textColor = [UIColor whiteColor];
    secondLable.backgroundColor = [UIColor clearColor];
    secondLable.font = [UIFont systemFontOfSize:12.0];
    secondLable.frame = CGRectMake(80, 33, 80, 19);
    
    thirdLable= [[UILabel alloc] init];
//    thirdLable.text = @"问题";
    thirdLable.textAlignment = NSTextAlignmentCenter;
    thirdLable.textColor = [UIColor whiteColor];
    thirdLable.backgroundColor = [UIColor clearColor];
    thirdLable.font = [UIFont systemFontOfSize:12.0];
    thirdLable.frame = CGRectMake(162, 32, 80, 19);
    
    forthLable= [[UILabel alloc] init];
//    forthLable.text = @"我的";
    forthLable.textAlignment = NSTextAlignmentCenter;
    forthLable.textColor = [UIColor whiteColor];
    forthLable.backgroundColor = [UIColor clearColor];
    forthLable.font = [UIFont systemFontOfSize:12.0];
    forthLable.frame = CGRectMake(242, 32, 80, 19);
    
    [rootTab.tabBar addSubview:tabImageView];
    [tabImageView addSubview:firstLable];
    [tabImageView addSubview:secondLable];
    [tabImageView addSubview:thirdLable];
    [tabImageView addSubview:forthLable];

    
    
    rootNav = [[UINavigationController alloc] initWithRootViewController:rootTab ];
    rootNav.navigationBar.hidden=YES;
    [self.window setRootViewController:rootNav];
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    int index = tabBarController.selectedIndex;
    
//    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
//    [statTracker logEvent:@"TabClick3" eventLabel:[NSString stringWithFormat: @"Tab%d", index]];
    
    if (viewController == firstNav) {
//        signStr=@"1";
        tabImageView.image=[UIImage imageNamed:@"找发型新.png"];
        [firstLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        secondLable.textColor = [UIColor whiteColor];
        thirdLable.textColor = [UIColor whiteColor];
        forthLable.textColor = [UIColor whiteColor];
       
    }
    else if (viewController == secondNav) {
//        signStr=@"2";

        tabImageView.image=[UIImage imageNamed:@"发型师新.png"];
        [firstLable setTextColor:[UIColor whiteColor]];
        secondLable.textColor = [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        thirdLable.textColor = [UIColor whiteColor];
        forthLable.textColor = [UIColor whiteColor];
       
    }
    else if (viewController == thirdNav) {
//        signStr=@"3";

        tabImageView.image=[UIImage imageNamed:@"问发型新.png"];
        [firstLable setTextColor:[UIColor whiteColor]];
        secondLable.textColor = [UIColor whiteColor];
        thirdLable.textColor = [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        forthLable.textColor = [UIColor whiteColor];
        
    }
    else if (viewController==forthNav){
        
//        if (self.uid) {
//            signStr=@"4";
            tabImageView.image=[UIImage imageNamed:@"我的新.png"];
        [firstLable setTextColor:[UIColor whiteColor]];
        secondLable.textColor = [UIColor whiteColor];
        thirdLable.textColor = [UIColor whiteColor];
        forthLable.textColor = [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
            
//        }
//        else
//        {
//            
//            
//            loginView=nil;
//            loginView=[[loginViewController alloc] init];
////            [loginView getBack:self andSuc:@selector(getData) andErr:nil];
//            [self pushToViewController:loginView];
//            if ([signStr isEqualToString:@"1"]) {
//                rootTab.selectedViewController=firstNav;
//
//            }
//            else if ([signStr isEqualToString:@"2"]) {
//                rootTab.selectedViewController=secondNav;
//                
//            }
//            else if ([signStr isEqualToString:@"3"]) {
//                rootTab.selectedViewController=thirdNav;
//                
//            }
//        }
//        
        
    }
    
}
-(void)pushToViewController:(id)_sen
{
    rootNav.navigationBar.hidden =NO;
    [rootNav pushViewController:_sen animated:NO];
}


//qq
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([self.loginType isEqualToString:@"qq"])
    {
        return [TencentOAuth HandleOpenURL:url];

    }
    else
    {
        return [WeiboSDK handleOpenURL:url delegate:self];

    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

-(void)tencentDidLogin
{

}
-(void)tencentDidNotLogin:(BOOL)cancelled
{

}
-(void)tencentDidNotNetWork
{

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(void)getSinaLoginBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err
{
    interface =inter;
    sucfun = suc;
    errfun =err;
}
//sina
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
//        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
//        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
     
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
//        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        
//        [alert show];
        {
            NSString * userid = [(WBAuthorizeResponse *)response userID];
            wbtoken = [(WBAuthorizeResponse *)response accessToken];
            
            NSString * oathString = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",userid,wbtoken];//
            
            NSString * currentString = WeiboSDK.isWeiboAppInstalled?oathString:oathString;
            
            ASIHTTPRequest * asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:currentString]];
            asiRequest.delegate = self;
            asiRequest.tag=0;
            asiRequest.username = @"getUserInfo";
            [asiRequest startAsynchronous];
        }
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==0) {
  
    NSLog(@"%@",request.responseString);
    //    if (request.tag==1||request.tag==2) {
    
    
    NSLog(@"1111111====%@",request.responseString);
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:request.responseString];
    NSLog(@"%@",dic);
    
    //发送新浪注册信息
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Index&a=login"]];
//    AppDelegate* dele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    request.delegate=self;
    request.tag=1;
    [request setPostValue:[dic objectForKey:@"avatar_hd"] forKey:@"head_photo"];
    [request setPostValue:[dic objectForKey:@"name"] forKey:@"username"];
    [request setPostValue:[dic objectForKey:@"id"] forKey:@"sina_keyid"];
    //    [request setPostValue:@"" forKey:@"sina_keyid"];
    [request startAsynchronous];
    }
    else if (request.tag == 1)
    {
            
            NSLog(@"%@",request.responseString);
            //    if (request.tag==1||request.tag==2) {
            
            
            NSLog(@"1111111====%@",request.responseString);
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:request.responseString];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;//调用appdel
            appDele.type=[dic objectForKey:@"type"];
            appDele.touxiangImage=[dic objectForKey:@"head_photo"];
            appDele.uid=[dic objectForKey:@"uid"];//将值赋再appdelegat.uid上
            //        appDele.city=[dic objectForKey:@"city"];
            //        if (request.tag==1) {
            //            appDel.loginType=@"qq";
            //        }
            //        else{
            //        appDel.loginType=@"sina";
            //        }
            //
            //NSuserDefaults
            NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
            [ud setObject:[dic objectForKey:@"uid"] forKey:@"uid"];
            [ud setObject:[dic objectForKey:@"type"] forKey:@"type"];
            
            
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=coordinates"]]];
            request.delegate=self;
            request.tag=2;
            
            [request setPostValue:appDele.uid forKey:@"uid"];
            //         NSLog(@"%f",appDele.longitude);
            //        NSLog(@"%f",appDele.latitude);
            [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ] forKey:@"lng"];
            [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
            
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
    

    
    if (request.tag==101)
    {
        
            NSLog(@"request.responseString===%@",request.responseString);
        
    }
    
    if (request.tag==1000)
    {
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:request.responseString];
        NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"status"] isEqualToString:@"1"])
        {
            // 创建一个本地推送
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            //设置10秒之后
            NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:5];
            if (notification != nil) {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitDay;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"你有一条新的评论信息";
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
                
            }
            else if([[dic objectForKey:@"status"] isEqualToString:@"2"])
            {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitDay;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"你有一个新的粉丝";
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
            else if([[dic objectForKey:@"status"] isEqualToString:@"3"])
            {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitDay;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"你有一条新的预约通知";
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
            else if([[dic objectForKey:@"status"] isEqualToString:@"4"])
            {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitDay;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"你有一条新的聊天信息";
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
            else if([[dic objectForKey:@"status"] isEqualToString:@"5"])
            {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitDay;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"你有一条新的问题回答";
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
            else if([[dic objectForKey:@"status"] isEqualToString:@"6"])
            {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone defaultTimeZone];
                // 设置重复间隔
                notification.repeatInterval = kCFCalendarUnitDay;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"你有一条新的问题提问";
                //显示在icon上的红色圈中的数子
                notification.applicationIconBadgeNumber = 1;
                //设置userinfo 方便在之后需要撤销的时候使用
                NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
                notification.userInfo = info;
                //添加推送到UIApplication
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
        }
    }
    
    

}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    
//    [[UIApplication sharedApplication]setKeepAliveTimeout:600//定时唤醒
//                                                  handler:^{
//                                                      
//                                                      ASIFormDataRequest* request;
//                                                      request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Message&a=push_andrews"]]];
//                                                      if (self.uid) {
//                                                          [request setPostValue:self.uid forKey:@"uid"];
//                                                          
//                                                          request.delegate=self;
//                                                          request.tag=1000;
//                                                          [request startAsynchronous];
//                                                      }
//                                                     
//                                                      
//                                                                                                           //执行的代码
//                                                  }];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    if (status==kReachableViaWiFi||status==kReachableViaWWAN) {
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接信息" message:@"网络连接正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
        self.isReachable = YES;
    }

   else if(status == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        self.isReachable = NO;
        return;
    }
   }

/*
 UIActivityIndicatorView * _activityIndicatorView ;
 _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
 //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
 _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
 //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
 _activityIndicatorView.color = [UIColor grayColor];
 //设置活动指示器的颜色
 _activityIndicatorView.hidesWhenStopped = NO;
 //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
 [self.view addSubview:_activityIndicatorView];
 //将对象加入到view
 
 [_activityIndicatorView startAnimating];
 
 
 [_activityIndicatorView stopAnimating];
 _activityIndicatorView.hidesWhenStopped = YES;
 */

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"注册推送成功%@",deviceToken);
    
    
//    self.viewController.toKenValueTextView.text = [NSString stringWithFormat:@"%@",deviceToken];
//    self.viewController.pushStatusLabel.text = @"已经注册.";
    NSString* token = [NSString stringWithFormat:@"%@",deviceToken];
    NSLog(@"apns -> 生成的devToken:%@", token);
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=sitetoken"]];
    [request addPostValue:token forKey:@"token"];
    request.tag=101;
    request.delegate=self;
    [request startAsynchronous];
}


//远程通知注册失败委托
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
//    self.viewController.toKenValueTextView.text = [error description];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"远程通知");
//    [self PMD_uesPushMessage:userInfo];
}
//-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
    //这里处理应用程序如果没有启动,但是是通过通知消息打开的,此时可以获取到消息.
//    if (launchOptions != nil) {
//        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        [self PMD_uesPushMessage:userInfo];
//    }
//    return YES;
//}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息通知" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
}
@end
