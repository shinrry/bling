#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface secondViewController : UIViewController {
    int num1, num2, answer, total, correct;
    char symbol;
	int option0, option1, option2, option3;
	UIButton *answer1,*answer2,*answer3,*answer4;
	UILabel *question;
	NSTimer *gameTime;
	int selectQuestionSender;
	UIView *finshView;
	
	CATransition *lastAnimation;
}

@property int num1, num2, answer, total, correct;
@property int option0, option1, option2, option3;
@property char symbol;

@property (nonatomic,retain) CATransition *lastAnimation;
@property (retain,nonatomic)IBOutlet UIButton *answer1, *answer2, *answer3, *answer4;
@property (retain,nonatomic)IBOutlet UILabel *question;
@property (retain,nonatomic)IBOutlet UIView *finshView;
@property (retain,nonatomic)NSTimer *mytimer;

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)buttonId;
- (void)play;
- (IBAction)answer1Pressed:(UIButton*)answerButton1;
- (void)revealQuestionAndAnswer;
- (void)timeout;
- (void)gameover;
- (void)retry;
- (void)returnToMainMenu;
- (void)flicker;
-(void)revealButtonsInLeft;

@end
