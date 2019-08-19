Class {
	#name : #PomApplication,
	#superclass : #SpApplication,
	#instVars : [
		'iconProvider'
	],
	#classInstVars : [
		'running'
	],
	#category : #'Pomodoro-UI-Spec'
}

{ #category : #testing }
PomApplication class >> isDevelopment [

	^ true
]

{ #category : #running }
PomApplication class >> run [
	<script>
	
	self new run
]

{ #category : #accessing }
PomApplication class >> running [

	^ running ifNotNil: [ :aValueHolder | aValueHolder contents ]
]

{ #category : #accessing }
PomApplication class >> running: anApplication [

	running ifNil: [ running := SpWeakValueHolder new ].
	running contents: anApplication
]

{ #category : #accessing }
PomApplication >> iconNamed: aSymbol [

	^ self iconProvider iconNamed: aSymbol	

]

{ #category : #accessing }
PomApplication >> iconProvider [

	^ iconProvider ifNil: [ iconProvider := PomIconProvider newLocation: self iconsDir ]
]

{ #category : #accessing }
PomApplication >> iconsDir [

	self flag: #TODO. "§"
	self class isDevelopment ifTrue: [ 
		"In development time, I want to take he icons from the repository"
		IceRepository registry 
			detect: [ :each | each name = 'pharo-pomodoro' ]
			ifFound: [ :aRepository | ^ aRepository location / 'icons' ] ].
				
	^ FileLocator imageDirectory / 'icons'
]

{ #category : #initialization }
PomApplication >> initialize [

	super initialize.
	self useBackend: #Gtk
]

{ #category : #running }
PomApplication >> run [

	self class running ifNotNil: [ :anApplication | anApplication close ].
	self class running: self.
	super run
]

{ #category : #running }
PomApplication >> start [

	(self new: PomTimerPresenter) openWithSpec
]
