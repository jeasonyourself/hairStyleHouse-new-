//
//  mineViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "singleTableCellBackgroundViewController.h"
#import "renewSingleTableCellBackgroundViewController.h"
#import "LoginView.h"
#import "loginViewController.h"
#import "pubImageViewController.h"
@interface mineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    loginViewController * loginView;
    
    UITableView *myTableView;
    NSDictionary * inforDic;
    NSMutableDictionary * userInfor;
    NSMutableArray * userInforArr;
    NSMutableArray * userInforArr1;
    singleTableCellBackgroundViewController * backView;
    renewSingleTableCellBackgroundViewController * backView1;
    pubImageViewController * pubImage;
    BOOL needFreashLogin;
}
@property(nonatomic,strong)NSString * freash;
-(void)pushToViewController:(id)_sen;
-(void)needAppdelegatePushToViewController:(id)_sen;

@end
