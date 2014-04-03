//
//  anwserCell.h
//  hairStyleHouse
//
//  Created by jeason on 14-4-1.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class anwserCenterViewController;

@interface anwserCell : UITableViewCell
{
    anwserCenterViewController * fatherView;
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * contentLable;
    UILabel *timeLable;
    UILabel * distanceLable;
    UILabel * anwserNumLable;
    UIButton * anwserButton;
}
@property(nonatomic,strong) anwserCenterViewController * fatherView;
-(void)setCell2:(NSDictionary *)dic andIndex:(NSInteger)index;
-(void)setCell1:(NSDictionary *)dic andIndex:(NSInteger)index;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
