//
//  setBeaspeakCell.h
//  hairStyleHouse
//
//  Created by jeason on 14-4-10.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class setBeaspeakViewController;
@interface setBeaspeakCell : UITableViewCell
{
    UILabel * firstLable;
    UILabel * secondLable;
    UILabel * thirdLable;
    UILabel *forthLable;
    
    
    UITextField * firstField;
    UITextField * secondField;
    UITextField * thirdField;
    UITextField * forthField;
    UIButton * deleButton;
    UIButton * deleteButton;
    UIButton * cellButton;
    UIButton * sendButton;
    UILabel * signLable;
    
}
@property (nonatomic,strong)setBeaspeakViewController* fatherViewController;
-(void)setFirstCell;
-(void)setOtherCell:(NSMutableArray *)arr andIndex:(NSInteger)index;
-(void)setLastCell;
-(void)setLastCell1;
@end
