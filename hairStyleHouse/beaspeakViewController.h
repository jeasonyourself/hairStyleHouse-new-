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
@interface beaspeakViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIImageView * topImage;
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    BOOL nowOrhistory;//yes是当前预约，no是历史预约
    
    beaspeakDresserViewController * deaspeakDresser;
}

@end
