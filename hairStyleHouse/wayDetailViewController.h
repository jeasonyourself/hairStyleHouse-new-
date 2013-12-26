//
//  wayDetailViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wayDetailCell.h"
@interface wayDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    
    UITableView *myTableView;
    
    NSDictionary* dic;
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
}
@property (nonatomic,strong)NSDictionary * inforDic;

@end
