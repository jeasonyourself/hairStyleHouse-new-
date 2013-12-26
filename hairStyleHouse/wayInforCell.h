//
//  wayInforCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class wayInforViewController;

@interface wayInforCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * contentLable;
    UILabel *timeLable;
    UIButton * cellButton;
    wayInforViewController * fatherView;
}
@property(nonatomic,strong) wayInforViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end

