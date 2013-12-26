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
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIImageView * thirdImage;

    findStyleDetailViewController * fatherView;
}
@property(nonatomic,strong) findStyleDetailViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
