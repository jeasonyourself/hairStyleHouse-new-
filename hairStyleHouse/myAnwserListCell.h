//
//  myAnwserListCell.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myAnwserListViewController;
@interface myAnwserListCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel *contentLable;
    UILabel *timeLable;
    UIButton * cellButton;
    myAnwserListViewController * fatherView;
}
@property(nonatomic,strong) myAnwserListViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end

