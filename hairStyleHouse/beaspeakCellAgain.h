//
//  beaspeakCellAgain.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-17.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface beaspeakCellAgain : UITableViewCell
{
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

