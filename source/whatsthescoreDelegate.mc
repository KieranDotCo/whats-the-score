using Toybox.WatchUi as Ui;
using Toybox.System;

class whatsthescoreDelegate extends Ui.BehaviorDelegate {

	var view;
	
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
        	onUp();
        } else if (keyEvent.getKey() == Ui.KEY_DOWN) {
        	onDown();
		} else if (keyEvent.getKey() == Ui.KEY_ENTER) {
			onEnter();
        } else {
        	System.println(keyEvent.getKey());
        	return true;
        }
        return true;
    }
	
	function onBack() {
    	System.println("BACK");
    }
}