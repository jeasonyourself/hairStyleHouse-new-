//
//  hairStyleCategory.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-24.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "hairStyleCategory.h"

@implementation hairStyleCategory
@synthesize firstArray;
@synthesize secondArray;
@synthesize thirdArray;
@synthesize forthArray;
@synthesize fifthArray;
@synthesize sixthArray;
static hairStyleCategory *hairStyleCategoryData = nil;
+(hairStyleCategory *)shareData {
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        hairStyleCategoryData = [[hairStyleCategory alloc] init];
    });
    
    return hairStyleCategoryData;
    
}

-(id)init {
    
    if (self = [super init])
    {
        //推荐
        UIImageView * oneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_9.png"]];
        UIImageView * twoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_7.png"]];
        UIImageView * threeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_4.png"]];
        UIImageView * fourImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_1.png"]];
        UIImageView * fiveImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_4.png"]];
        UIImageView * sixImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_5.png"]];
        UIImageView * sevenImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_9.png"]];
        UIImageView * eightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_10.png"]];
        UIImageView * nineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_5_2.png"]];

        
        NSString * oneStr = [[NSString alloc] initWithFormat:@"波波头"];
        NSString * twoStr = [[NSString alloc] initWithFormat:@"梨花头"];
        NSString * threeStr = [[NSString alloc] initWithFormat:@"水波纹"];
        NSString * fourStr = [[NSString alloc] initWithFormat:@"纹理烫"];
        NSString * fiveStr = [[NSString alloc] initWithFormat:@"编发"];
        NSString * sixStr = [[NSString alloc] initWithFormat:@"盘发"];
        NSString * sevenStr = [[NSString alloc] initWithFormat:@"男明星"];
        NSString * eightStr = [[NSString alloc] initWithFormat:@"女明星"];
        NSString * nineStr = [[NSString alloc] initWithFormat:@"渐变色"];
        
        
        
        NSDictionary * firstDic=[[NSDictionary alloc] initWithObjectsAndKeys:oneImage,@"imageArr",oneStr,@"nameArr", nil];
         NSDictionary * secondDic=[[NSDictionary alloc] initWithObjectsAndKeys:twoImage,@"imageArr",twoStr,@"nameArr", nil];
         NSDictionary * thirdDic=[[NSDictionary alloc] initWithObjectsAndKeys:threeImage,@"imageArr",threeStr,@"nameArr", nil];
         NSDictionary * forthDic=[[NSDictionary alloc] initWithObjectsAndKeys:fourImage,@"imageArr",fourStr,@"nameArr", nil];
         NSDictionary * fifthDic=[[NSDictionary alloc] initWithObjectsAndKeys:fiveImage,@"imageArr",fiveStr,@"nameArr", nil];
         NSDictionary * sixthDic=[[NSDictionary alloc] initWithObjectsAndKeys:sixImage,@"imageArr",sixStr,@"nameArr", nil];
         NSDictionary * seventhDic=[[NSDictionary alloc] initWithObjectsAndKeys:sevenImage,@"imageArr",sevenStr,@"nameArr", nil];
         NSDictionary * eighthDic=[[NSDictionary alloc] initWithObjectsAndKeys:eightImage,@"imageArr",eightStr,@"nameArr", nil];
         NSDictionary * ninthDic=[[NSDictionary alloc] initWithObjectsAndKeys:nineImage,@"imageArr",nineStr,@"nameArr", nil];
        
        self.firstArray= [[NSArray alloc] initWithObjects:firstDic,secondDic,thirdDic,forthDic,fifthDic, sixthDic,seventhDic,eighthDic,ninthDic, nil] ;
        
        //女生
        UIImageView * oneImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_1.png"]];
        UIImageView * twoImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_2.png"]];
        UIImageView * threeImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_3.png"]];
        UIImageView * fourImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_4.png"]];
        UIImageView * fiveImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_5.png"]];
        UIImageView * sixImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_6.png"]];
        UIImageView * sevenImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_7.png"]];
        UIImageView * eightImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_8.png"]];
        UIImageView * nineImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_1_9.png"]];
        
        
        
        NSString * oneStr1 = [[NSString alloc] initWithFormat:@"短发"];
        NSString * twoStr1 = [[NSString alloc] initWithFormat:@"中发"];
        NSString * threeStr1 = [[NSString alloc] initWithFormat:@"长发"];
        NSString * fourStr1 = [[NSString alloc] initWithFormat:@"编发"];
        NSString * fiveStr1 = [[NSString alloc] initWithFormat:@"盘发"];
        NSString * sixStr1 = [[NSString alloc] initWithFormat:@"公主头"];
        NSString * sevenStr1 = [[NSString alloc] initWithFormat:@"梨花头"];
        NSString * eightStr1 = [[NSString alloc] initWithFormat:@"蛋卷头"];
        NSString * nineStr1 = [[NSString alloc] initWithFormat:@"波波头"];
        
        NSDictionary * firstDic1=[[NSDictionary alloc] initWithObjectsAndKeys:oneImage1,@"imageArr",oneStr1,@"nameArr", nil];
        NSDictionary * secondDic1=[[NSDictionary alloc] initWithObjectsAndKeys:twoImage1,@"imageArr",twoStr1,@"nameArr", nil];
        NSDictionary * thirdDic1=[[NSDictionary alloc] initWithObjectsAndKeys:threeImage1,@"imageArr",threeStr1,@"nameArr", nil];
        NSDictionary * forthDic1=[[NSDictionary alloc] initWithObjectsAndKeys:fourImage1,@"imageArr",fourStr1,@"nameArr", nil];
        NSDictionary * fifthDic1=[[NSDictionary alloc] initWithObjectsAndKeys:fiveImage1,@"imageArr",fiveStr1,@"nameArr", nil];
        NSDictionary * sixthDic1=[[NSDictionary alloc] initWithObjectsAndKeys:sixImage1,@"imageArr",sixStr1,@"nameArr", nil];
        NSDictionary * seventhDic1=[[NSDictionary alloc] initWithObjectsAndKeys:sevenImage1,@"imageArr",sevenStr1,@"nameArr", nil];
        NSDictionary * eighthDic1=[[NSDictionary alloc] initWithObjectsAndKeys:eightImage1,@"imageArr",eightStr1,@"nameArr", nil];
        NSDictionary * ninthDic1=[[NSDictionary alloc] initWithObjectsAndKeys:nineImage1,@"imageArr",nineStr1,@"nameArr", nil];
        
        self.secondArray= [[NSArray alloc] initWithObjects:firstDic1,secondDic1,thirdDic1,forthDic1,fifthDic1, sixthDic1,seventhDic1,eighthDic1,ninthDic1, nil] ;
        
        //男生
        UIImageView * oneImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_1.png"]];
        UIImageView * twoImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_2.png"]];
        UIImageView * threeImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_3.png"]];
        UIImageView * fourImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_4.png"]];
        UIImageView * fiveImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_5.png"]];
        UIImageView * sixImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_6.png"]];
        UIImageView * sevenImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_7.png"]];
        UIImageView * eightImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_8.png"]];
        UIImageView * nineImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_2_10.png"]];
        
       
        
        NSString * oneStr2 = [[NSString alloc] initWithFormat:@"飞机头"];
        NSString * twoStr2 = [[NSString alloc] initWithFormat:@"寸头"];
        NSString * threeStr2 = [[NSString alloc] initWithFormat:@"斜庞克"];
        NSString * fourStr2 = [[NSString alloc] initWithFormat:@"莫西干"];
        NSString * fiveStr2 = [[NSString alloc] initWithFormat:@"短发"];
        NSString * sixStr2 = [[NSString alloc] initWithFormat:@"中发"];
        NSString * sevenStr2 = [[NSString alloc] initWithFormat:@"长发"];
        NSString * eightStr2 = [[NSString alloc] initWithFormat:@"蘑菇头"];
        NSString * nineStr2 = [[NSString alloc] initWithFormat:@"其他"];
        
        NSDictionary * firstDic2=[[NSDictionary alloc] initWithObjectsAndKeys:oneImage2,@"imageArr",oneStr2,@"nameArr", nil];
        NSDictionary * secondDic2=[[NSDictionary alloc] initWithObjectsAndKeys:twoImage2,@"imageArr",twoStr2,@"nameArr", nil];
        NSDictionary * thirdDic2=[[NSDictionary alloc] initWithObjectsAndKeys:threeImage2,@"imageArr",threeStr2,@"nameArr", nil];
        NSDictionary * forthDic2=[[NSDictionary alloc] initWithObjectsAndKeys:fourImage2,@"imageArr",fourStr2,@"nameArr", nil];
        NSDictionary * fifthDic2=[[NSDictionary alloc] initWithObjectsAndKeys:fiveImage2,@"imageArr",fiveStr2,@"nameArr", nil];
        NSDictionary * sixthDic2=[[NSDictionary alloc] initWithObjectsAndKeys:sixImage2,@"imageArr",sixStr2,@"nameArr", nil];
        NSDictionary * seventhDic2=[[NSDictionary alloc] initWithObjectsAndKeys:sevenImage2,@"imageArr",sevenStr2,@"nameArr", nil];
        NSDictionary * eighthDic2=[[NSDictionary alloc] initWithObjectsAndKeys:eightImage2,@"imageArr",eightStr2,@"nameArr", nil];
        NSDictionary * ninthDic2=[[NSDictionary alloc] initWithObjectsAndKeys:nineImage2,@"imageArr",nineStr2,@"nameArr", nil];
        
        self.thirdArray= [[NSArray alloc] initWithObjects:firstDic2,secondDic2,thirdDic2,forthDic2,fifthDic2, sixthDic2,seventhDic2,eighthDic2,ninthDic2, nil] ;
        
        //脸型
        UIImageView * oneImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_3_1.png"]];
        UIImageView * twoImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_3_2.png"]];
        UIImageView * threeImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_3_3.png"]];
        UIImageView * fourImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_3_4.png"]];
        
        
        NSString * oneStr3 = [[NSString alloc] initWithFormat:@"圆脸"];
        NSString * twoStr3 = [[NSString alloc] initWithFormat:@"方脸"];
        NSString * threeStr3 = [[NSString alloc] initWithFormat:@"长脸"];
        NSString * fourStr3 = [[NSString alloc] initWithFormat:@"瓜子脸"];
        
        NSDictionary * firstDic3=[[NSDictionary alloc] initWithObjectsAndKeys:oneImage3,@"imageArr",oneStr3,@"nameArr", nil];
        NSDictionary * secondDic3=[[NSDictionary alloc] initWithObjectsAndKeys:twoImage3,@"imageArr",twoStr3,@"nameArr", nil];
        NSDictionary * thirdDic3=[[NSDictionary alloc] initWithObjectsAndKeys:threeImage3,@"imageArr",threeStr3,@"nameArr", nil];
        NSDictionary * forthDic3=[[NSDictionary alloc] initWithObjectsAndKeys:fourImage3,@"imageArr",fourStr3,@"nameArr", nil];
        
        
        self.forthArray= [[NSArray alloc] initWithObjects:firstDic3,secondDic3,thirdDic3,forthDic3, nil] ;
        
        //烫发
        UIImageView * oneImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_1.png"]];
        UIImageView * twoImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_2.png"]];
        UIImageView * threeImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_3.png"]];
        UIImageView * fourImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_4.png"]];
        UIImageView * fiveImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_5.png"]];
        UIImageView * sixImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_6.png"]];
        UIImageView * sevenImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_7.png"]];
        UIImageView * eightImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_8.png"]];
        UIImageView * nineImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_4_9.png"]];
      
        
        NSString * oneStr4 = [[NSString alloc] initWithFormat:@"纹理烫"];
        NSString * twoStr4 = [[NSString alloc] initWithFormat:@"定位烫"];
        NSString * threeStr4 = [[NSString alloc] initWithFormat:@"皮卡路"];
        NSString * fourStr4 = [[NSString alloc] initWithFormat:@"水波纹"];
        NSString * fiveStr4 = [[NSString alloc] initWithFormat:@"玉米烫"];
        NSString * sixStr4 = [[NSString alloc] initWithFormat:@"螺旋烫"];
        NSString * sevenStr4 = [[NSString alloc] initWithFormat:@"离子烫"];
        NSString * eightStr4 = [[NSString alloc] initWithFormat:@"梨花烫"];
        NSString * nineStr4 = [[NSString alloc] initWithFormat:@"其他"];
        
        NSDictionary * firstDic4=[[NSDictionary alloc] initWithObjectsAndKeys:oneImage4,@"imageArr",oneStr4,@"nameArr", nil];
        NSDictionary * secondDic4=[[NSDictionary alloc] initWithObjectsAndKeys:twoImage4,@"imageArr",twoStr4,@"nameArr", nil];
        NSDictionary * thirdDic4=[[NSDictionary alloc] initWithObjectsAndKeys:threeImage4,@"imageArr",threeStr4,@"nameArr", nil];
        NSDictionary * forthDic4=[[NSDictionary alloc] initWithObjectsAndKeys:fourImage4,@"imageArr",fourStr4,@"nameArr", nil];
        NSDictionary * fifthDic4=[[NSDictionary alloc] initWithObjectsAndKeys:fiveImage4,@"imageArr",fiveStr4,@"nameArr", nil];
        NSDictionary * sixthDic4=[[NSDictionary alloc] initWithObjectsAndKeys:sixImage4,@"imageArr",sixStr4,@"nameArr", nil];
        NSDictionary * seventhDic4=[[NSDictionary alloc] initWithObjectsAndKeys:sevenImage4,@"imageArr",sevenStr4,@"nameArr", nil];
        NSDictionary * eighthDic4=[[NSDictionary alloc] initWithObjectsAndKeys:eightImage4,@"imageArr",eightStr4,@"nameArr", nil];
        NSDictionary * ninthDic4=[[NSDictionary alloc] initWithObjectsAndKeys:nineImage4,@"imageArr",nineStr4,@"nameArr", nil];
        
        self.fifthArray= [[NSArray alloc] initWithObjects:firstDic4,secondDic4,thirdDic4,forthDic4,fifthDic4, sixthDic4,seventhDic4,eighthDic4,ninthDic4, nil] ;
        
        //发色
        UIImageView * oneImage5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_5_1.png"]];
        UIImageView * twoImage5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_5_2.png"]];
        UIImageView * threeImage5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_5_3.png"]];
        UIImageView * fourImage5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hairtype_5_4.png"]];
        
        
        NSString * oneStr5 = [[NSString alloc] initWithFormat:@"整体色"];
        NSString * twoStr5 = [[NSString alloc] initWithFormat:@"渐变染色"];
        NSString * threeStr5 = [[NSString alloc] initWithFormat:@"挑染"];
        NSString * fourStr5 = [[NSString alloc] initWithFormat:@"多色染色"];
        
        NSDictionary * firstDic5=[[NSDictionary alloc] initWithObjectsAndKeys:oneImage5,@"imageArr",oneStr5,@"nameArr", nil];
        NSDictionary * secondDic5=[[NSDictionary alloc] initWithObjectsAndKeys:twoImage5,@"imageArr",twoStr5,@"nameArr", nil];
        NSDictionary * thirdDic5=[[NSDictionary alloc] initWithObjectsAndKeys:threeImage5,@"imageArr",threeStr5,@"nameArr", nil];
        NSDictionary * forthDic5=[[NSDictionary alloc] initWithObjectsAndKeys:fourImage5,@"imageArr",fourStr5,@"nameArr", nil];
        
        
        self.sixthArray= [[NSArray alloc] initWithObjects:firstDic5,secondDic5,thirdDic5,forthDic5, nil] ;
    }
    
    return self;
    
    
}

@end

