//
//  questionDetailViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "questionDetailCell.h"
@class AllAroundPullView;
@interface questionDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    NSString * page;
    NSString * pageCount;
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;

    
    NSDictionary* dic;
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
}
@property (nonatomic,strong)NSDictionary * inforDic;

@end
