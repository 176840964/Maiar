//
//  ZoneWorkingTimeCell.m
//  MaiYa
//
//  Created by zxl on 15/10/8.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ZoneWorkingTimeCell.h"

@interface ZoneWorkingTimeCell ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labsArr;
@end

@implementation ZoneWorkingTimeCell

- (void)layoutZoneWorkingTimeCellSubviewsByDic:(NSDictionary *)dic {
    self.labsArr = [self.labsArr sortByUIViewOriginY];
    
    for (NSInteger index = 0; index < self.labsArr.count; ++index) {
        UILabel* lab = [self.labsArr objectAtIndex:index];
        
        NSDictionary *subDic = nil;
        switch (index) {
            case 0:
                lab.text = [dic objectForKey:@"week"];
                break;
            case 1:
                lab.text = [dic objectForKey:@"date"];
                break;
            case 2:
                subDic = [dic objectForKey:@"am"];
                break;
            case 3:
                subDic = [dic objectForKey:@"pm"];
                break;
            default:
                subDic = [dic objectForKey:@"night"];
                break;
        }
        
        if (1 < index) {
            [lab alignTop];
            lab.text = [subDic objectForKey:@"title"];
            lab.backgroundColor = [subDic objectForKey:@"bgColor"];
            lab.textColor = [subDic objectForKey:@"titleColor"];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
