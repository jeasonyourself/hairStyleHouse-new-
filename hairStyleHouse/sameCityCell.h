//
//  sameCityCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class sameCityViewController;
@interface sameCityCell : UITableViewCell
{
    
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * cityLable;
    UILabel *timeLable;
    UILabel *addressLable;
    
    UIButton * cellButton;
    UIButton * fouceButton;
    sameCityViewController * fatherController;
}
@property(nonatomic,strong) sameCityViewController * fatherController;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;

@end
