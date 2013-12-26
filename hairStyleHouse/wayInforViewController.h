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
@interface wayInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    
    NSString* style;
    
    wayDetailViewController * wayDeatil;

}
@property(nonatomic,strong)        NSString* style;
@property(nonatomic,strong)NSString * _hidden;
-(void)selectCell:(NSInteger)_index;




@end
