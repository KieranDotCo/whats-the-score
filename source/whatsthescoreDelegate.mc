using Toybox.WatchUi as Ui;
using Toybox.System;

class whatsthescoreDelegate extends Ui.BehaviorDelegate {

	var view;
	var myTimer = new Timer.Timer();
	var goBack = false;
	
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
        //new Attention.VibeProfile(100, 500);
        if (keyEvent.getKey() == Ui.KEY_UP) {
        	onUp();
        } else if (keyEvent.getKey() == Ui.KEY_DOWN) {
        	onDown();
		} else if (keyEvent.getKey() == Ui.KEY_ENTER) {
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