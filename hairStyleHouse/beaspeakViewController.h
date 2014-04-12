//
//  beaspeakViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "beaspeakCell.h"
#import "beaspeakDresserViewController.h"
#import "beaspeakCellAgain.h"
#import "dresserInforViewController.h"
@class AllAroundPullView;

@interface beaspeakViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIImageView * topImage;
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    NSMutableDictionary * inforDic;
    BOOL nowOrhistory;//yes是当前预约，no是历史预约
    
    beaspeakDresserViewController * deaspeakDresser;
    UIButton * oneButton;
    UIButton * twoButton;
    
    beaspeakCellAgain *beaspeakView;
    
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    AllAroundPullView *bottomRefreshView;
    
    dresserInforViewController * dreserView;

}
@property(strong,nonatomic)NSString * dresserOrCommen;
-(void)pushDresserView:(NSString*)str;
@end
