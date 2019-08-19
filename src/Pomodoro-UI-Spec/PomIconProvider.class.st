Class {
	#name : #PomIconProvider,
	#superclass : #Object,
	#instVars : [
		'icons',
		'location'
	],
	#category : #'Pomodoro-UI-Spec'
}

{ #category : #'instance creation' }
PomIconProvider class >> new [

	self error: 'Use #newLocation:'
]

{ #category : #'instance creation' }
PomIconProvider class >> newLocation: aReference [ 

	^ self basicNew 
		initializeLocation: aReference;
		yourself
]

{ #category : #accessing }
PomIconProvider >> iconNamed: aSymbol [

	^ icons 
		at: aSymbol
		ifAbsentPut: [ self loadIconNamed: aSymbol ]
]

{ #category : #initialization }
PomIconProvider >> initialize [ 

	super initialize.
	icons := IdentityDictionary new
]

{ #category : #initialization }
PomIconProvider >> initializeLocation: aReference [

	location := aReference.
	self initialize
]

{ #category : #loading }
PomIconProvider >> loadAllIcons [

	(self location filesMatching: '*.png') do: [ :each |
		icons 
			at: each basename
			put: (self loadIcon: each) ]
]

{ #category : #loading }
PomIconProvider >> loadIcon: fileRef [

	fileRef exists ifFalse: [ 
		self error: ('Icon {1} does not exits' format: { fileRef fullName }) ].

	^ fileRef binaryReadStreamDo: [ :stream |
		 Form fromBinaryStream: stream ]
]

{ #category : #loading }
PomIconProvider >> loadIconNamed: aSymbol [

	^ self loadIcon: ((self location / aSymbol) withExtension: 'png')
]

{ #category : #accessing }
PomIconProvider >> location [

	^ location
]
