//
//  MLCTextStatsViewController.m
//  attributer
//
//  Created by Martin Calvert on 1/15/15.
//  Copyright (c) 2015 Martin Calvert. All rights reserved.
//

#import "MLCTextStatsViewController.h"

@interface MLCTextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharacters;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacters;

@end

@implementation MLCTextStatsViewController

- (void)textToAnalyze:(NSAttributedString*)textToAnalyze{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString*)charactersWithAttribute:(NSString*)attributeName{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc]init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    
    return characters;
}

- (void)updateUI{
    self.colorfulCharacters.text = [NSString stringWithFormat:@"Colorful Characters: %d", (int)[[self charactersWithAttribute:NSForegroundColorAttributeName] length ]];
    self.outlinedCharacters.text = [NSString stringWithFormat:@"Outlined Characters: %d", (int)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length ]];
}

@end
