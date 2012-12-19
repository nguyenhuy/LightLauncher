//
//  LLHistoryCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryCell.h"

#import "LLCommandPrototype.h"

#import "Receipt.h"

@implementation LLHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        self.imageView.gestureRecognizers = [NSArray arrayWithObject:tapRecognizer];
        self.imageView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)like {
    [self.delegate onLikeReceiptAtIndexPath:self.indexPath];
}

- (void)updateViewWithReceipt:(Receipt *)receipt atIndexPath:(NSIndexPath *)indexPath andDelegate:(id<LLHistoryCellDelegate>)delegate {
    if (!receipt) {
        return;
    }
    
    self.indexPath = indexPath;
    self.delegate = delegate;
    self.textLabel.text = receipt.commandPrototype.desc;
    
    UIImage *likeImage;
    if ([receipt.liked boolValue]) {
        likeImage = [UIImage imageNamed:@"facebook"];
    } else {
        likeImage = [UIImage imageNamed:@"twitter"];
    }
    self.imageView.image = likeImage;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.detailTextLabel.text = [dateFormatter stringFromDate:receipt.executedDate];    
}

- (void)dealloc {
    self.delegate = nil;
}

@end
