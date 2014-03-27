//
//  wayInforViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllAroundPullView;
#import "wayInforCell.h"
#import "wayDetailViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"

@interface wayInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UIButton* oneButton;
    UIButton* twoButton;
    UIButton * thirdButton;
    BOOL needFeash;
    AllAroundPullView *bottomRefreshView;
    
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
    
    NSString* style;
    
    wayDetailViewController * wayDeatil;

}
@property(nonatomic,strong) YFJLeftSwipeDeleteTableView  *myTableView;
@property(nonatomic,strong)NSString* style;
@property(nonatomic,strong)NSString * _hidden;
-(void)selectCell:(NSInteger)_index;




@end
