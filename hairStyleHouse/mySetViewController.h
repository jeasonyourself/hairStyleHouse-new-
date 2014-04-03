//
//  mySetViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-30.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mySetSingleCellViewController.h"
#import "dresserMySetSingleCellViewController.h"
@interface mySetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    
        UITableView * myTableView;
    mySetSingleCellViewController * backView;
    dresserMySetSingleCellViewController * backView1;
}
@property(nonatomic,retain) NSString * _hidden;
-(void)pushToViewController:(id)_sen;
-(void)leftButtonClick;
-(void)pushToRoot;
@end

