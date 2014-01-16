//
//  beaspeakCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface beaspeakCell : UITableViewCell
{
    UIView * firstView;
    UIView * secondView;
    
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * mobileLable;
    UILabel * typeLable;
    UILabel *timeLable;
    UILabel * statusLable;
    
    
    UILabel * nameLable1;
    UILabel * mobileLable1;
    UILabel * typeLable1;
    UILabel *timeLable1;
    UILabel * priceLable;
    
    UIImageView * picImage;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;//
-(void)setCell1:(NSDictionary *)dic andIndex:(NSInteger)index;//当前预约
@end
