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
#import "mineViewController.h"
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "SinaWeibo.h"
#define kAppKey             @"276585644"
#define kAppSecret          @"a71b4382aeda47dfbdd5925b4b407648"
#define kAppRedirectURI     @"http://www.faxingw.cn"
//#import "loginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate,TencentLoginDelegate,TencentSessionDelegate,WeiboSDKDelegate,SinaWeiboDelegate>

{
    UINavigationController * rootNav;
    UITabBarController * rootTab;
    UIImageView * tabImageView;
    
    findStyleViewController * findStyleController;
    UINavigationController * firstNav;
    
    dresserViewController * dresserController;
    UINavigationController * secondNav;
    
    squareViewController * squareController;
    UINavigationController * thirdNav;
    
    mineViewController * mineController;
    UINavigationController * forthNav;
    
//    NSString * signStr;
//    loginViewController* loginView;
    NSString* wbtoken;
    
    id interface;
    SEL sucfun;
    SEL errfun;

}
@property (strong, retain) NSString* wbtoken;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) SinaWeibo* sinaweibo;
@property (strong,nonatomic) NSString* uid;//用到
@property (strong,nonatomic) TencentOAuth* tententOAuth;//用到
@property (nonatomic,assign) NSString* loginType;//用到
@property (nonatomic,assign) NSString* xuanzheLoginType;
@property (strong,nonatomic) NSString* type;// 用到
@property (nonatomic,assign) double  longitude;
@property (nonatomic,assign) double latitude;
@property (nonatomic,strong) NSString* touxiangImage;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* userName;//用到
-(void)pushToViewController:(id)_sen;
    -(void)getSinaLoginBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err;
@end
