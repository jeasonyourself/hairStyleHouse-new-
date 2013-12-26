//
//  dresserCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dresserViewController;

@interface dresserCell : UITableViewCell
{
    
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * cityLable;
    UILabel *timeLable;
     UILabel *addressLable;
    
    UIButton * cellButton;
    UIButton * fouceButton;
    dresserViewController * fatherController;
}
@property(nonatomic,strong) dresserViewController * fatherController;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;

@end
