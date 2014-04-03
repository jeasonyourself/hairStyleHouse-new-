//
//  hairStyleCategoryScanImageCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-5.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "hairStyleCategoryScanImageCell.h"
#import "UIImageView+WebCache.h"
#import "findStyleDetailViewController.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation hairStyleCategoryScanImageCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstBack = [[UIView alloc ] init];
        firstBack.layer.cornerRadius = 10;//设置那个圆角的有多圆
        firstBack.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        firstBack.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        firstBack.layer.masksToBounds = YES;//设为NO去试试
        secondBack = [[UIView alloc ] init];
        secondBack.layer.cornerRadius = 10;//设置那个圆角的有多圆
        secondBack.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        secondBack.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        secondBack.layer.masksToBounds = YES;//设为NO去试试
        
        firstImage = [[UIImageView alloc ] init];
        
        secondImage = [[UIImageView alloc ] init];
        
        thirdImage = [[UIImageView alloc ] init];
        
        introduceView = [[UIView alloc] init];
        introduceView.backgroundColor = [UIColor clearColor];
        introduceView2 = [[UIView alloc] init];
        introduceView2.backgroundColor = [UIColor clearColor];
        
        [self addSubview:firstBack];
        [firstBack addSubview: firstImage];
        [firstBack addSubview: introduceView];
        
        [self addSubview:secondBack];
        [secondBack addSubview:secondImage];
        [secondBack addSubview:introduceView2];
//        [self addSubview:thirdImage];
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
        NSLog(@"headStr11111:%@",headStr);
        
        firstBack.frame =CGRectMake(5, 5, 152, 230);
        secondBack.frame =CGRectMake(0, 0, 0, 0);

        firstBack.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:242.0/256.0 blue:241.0/256.0 alpha:1.0];
       
        // 下载图片
//        firstImage.image=[dic objectForKey:@"image"];
        [firstImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        firstImage.tag = index;
        firstImage.userInteractionEnabled = YES;
        [firstImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        firstImage.clipsToBounds = YES;
        firstImage.contentMode = UIViewContentModeScaleAspectFill;
//        firstImage.frame =CGRectMake(5, 5, 142, 165);
        firstImage.frame =CGRectMake(0, 0, 152, 230);
        
        introduceView.frame = CGRectMake(0, firstImage.frame.size.height+firstImage.frame.origin.y, 142,firstBack.frame.size.height-firstImage.frame.size.height-firstImage.frame.origin.y);        secondImage.frame =CGRectMake(0, 0, 0, 0);
//        thirdImage.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%2==1)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        NSLog(@"headStr22222:%@",headStr);
        
        secondBack.frame =CGRectMake(163, 5, 152, 230);
        secondBack.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:242.0/256.0 blue:241.0/256.0 alpha:1.0];
        
        // 下载图片
//        secondImage.image=[dic objectForKey:@"image"];

        [secondImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        secondImage.tag = index;
        secondImage.userInteractionEnabled = YES;
        [secondImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        secondImage.clipsToBounds = YES;
        secondImage.contentMode = UIViewContentModeScaleAspectFill;
//        secondImage.frame =CGRectMake(5, 5, 142, 165);
        secondImage.frame =CGRectMake(0, 0, 152, 230);
        introduceView2.frame = CGRectMake(0,secondImage.frame.size.height+secondImage.frame.origin.y, 142,secondBack.frame.size.height-secondImage.frame.size.height-secondImage.frame.origin.y);
        //        thirdImage.frame =CGRectMake(0, 0, 0, 0);
    }
//    else if (index%3==2)
//    {
//        NSString * headStr= [dic objectForKey:@"work_image"];
//        NSLog(@"headStr33333:%@",headStr);
//        thirdImage.image=[dic objectForKey:@"image"];
//
////        [thirdImage setImageURLStr:headStr placeholder:placeholder];
//        
//        // 事件监听
//        thirdImage.tag = index;
//        thirdImage.userInteractionEnabled = YES;
//        [thirdImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
//        
//        // 内容模式
//        thirdImage.clipsToBounds = YES;
//        thirdImage.contentMode = UIViewContentModeScaleAspectFill;
//        thirdImage.frame =CGRectMake(6+(self.frame.size.width/3-2)*2, 2, self.frame.size.width/3-2, 148);
//    }
    
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [fatherView selectImage:tap.view.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
