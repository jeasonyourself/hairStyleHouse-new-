//
//  dresserInforViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dresserDetailViewController.h"

@interface dresserInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * rightButton;
    
    UITableView *myTableView;
    NSDictionary * inforDic;
    
    NSString * uid;
    dresserDetailViewController * backView;

}
-(void)refreashNav:(NSString *)str;
@property(strong,nonatomic)    NSString * uid;
@property(nonatomic,retain) NSString * _hidden;
-(void)pushToViewController:(id)_sen;
-(void)needAppdelegatePushToViewController:(id)_sen;
@end
