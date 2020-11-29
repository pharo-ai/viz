Class {
	#name : #MLR2ScatterViz,
	#superclass : #MLRoassal2Viz,
	#instVars : [
		'k',
		'colors'
	],
	#category : #'MLViz-Roassal2'
}

{ #category : #accessing }
MLR2ScatterViz >> colorAt: keyName [
	" Answer a <Color> in the receiver's colors at keyName "

	^ self colors at: keyName
]

{ #category : #accessing }
MLR2ScatterViz >> colors [
	" Answer a <Collection> of receiver's k <Color> instances "

	^ colors
		ifNil: [ colors := self defaultColors ]
]

{ #category : #accessing }
MLR2ScatterViz >> colors: aCollection [ 
	" Set the receiver's colors to be aCollection "

	colors := aCollection
]

{ #category : #defaults }
MLR2ScatterViz >> defaultColors [
	" Answer a <Collection> with defaults for the receiver's feature colors "

	^ k = 1 
		ifTrue: [ (self dfClusterNames collect: [ : featureName | featureName -> Color black ]) asDictionary ]
		ifFalse: [
			(self dfClusterNames
				with:  (Color wheel: self dfClusterNames size)
				collect: [ : featureName : colorName | featureName -> colorName ]) asDictionary ].

]

{ #category : #initialization }
MLR2ScatterViz >> initializeLegendBuilder [
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
MLR2ScatterViz >> k [
	^ k
]

{ #category : #accessing }
MLR2ScatterViz >> k: anObject [
	k := anObject
]

{ #category : #drawing }
MLR2ScatterViz >> plot [
	" Open a new window with the receiver's rendered into it "

	self graphBuilder open.

]
