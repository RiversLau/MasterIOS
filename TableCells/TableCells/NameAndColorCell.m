//
//  NameAndColorCellTableViewCell.m
//  TableCells
//
//  Created by shine-team2 on 16/6/28.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "NameAndColorCell.h"

@interface NameAndColorCell()

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UILabel *colorLabel;

@end

@implementation NameAndColorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        
        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
        UILabel *nameMarker = [[UILabel alloc]initWithFrame:nameLabelRect];
        nameMarker.textAlignment = NSTextAlignmentRight;
        nameMarker.text = @"Name:";
        nameMarker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview: nameMarker];
        
        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
        UILabel *colorMarker = [[UILabel alloc]initWithFrame:colorLabelRect];
        colorMarker.textAlignment = NSTextAlignmentRight;
        colorMarker.text = @"Color:";
        colorMarker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview: colorMarker];
        
        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
        self.nameLabel = [[UILabel alloc]initWithFrame:nameValueRect];
        [self.contentView addSubview: _nameLabel];
        
        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
        self.colorLabel = [[UILabel alloc]initWithFrame:colorValueRect];
        [self.contentView addSubview: _colorLabel];
    }
    return self;
}

- (void)setName:(NSString *)aName {
    
    if (![aName isEqualToString: _name]) {
        _name = [aName copy];
        self.nameLabel.text = _name;
    }
}

- (void)setColor:(NSString *)aColor {
    
    if (![aColor isEqualToString: _color]) {
        _color = [aColor copy];
        self.colorLabel.text = _color;
    }
}

@end
