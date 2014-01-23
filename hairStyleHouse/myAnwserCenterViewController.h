//
//  myAnwserCenterViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "questionDetailViewController.h"
@class AllAroundPullView;
#import "myAnwserCenterCell.h"
#import "myAnwserListViewController.h"
#import "talkViewController.h"
//我的问题，还有一个跳转，跳转到多个回答的列表，即myAnwserlistViewController，而发型师的回答列表直接跳转聊天界面
@interface myAnwserCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    questionDetailViewController * questionDetailView;
    
    myAnwserListViewController * myAnwserList;
    talkViewController * talkView;

}
@property(nonatomic,strong)NSString * _hidden;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * whoLookQuestion;
-(void)selectCell:(NSInteger)_index;
@end
