//
//  secondViewController.h
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface secondViewController : UIViewController {
        int num1, num2, answer, total, correct;
        char symbol;
	int option0, option1, option2, option3;
	UIButton *answer1,*answer2,*answer3,*answer4;
	UILabel *question;
	NSTimer *gameTime;
	BOOL buttonPressed,runNotRepeat;//默认的是NO

	int selectQuestionSender;
	UIView *finshView;
	
	BOOL isHalfAnimation;
	CATransition *lastAnimation;
}

@property int num1, num2, answer, total, correct;
@property int option0, option1, option2, option3;
@property char symbol;

@property (nonatomic,retain) CATransition *lastAnimation;
@property (retain,nonatomic)IBOutlet UIButton *answer1,*answer2,*answer3,*answer4;
@property (retain,nonatomic)IBOutlet UILabel *question;
@property (retain,nonatomic)IBOutlet UIView *finshView;
@property (retain,nonatomic)NSTimer *mytimer;
@property (nonatomic)BOOL buttonPressed,runNotRepeat;

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)buttonId;
- (void)play;
- (IBAction)answer1Pressed:(UIButton*)answerButton1;
- (void)revealQuestionAndAnswer;
- (void)timeout;
- (void)gameover;
- (void)finshButton1Pressed;
- (void)finshButton2Pressed;
- (void)flicker;
-(void)revealButtonsInLeft

@end
