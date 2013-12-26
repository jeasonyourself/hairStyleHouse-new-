//
//  commentViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-2.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentCell.h"
@interface commentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    
    UITableView *myTableView;
    
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
}
@property (nonatomic,strong)NSDictionary * inforDic;
@end
