//
//  LCFPhotoCell.m
//  ScalePhoto
//
//  Created by lvhe on 2019/2/11.
//  Copyright © 2019 lvhe. All rights reserved.
//

#import "LCFPhotoCell.h"

@implementation LCFPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoView.layer.borderWidth = 6;
    self.photoView.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
