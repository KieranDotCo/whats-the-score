using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Attention;

class whatsthescoreDelegate extends Ui.BehaviorDelegate {

	var view;
	var myTimer = new Timer.Timer();
	var goBack = false;
	var teamScoredVibe = [
        new Attention.VibeProfile(50, 500),
        new Attention.VibeProfile(0, 500)
    ];
    
    var undoScoreVibe = [
        new Attention.VibeProfile(100, 500),
        new Attention.VibeProfile(0, 500)
    ];
	
    function initialize(_view) {
        BehaviorDelegate.initialize();
        view = _view;
    }
    
    function onUp() {
    	return view.team1Scored();
    }
    
    function onDown() {
    	return view.team2Scored();
    }
    
    function onEnter() {
    	return view.undo();
    }
    
    function onKey(keyEvent) {
        if (keyEvent.getKey() == Ui.KEY_UP) {
	        vibrate(teamScoredVibe);
	        playTone(Attention.TONE_START);
        	onUp();
        } else if (keyEvent.getKey() == Ui.KEY_DOWN) {
        	vibrate(teamScoredVibe);
        	playTone(Attention.TONE_STOP);
        	onDown();
		} else if (keyEvent.getKey() == Ui.KEY_ENTER) {
		playTone(Attention.TONE_LOUD_BEEP);
			vibrate(undoScoreVibe);
			onEnter();
        } else {
        	return true;
        }
        return true;
    }
	
	function vibrate(vibeProfile) {
		if (Attention has :vibrate) {
		    Attention.vibrate(vibeProfile);
		}
	}
	
	function playTone(tone) {
		if (Attention has :playTone) {
		   Attention.playTone(tone);
		}
	}
	
	function onBack() {
		if (goBack) {
			goBack = false;
			Ui.popView(Ui.SLIDE_IMMEDIATE);
			return true;
		}
		
		myTimer.start(method(:cancelGoBack), 1000, true);
    	goBack = true;
    	
    	return false;
    }
    
   	function cancelGoBack() {
   		goBack = false;
   	}
}