//
//  addBeaspeakViewCell.h
//  hairStyleHouse
//
//  Created by jeason on 14-4-15.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addBeaspeakViewCell : UITableViewCell
{
    UILabel * firstLable;
    UILabel * secondLable;
    UILabel * thirdLable;
    UILabel *forthLable;
}
-(void)setFirstCell;
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index;
@end
