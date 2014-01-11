//
//  addBeaspeakHairStyleViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-11.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addbeaspeakHairStyleCell.h"
@interface addBeaspeakHairStyleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    
    UITableView *myTableView;
    
    NSDictionary * workInforDic;
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
}
@property (nonatomic,strong)NSDictionary * inforDic;
@end
