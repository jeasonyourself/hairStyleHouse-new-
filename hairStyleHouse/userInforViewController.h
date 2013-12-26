//
//  userInforViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-6.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userDetailViewController.h"
@interface userInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * rightButton;
    
    UITableView *myTableView;
    NSDictionary * inforDic;
    
    NSString * uid;
    userDetailViewController * backView;
    
}
@property(strong,nonatomic)    NSString * uid;
@property(nonatomic,retain) NSString * _hidden;
-(void)refreashNav:(NSString *)str;
-(void)pushToViewController:(id)_sen;
-(void)needAppdelegatePushToViewController:(id)_sen;

@end
