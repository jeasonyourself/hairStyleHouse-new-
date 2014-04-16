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
#import "YFJLeftSwipeDeleteTableView.h"
#import "anwserCell.h"

@interface anwserCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * leftButton;
    UIImageView * signImage;
    
    UIImageView *topImage;
    UIButton * oneButton;
    UIButton * twoButton;
    UIButton * thirdButton;
    BOOL needFeash;
//    NSDictionary* dic;
    NSMutableArray * dresserArray;
   
    NSString * page;
    NSString * pageCount;
    NSMutableArray * dresserArray1;
    NSString * page1;
    NSString * pageCount1;
    NSMutableArray * dresserArray2;
    NSString * page2;
    NSString * pageCount2;
    NSString * sign;
    
    AllAroundPullView *bottomRefreshView;

    
    UIButton * questionButton;
    UIButton * anwserButton;
    pubQViewController * pubQ;
    myAnwserCenterViewController * myAnwserView;
    loginViewController* loginView;
    myAnwserListViewController * myAnwserList;
    talkViewController * talkView;
    
    
    UIActivityIndicatorView * _activityIndicatorView;
}
@property(nonatomic,strong) YFJLeftSwipeDeleteTableView  *myTableView;

@property(nonatomic,strong)NSString * _hidden;
-(void)anwserQ:(NSInteger)row;
@end
