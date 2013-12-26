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
@class AllAroundPullView;
@interface hotTalkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    
    NSString* style;
    
    MJPhotoBrowser *browser;
    
    loginViewController* loginView;
    pubQViewController * pubQ;
    
    questionDetailViewController * questionDetailView;
}
@property(nonatomic,strong)        NSString* style;
@property(nonatomic,strong)NSString * _hidden;
-(void)selectCell:(NSInteger)_index;


@end
