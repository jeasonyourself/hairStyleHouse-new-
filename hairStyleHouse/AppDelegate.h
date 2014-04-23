//
//  AppDelegate.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "findStyleViewController.h"
#import "dresserViewController.h"
#import "squareViewController.h"
#import "anwserCenterViewController.h"

#import "mineViewController.h"
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "SinaWeibo.h"
#import "Reachability.h"
#import "loginViewController.h"
#import "UMSocialQQHandler.h"

#define kAppKey             @"276585644"
#define kAppSecret          @"a71b4382aeda47dfbdd5925b4b407648"
#define kAppRedirectURI     @"http://www.faxingw.cn"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate,TencentLoginDelegate,TencentSessionDelegate,WeiboSDKDelegate,SinaWeiboDelegate>

{
    UINavigationController * rootNav;
    UITabBarController * rootTab;
    UIImageView * tabImageView;
    
    findStyleViewController * findStyleController;
    UINavigationController * firstNav;
    
    dresserViewController * dresserController;
    UINavigationController * secondNav;
    
    squareViewController * squareController;//老版本
    
    anwserCenterViewController * anwserCenter;//新版本
    
    UINavigationController * thirdNav;
    
    
    
    loginViewController * loginView;
    mineViewController * mineController;
    UINavigationController * forthNav;
    
    UILabel * firstLable;
    UILabel * secondLable;
    UILabel * thirdLable;
    UILabel * forthLable;
//    NSString * signStr;
//    loginViewController* loginView;
    NSString* wbtoken;
    
  Reachability*  hostReach;
    
//    id interface;
//    SEL sucfun;
//    SEL errfun;

    NSMutableDictionary * userInfor;

}
@property (assign, nonatomic) BOOL isSingin;
@property (strong, nonatomic) NSString* wbtoken;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) SinaWeibo* sinaweibo;
@property (strong,nonatomic) NSString* uid;//用到
@property (strong,nonatomic) NSString* secret;//用到
@property (strong,nonatomic) NSString* ifSinceLogOut;//用到
@property (strong,nonatomic) TencentOAuth* tententOAuth;//用到
@property (nonatomic,assign) NSString* loginType;//用到
@property (nonatomic,assign) NSString* xuanzheLoginType;
@property (strong,nonatomic) NSString* type;// 用到
@property (nonatomic,assign) double  longitude;
@property (nonatomic,assign) double latitude;
@property (nonatomic,strong) NSString* touxiangImage;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* userName;//用到
@property (nonatomic) BOOL isReachable;
@property (strong, nonatomic) Reachability*  hostReach;
-(void)pushToViewController:(id)_sen;
//    -(void)getSinaLoginBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err;
@end
