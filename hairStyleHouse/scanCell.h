//
//  scanCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class scanImageViewController;
@interface scanCell : UITableViewCell
{
    UIImageView * firstImage;
    UIButton * firstButton;
    UIImageView * secondImage;
    UIButton * secondButton;
    UIImageView * thirdImage;
    UIButton * thirdButton;
    
    scanImageViewController * fatherView;
}
@property(strong,nonatomic)    scanImageViewController * fatherView;

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;

@end
