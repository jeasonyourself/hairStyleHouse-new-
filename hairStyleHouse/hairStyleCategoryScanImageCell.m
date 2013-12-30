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
        
        firstImage = [[UIImageView alloc ] init];
        
        secondImage = [[UIImageView alloc ] init];
        
        thirdImage = [[UIImageView alloc ] init];
        
        [self addSubview:firstImage];
        [self addSubview:secondImage];
        [self addSubview:thirdImage];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    if (index%3==0)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        NSLog(@"headStr11111:%@",headStr);
        
        // 下载图片
        [firstImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        firstImage.tag = index;
        firstImage.userInteractionEnabled = YES;
        [firstImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        firstImage.clipsToBounds = YES;
        firstImage.contentMode = UIViewContentModeScaleAspectFill;
        firstImage.frame =CGRectMake(2, 2, self.frame.size.width/3-2, 148);
        secondImage.frame =CGRectMake(0, 0, 0, 0);
        thirdImage.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%3==1)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        NSLog(@"headStr22222:%@",headStr);
        // 下载图片
        [secondImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        secondImage.tag = index;
        secondImage.userInteractionEnabled = YES;
        [secondImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        secondImage.clipsToBounds = YES;
        secondImage.contentMode = UIViewContentModeScaleAspectFill;
        secondImage.frame =CGRectMake(4+self.frame.size.width/3-2, 2, self.frame.size.width/3-2, 148);
        thirdImage.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%3==2)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        NSLog(@"headStr33333:%@",headStr);
        
        [thirdImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        thirdImage.tag = index;
        thirdImage.userInteractionEnabled = YES;
        [thirdImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        thirdImage.clipsToBounds = YES;
        thirdImage.contentMode = UIViewContentModeScaleAspectFill;
        thirdImage.frame =CGRectMake(6+(self.frame.size.width/3-2)*2, 2, self.frame.size.width/3-2, 148);
    }
    
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
