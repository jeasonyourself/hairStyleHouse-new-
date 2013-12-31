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
@interface anwserCenterViewController : UIViewController
{
    UIButton * questionButton;
    UIButton * anwserButton;
    pubQViewController * pubQ;
    myAnwserCenterViewController * myAnwserView;
    loginViewController* loginView;

}
@property(nonatomic,strong)NSString * _hidden;
@end
