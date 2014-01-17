//
//  commentViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-2.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentCell.h"
@class dresserInforViewController;
@class userInforViewController;
@interface commentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    
    UITableView *myTableView;
    
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


@end
