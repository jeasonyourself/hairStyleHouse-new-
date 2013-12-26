//
//  saleBeaspeaskViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dresserInforViewController.h"
#import "saleBeaspeakCell.h"
#import "LoginView.h"
#import "loginViewController.h"
@class AllAroundPullView;
@interface saleBeaspeaskViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIImageView * topImage;
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;//标记登陆成功后调用哪个借口
    dresserInforViewController * dreserView;
    
    loginViewController* loginView;
    
}
@property(nonatomic,strong)NSString * _hidden;
@end
