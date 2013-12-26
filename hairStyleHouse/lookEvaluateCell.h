//
//  lookEvaluateCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lookEvaluateCell : UITableViewCell

{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * timeLable;
    
    UILabel * serviceLable;
    UIImageView * serviceImage ;
    
    UILabel * priceLable;
    UIImageView * priceImage ;

    UILabel * milieuLable;
    UIImageView * milieuImage ;

    UILabel * contentLable;
    UILabel * reaLable;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;

@end
