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
    UIView * firstBack;
    UIView * secondBack;
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIView * introduceView;
    UIView * introduceView2;
    
//    UIImageView * firstImage;
    UIButton * firstDleButton;
//    UIImageView * secondImage;
    UIButton * secondDleButton;
    UIButton * firstShareButton;
    UIButton * secondShareButton;
//    UIImageView * thirdImage;
    UIButton * thirdButton;
    
    scanImageViewController * fatherView;
}
@property(strong,nonatomic)    scanImageViewController * fatherView;

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index ;

@end
