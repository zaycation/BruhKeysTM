// Import the framework which has the AVAudioPlayer class
#import <AVFoundation/AVFoundation.h> 

@interface UIKeyboardLayoutStar : UIView
// Create new property for AVAudioPlayer and retain it. 
@property (nonatomic, retain) AVAudioPlayer* gayPlayer;
@end

// hook the UIKeyboardLayoutStar view
%hook UIKeyboardLayoutStar
// Add the property to the UIKeyboardLayoutStar class because it doesn't exist :DD
%property (nonatomic, retain) AVAudioPlayer* gayPlayer;

-(instancetype)initWithFrame:(CGRect)frame {
    if ((self = %orig)) {
		// Add a UITapGestureRecognizer to the keyboard layout and do not let it block touches in the view
		UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onKeyboardTouch:)];
        gestureRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:gestureRecognizer];

		// Make a string with the file path of the mp3 sound file and create a NSURL of it
		NSString* gayFilePath = @"/Library/Application Support/gayKeysTM/gaySound.mp3";
		NSURL* gayFileURL = [NSURL fileURLWithPath:gayFilePath];

		// Init the gayPlayer, set its volume
		self.gayPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:gayFileURL error:nil];
		self.gayPlayer.volume = 1;
     }
     return self;

}

// %new because the method doesn't exist in the class 
%new
-(void)onKeyboardTouch:(UITapGestureRecognizer *)gestureRecognizer {
	// Rewind the current time of the gayPlayer back to 0, if the old sound was still playing :D
	self.gayPlayer.currentTime = 0;
	// In the next 2 methods we prepare the gayPlayer to play and actually play it, the prepare one is needed for less lag between playing and clicking a key on the keyboard
	[self.gayPlayer prepareToPlay];
	[self.gayPlayer play];
    
}

// end of the hook
%end