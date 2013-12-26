//
//  lookEvaluateViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lookEvaluateCell.h"
@interface lookEvaluateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString * uid;
    
    UITableView *myTableView;
    NSMutableArray * dresserArray;

}
@property(strong,nonatomic)    NSString * uid;

@end
