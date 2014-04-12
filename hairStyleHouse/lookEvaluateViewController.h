//
//  lookEvaluateViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lookEvaluateCell.h"
#import "AllAroundPullView.h"
@interface lookEvaluateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString * uid;
    
    UIImageView * topImage;
    UIButton* oneButton;
    UIButton* twoButton;
    UIButton * thirdButton;
    UIButton * forthButton;
    BOOL needFeash;
    UITableView *myTableView;
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
    
    NSMutableArray * dresserArray3;
    NSString * page3;
    NSString * pageCount3;
    NSString * sign;

}
@property(strong,nonatomic)    NSString * uid;
@property(strong,nonatomic)    NSString * _hidden;

@end
