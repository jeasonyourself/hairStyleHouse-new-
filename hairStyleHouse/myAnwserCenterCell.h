//
//  myAnwserCenterCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myAnwserCenterViewController;
@interface myAnwserCenterCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel *timeLable;
    UIButton * cellButton;
    myAnwserCenterViewController * fatherView;
}
@property(nonatomic,strong) myAnwserCenterViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
