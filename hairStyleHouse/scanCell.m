//
//  scanCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "scanCell.h"
#import "scanImageViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AppDelegate.h"
@implementation scanCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstBack = [[UIView alloc ] init];
        
        secondBack = [[UIView alloc ] init];
        
        firstImage = [[UIImageView alloc ] init];
        
        secondImage = [[UIImageView alloc ] init];
        
        
        introduceView = [[UIView alloc] init];
        introduceView.backgroundColor = [UIColor clearColor];
        introduceView.alpha = 0.5;
        introduceView2 = [[UIView alloc] init];
        introduceView2.backgroundColor = [UIColor clearColor];
        introduceView2.alpha = 0.5;
        firstDleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstDleButton setBackgroundImage:[UIImage imageNamed:@"删除.png"] forState:UIControlStateNormal];
        
        firstShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstShareButton setBackgroundImage:[UIImage imageNamed:@"分享share.png"] forState:UIControlStateNormal];
        
        secondDleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondDleButton setBackgroundImage:[UIImage imageNamed:@"删除.png"] forState:UIControlStateNormal];
        secondShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondShareButton setBackgroundImage:[UIImage imageNamed:@"分享share.png"] forState:UIControlStateNormal];

        [self addSubview:firstBack];
        [self addSubview:secondBack];
        [firstBack addSubview:firstImage];
        [firstBack addSubview:introduceView];
        [introduceView addSubview: firstDleButton];
        [introduceView addSubview:firstShareButton];
        
        
        [secondBack addSubview:secondImage];
        [secondBack addSubview:introduceView2];
        [introduceView2 addSubview: secondDleButton];
        [introduceView2 addSubview:secondShareButton];
//        thirdImage = [[UIImageView alloc ] init];
        
        
//        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [firstButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//         [secondButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//         [thirdButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        [self addSubview:firstImage];
//        [self addSubview:firstButton];
//        [self addSubview:secondImage];
//        [self addSubview:secondButton];
//        [self addSubview:thirdImage];
//        [self addSubview:thirdButton];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    if (index%2==0)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
//        NSLog(@"headStr11111:%@",headStr);
        
        // 下载图片firstBack.frame =CGRectMake(5, 5, 152, 230);
       
        firstBack.frame =CGRectMake(5, 5, 152, 230);

        firstBack.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:242.0/256.0 blue:241.0/256.0 alpha:1.0];
        [firstImage setImageURLStr:headStr placeholder:placeholder];
        
        
//        firstImage.image=[dic objectForKey:@"image"];
        // 事件监听
        firstImage.tag = index;
        firstImage.userInteractionEnabled = YES;
        [firstImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        firstImage.clipsToBounds = YES;
        firstImage.contentMode = UIViewContentModeScaleAspectFill;
 
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        if (![appDele.uid isEqualToString:fatherView.uid]) {
            firstImage.frame =CGRectMake(5, 5, 142, 220);
        }
        else
        {
        firstImage.frame =CGRectMake(5, 5, 142, 185);
        }
        introduceView.frame = CGRectMake(0, firstImage.frame.size.height+firstImage.frame.origin.y, 142,firstBack.frame.size.height-firstImage.frame.size.height-firstImage.frame.origin.y);
//        secondImage.frame =CGRectMake(0, 0, 0, 0);
        
        firstDleButton.frame=CGRectMake(5, 5, 30, 30);
        firstDleButton.tag=index;
        [firstDleButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        firstShareButton.frame=CGRectMake(115, 5, 30, 30);
        firstShareButton.tag=index;
        [firstShareButton addTarget:self action:@selector(ShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (![appDele.uid isEqualToString:fatherView.uid]) {
            [introduceView removeFromSuperview];
        }
        else
        {
        }
        secondBack.frame =CGRectMake(0, 0, 0, 0);
        secondImage.frame =CGRectMake(0, 0, 0, 0);
        introduceView2.frame=CGRectMake(0, 0, 0, 0);
        secondDleButton.frame=CGRectMake(0, 0, 0, 0);
        secondShareButton.frame=CGRectMake(0, 0, 0, 0);
//        thirdImage.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%2==1)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
//        NSLog(@"headStr22222:%@",headStr);
        secondBack.frame =CGRectMake(163, 5, 152, 230);
        secondBack.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:242.0/256.0 blue:241.0/256.0 alpha:1.0];
        

//        // 下载图片
        [secondImage setImageURLStr:headStr placeholder:placeholder];
//        secondImage.image=[dic objectForKey:@"image"];
        // 事件监听
        secondImage.tag = index;
        secondImage.userInteractionEnabled = YES;
        [secondImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        secondImage.clipsToBounds = YES;
        secondImage.contentMode = UIViewContentModeScaleAspectFill;
        
         AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        if (![appDele.uid isEqualToString:fatherView.uid]) {
            secondImage.frame =CGRectMake(5, 5, 142, 220);
        }
        else
        {
            secondImage.frame =CGRectMake(5, 5, 142, 185);
        }
      
        introduceView2.frame = CGRectMake(0,secondImage.frame.size.height+secondImage.frame.origin.y, 142,secondBack.frame.size.height-secondImage.frame.size.height-secondImage.frame.origin.y);
        secondDleButton.frame=CGRectMake(5, 5, 30, 30);
        secondDleButton.tag=index;
        [secondDleButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        secondShareButton.frame=CGRectMake(115, 5, 30, 30);
        secondShareButton.tag=index;
        [secondShareButton addTarget:self action:@selector(ShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (![appDele.uid isEqualToString:fatherView.uid]) {
            [introduceView2 removeFromSuperview];
        }
        else
        {
        }
//        thirdImage.frame =CGRectMake(0, 0, 0, 0);
    }
//    else if (index%3==2)
//    {
//        NSString * headStr= [dic objectForKey:@"work_image"];
//        NSLog(@"headStr33333:%@",headStr);
//        
//        [thirdImage setImageURLStr:headStr placeholder:placeholder];
//        
//        thirdImage.image=[dic objectForKey:@"image"];
//        // 事件监听
//        thirdImage.tag = index;
//        thirdImage.userInteractionEnabled = YES;
//        [thirdImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
//        
//        // 内容模式
//        thirdImage.clipsToBounds = YES;
//        thirdImage.contentMode = UIViewContentModeScaleAspectFill;
//        thirdImage.frame =CGRectMake(6+(self.frame.size.width/3-2)*2, 2, self.frame.size.width/3-2, 163);
//    }
    
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [fatherView selectImage:tap.view.tag];
}

-(void)deleteButtonClick:(UIButton*)_btn
{
    [fatherView deleteImage:_btn.tag];
}
-(void)ShareButtonClick:(UIButton *)_btn
{
    [fatherView shareImage:_btn.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
