//
//  hotTalkViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotTalkCell.h"
#import "MJPhotoBrowser.h"
#import "loginViewController.h"
#import "pubQViewController.h"
#import "questionDetailViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"

@class AllAroundPullView;
@interface hotTalkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UIButton * oneButton;
    UIButton * twoButton;
    UIButton * thirdButton;
//    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    
    NSMutableArray * dresserArray;
    NSMutableArray * dresserArray1;
    NSMutableArray * dresserArray2;

    NSString * page;
    NSString * pageCount;
    NSString * page1;
    NSString * pageCount1;
    NSString * page2;
    NSString * pageCount2;
    NSString * sign;
    
    NSString* style;
    
    MJPhotoBrowser *browser;
    
    loginViewController* loginView;
    pubQViewController * pubQ;
    
    questionDetailViewController * questionDetailView;
}
@property(nonatomic,strong) YFJLeftSwipeDeleteTableView  *myTableView;
@property(nonatomic,strong)        NSString* style;
@property(nonatomic,strong)NSString * _hidden;
-(void)selectCell:(NSInteger)_index;


@end
