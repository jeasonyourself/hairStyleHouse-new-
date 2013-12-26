//
//  sameCityViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hairStyleCategoryScanImageCell.h"
#import "MJPhotoBrowser.h"
#import "sameCityCell.h"
#import "loginViewController.h"
#import "dresserInforViewController.h"
@class AllAroundPullView;


@interface sameCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIImageView * topImage;
    UITableView *myTableView;
    UITextField * keyField;
    AllAroundPullView *bottomRefreshView;
    
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    MJPhotoBrowser *browser;
    
    loginViewController* loginView;
    dresserInforViewController * dreserView;


}
@property(nonatomic,strong)        NSString*_hidden;
-(void)selectCell:(NSInteger)_index;
-(void)didFouce:(NSInteger)_index;



@end
