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
@interface myAnwserCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    questionDetailViewController * questionDetailView;
}
-(void)selectCell:(NSInteger)_index;
@end
