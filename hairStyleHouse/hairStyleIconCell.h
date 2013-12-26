//
//  hairStyleIconCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-24.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class findStyleViewController;
@interface hairStyleIconCell : UITableViewCell
{
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIImageView * thirdImage;
    
    UILabel * firstLable;
    UILabel * secondLable;
    UILabel * thirdLable;

    
    findStyleViewController * fatherView;
}
@property(nonatomic,strong) findStyleViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end


