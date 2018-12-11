using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Attention;

class whatsthescoreDelegate extends Ui.BehaviorDelegate {

	var view;
	var myTimer = new Timer.Timer();
	var goBack = false;
	var teamScoredVibe = [
        new Attention.VibeProfile(50, 500), // On for two seconds
        new Attention.VibeProfile(0, 500),  // Off for two seconds
    ];
    
    var undoScoreVibe = [
        new Attention.VibeProfile(100, 500), // On for two seconds
        new Attention.VibeProfile(0, 500),  // Off for two seconds
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
	        if (Attention has :vibrate) {
			    Attention.vibrate(teamScoredVibe);
			}
        	onUp();
        } else if (keyEvent.getKey() == Ui.KEY_DOWN) {
        	if (Attention has :vibrate) {
			    Attention.vibrate(teamScoredVibe);
			}
        	onDown();
		} else if (keyEvent.getKey() == Ui.KEY_ENTER) {
			if (Attention has :vibrate) {
			    Attention.vibrate(undoScoreVibe);
			}
			onEnter();
        } else {
        	return true;
        }
        return true;
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