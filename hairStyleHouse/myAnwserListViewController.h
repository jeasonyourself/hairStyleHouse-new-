//
//  myAnwserListViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "questionDetailViewController.h"
@class AllAroundPullView;
#import "myAnwserListCell.h"
#import "talkViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"
//我的问题，还有一个跳转，跳转到多个回答的列表，即myAnwserlistViewController，而发型师的回答列表直接跳转聊天界面
@interface myAnwserListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
//    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    questionDetailViewController * questionDetailView;
    talkViewController * talkView;
    
}
@property(nonatomic,strong) YFJLeftSwipeDeleteTableView  *myTableView;
@property(nonatomic,strong)NSString * questionId;
@property(nonatomic,strong)NSString * _hidden;
-(void)selectCell:(NSInteger)_index;
@end

