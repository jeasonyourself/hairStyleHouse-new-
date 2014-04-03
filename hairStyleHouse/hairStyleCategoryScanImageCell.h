//
//  hairStyleCategoryScanImageCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-5.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class findStyleDetailViewController;
@interface hairStyleCategoryScanImageCell : UITableViewCell
{
    UIView * firstBack;
    UIView * secondBack;
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIView * introduceView;
    UIView * introduceView2;
    
    UIImageView * thirdImage;

    findStyleDetailViewController * fatherView;
}
@property(nonatomic,strong) findStyleDetailViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
