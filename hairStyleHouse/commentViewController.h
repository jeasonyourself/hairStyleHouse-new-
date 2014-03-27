//
//  commentViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-2.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentCell.h"
#import "AllAroundPullView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
@class dresserInforViewController;
@class userInforViewController;
@interface commentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,EGORefreshTableFooterDelegate>
{
    NSDictionary * inforDic;
    
    NSString * page;
    NSString * pageCount;
    UITableView *myTableView;
    AllAroundPullView  *  bottomRefreshView;
    
//    EGORefreshTableHeaderView *_refreshTableView;
//    BOOL _reloading;
//    
//    EGORefreshTableFooterView *refreshView;
//    BOOL reloading;
    
    
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
    dresserInforViewController *dreserView;
    userInforViewController * userView;
}
@property (nonatomic,strong)NSDictionary * inforDic;
-(void)headButtonClick;
-(void)headButtonClick1:(NSInteger)_index;
-(void)smallButtonClick1:(NSInteger)_index;

//开始重新加载时调用的方法
- (void)reloadTableViewDataSource;
//完成加载时调用的方法
- (void)doneLoadingTableViewData;

@end
