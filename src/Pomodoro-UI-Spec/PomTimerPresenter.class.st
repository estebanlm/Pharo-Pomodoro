Class {
	#name : #PomTimerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'taskLabel',
		'timerPanel',
		'buttonBar'
	],
	#category : #'Pomodoro-UI-Spec'
}

{ #category : #specs }
PomTimerPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: (SpBoxLayout newVertical
			borderWidth: 5; 
			add: #taskLabel expand: false fill: false padding: 0;
			add: #timerPanel expand: true fill: true padding: 0;
			yourself);
		addLast: #buttonBar expand: false fill: false padding: 5;
		yourself
]

{ #category : #actions }
PomTimerPresenter >> doConfigure [
]

{ #category : #actions }
PomTimerPresenter >> doPause [
]

{ #category : #actions }
PomTimerPresenter >> doStart [
]

{ #category : #actions }
PomTimerPresenter >> doStop [
]

{ #category : #initialization }
PomTimerPresenter >> initializeWidgets [
	
	taskLabel := self newLabel label: 'Task'.
	timerPanel := self newLabel label: 'TIME'.
	buttonBar := self newActionBar
		add: (self newButton 
			help: 'Settings';
			icon: (self application iconNamed: #settings);
			action: [ self doConfigure ];
			yourself);
		addLast: (self newButton
			help: 'Stop';
			icon: (self application iconNamed: #stop);
			action: [ self doStop ];
			yourself);
		addLast: (self newButton
			help: 'Pause';
			icon: (self application iconNamed: #pause);
			action: [ self doPause ];
			yourself);
		addLast: (self newButton
			help: 'Start';
			icon: (self application iconNamed: #play);
			action: [ self doStart ];
			yourself);
		yourself.
		
	timerPanel whenBuiltDo: [ :ann | ann widget hAlign: GtkAlign GTK_ALIGN_CENTER ]
]

{ #category : #initialization }
PomTimerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Pomodoro';
		initialExtent: 250@150
]
