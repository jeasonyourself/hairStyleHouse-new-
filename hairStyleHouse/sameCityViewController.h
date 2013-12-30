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
    UIImageView * topImage1;
    UIImageView * searchImage;

    UIButton * oneButton;
    UIButton * twoButton;
    UITableView *myTableView;
    UITextField * keyField;
    AllAroundPullView *bottomRefreshView;
    
    NSMutableArray * dresserArray;
    NSMutableArray * dresserArray1;
    NSMutableArray * dresserArray2;
    NSMutableArray * dresserArray3;
    NSString * page;
    NSString * page1;
    NSString * pageCount;
    NSString * pageCount1;
    NSString * sign;
    NSString * keyFieldSign;


    MJPhotoBrowser *browser;
    
    loginViewController* loginView;
    dresserInforViewController * dreserView;


}
@property(nonatomic,strong)        NSString*_hidden;
-(void)selectCell:(NSInteger)_index;
-(void)didFouce:(NSInteger)_index;



@end
