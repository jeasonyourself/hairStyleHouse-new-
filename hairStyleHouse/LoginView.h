//
//  LoginView.h
//  发型屋
//
//  Created by apple on 13-7-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TencentOpenAPI/TencentOAuth.h"
//#import "SinaWeibo.h"
#import "ASIHTTPRequest.h"

@interface LoginView : UIView<TencentLoginDelegate,TencentSessionDelegate,/*SinaWeiboDelegate,*/ASIHTTPRequestDelegate/*SinaWeiboRequestDelegate*/>
{
    UIView* myInfoView;
    TencentOAuth* _tencentOAuth;
//    SinaWeibo* _sinaweibo;
    NSArray* _permissions;
    NSString* imageUrl;
    NSString* type;
    NSString* access_token;
    NSString* userName;
    NSString* expirationDate;
    NSString* openId;
    
    NSString* sType;
    NSString* sImageUrl;
    NSString* sAccess_token;
    NSString* sUserName;
    NSString* sExpirationDate;
    NSString* sOpenId;
    NSString* backId;
    
    UIImageView* jiaZiaView;
    NSString* touxiangUrl;
    NSString* nameLabelStr;
    
    UIButton * QQButton;
    UIButton * sinaButton;
    
    id interface;
    SEL sucfun;
    SEL errfun;
}
-(void)getBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err;
@property(nonatomic,retain) TencentOAuth* tentenOAuth;
@end
