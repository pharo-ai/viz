Class {
	#name : #AIR2ScatterViz,
	#superclass : #AIRoassal2Viz,
	#instVars : [
		'k',
		'colors'
	],
	#category : #'AI-Viz-Roassal2'
}

{ #category : #accessing }
AIR2ScatterViz >> colorAt: keyName [
	" Answer a <Color> in the receiver's colors at keyName "

	^ self colors at: keyName
]

{ #category : #accessing }
AIR2ScatterViz >> colors [
	" Answer a <Collection> of receiver's k <Color> instances "

	^ colors
		ifNil: [ colors := self defaultColors ]
]

{ #category : #accessing }
AIR2ScatterViz >> colors: aCollection [ 
	" Set the receiver's colors to be aCollection "

	colors := aCollection
]

{ #category : #defaults }
AIR2ScatterViz >> defaultColors [
	" Answer a <Collection> with defaults for the receiver's feature colors "

	^ k = 1 
		ifTrue: [ (self dfClusterNames collect: [ : featureName | featureName -> Color black ]) asDictionary ]
		ifFalse: [
			(self dfClusterNames
				with:  (Color wheel: self dfClusterNames size)
				collect: [ : featureName : colorName | featureName -> colorName ]) asDictionary ].

]

{ #category : #initialization }
AIR2ScatterViz >> initializeLegendBuilder [
	" Set the receiver's legend. If we are just exploring the points cloud (k = 1) then omit legend "

	self k = 1
		ifTrue: [ ^ self ].
	self legendBuilder 
		view: self graphBuilder view;
		addText: self legendTitle.

	self colors keysDo: [ : key | 
		self legendBuilder 
			addColor: (self colorAt: key) 
			text: key ].

	self legendBuilder build.
]

{ #category : #accessing }
AIR2ScatterViz >> k [
	^ k
]

{ #category : #accessing }
AIR2ScatterViz >> k: anObject [
	k := anObject
]

{ #category : #drawing }
AIR2ScatterViz >> plot [
	" Open a new window with the receiver's rendered into it "

	self graphBuilder open.

]
