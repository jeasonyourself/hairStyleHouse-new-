//
//  squareViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myShowViewController.h"
#import "loginViewController.h"
#import "saleBeaspeaskViewController.h"
#import "sameCityViewController.h"
#import "hotTalkViewController.h"
#import "wayInforViewController.h"
#import "anwserCenterViewController.h"
#import "inviteViewController.h"
@interface squareViewController : UIViewController
{
    myShowViewController * myShow;
    loginViewController* loginView;
    saleBeaspeaskViewController * saleView;
    sameCityViewController * sameCityView;
    hotTalkViewController * hotView;
    
    wayInforViewController * wayView;
    anwserCenterViewController * anwserCenter;
    inviteViewController * inviteView;
}
@end
