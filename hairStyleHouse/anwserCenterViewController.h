//
//  anwserCenterViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pubQViewController.h"
#import "myAnwserCenterViewController.h"
#import "loginViewController.h"
#import "myAnwserListViewController.h"
#import "talkViewController.h"
@interface anwserCenterViewController : UIViewController
{
    NSDictionary* dic;
    UIButton * questionButton;
    UIButton * anwserButton;
    pubQViewController * pubQ;
    myAnwserCenterViewController * myAnwserView;
    loginViewController* loginView;
    myAnwserListViewController * myAnwserList;
    talkViewController * talkView;

}
@property(nonatomic,strong)NSString * _hidden;
@end
