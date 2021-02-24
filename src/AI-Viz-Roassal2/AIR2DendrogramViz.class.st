Class {
	#name : #AIR2DendrogramViz,
	#superclass : #AIRoassal2Viz,
	#instVars : [
		'orientation',
		'leafRotation',
		'leafFontSize',
		'leafColor'
	],
	#category : #'AI-Viz-Roassal2'
}

{ #category : #'instance creation' }
AIR2DendrogramViz class >> from: aClusterEngine [
	" Answer a new instance of the receiver using dendrogram data from aClusterEngine "

	^ self new 
		initializeFrom: aClusterEngine;
		yourself
]

{ #category : #accessing }
AIR2DendrogramViz >> colorThreshold: aNumber [
	" Set the receiver's threshold at which the 
	
	Colors all the descendent links below a cluster node the same color if is the first node below the cut threshold 
	"
]

{ #category : #defaults }
AIR2DendrogramViz >> defaultLeafRotation [
	" Answer a <Symbol> used to set the default rotation of the receiver's leaves "

	self shouldBeImplemented
]

{ #category : #defaults }
AIR2DendrogramViz >> defaultOrientation [
	" Answer a <Symbol> used to set the default direction of the receiver "

	^ #top
]

{ #category : #accessing }
AIR2DendrogramViz >> leafColor [
	^ leafColor
		ifNil: [ leafColor := Color black ]
]

{ #category : #accessing }
AIR2DendrogramViz >> leafColor: anObject [
	leafColor := anObject
]

{ #category : #accessing }
AIR2DendrogramViz >> leafFontSize [
	^ leafFontSize
]

{ #category : #accessing }
AIR2DendrogramViz >> leafFontSize: aNumber [
	" Set the receiver's leaves labels font size "

	leafFontSize := aNumber
]

{ #category : #accessing }
AIR2DendrogramViz >> leafRotation [
	" Answer a <Number> representing an angle of the receiver's leaf labels rotation "

	^ leafRotation
		ifNil: [ leafRotation := self defaultLeafRotation ]
]

{ #category : #accessing }
AIR2DendrogramViz >> leafRotation: aNumber [
	" Set aNumber representing an angle of the receiver's leaf labels rotation "

	leafRotation := aNumber
]

{ #category : #accessing }
AIR2DendrogramViz >> orientation [
	" Answer a <Symbol> representing the receiver's direction "

	^ orientation
		ifNil: [ orientation := self defaultOrientation ]
]

{ #category : #accessing }
AIR2DendrogramViz >> rotate [
	" Rotate the receiver to the next orientation clock-wise "

	self shouldBeImplemented
]

{ #category : #accessing }
AIR2DendrogramViz >> setBottomOrientation [
	" Set the receiver's direction placing the root at the bottom and nodes going downwards "
	
	orientation := #bottom
]

{ #category : #accessing }
AIR2DendrogramViz >> setLeftOrientation [
	" Set the receiver's direction placing the root at the left and nodes going downwards "
	
	orientation := #left
]

{ #category : #accessing }
AIR2DendrogramViz >> setRightOrientation [
	" Set the receiver's direction placing the root at the right and nodes going downwards "
	
	orientation := #right
]

{ #category : #accessing }
AIR2DendrogramViz >> setTopOrientation [
	" Set the receiver's direction placing the root at the top and nodes going downwards "
	
	orientation := #top
]

{ #category : #accessing }
AIR2DendrogramViz >> withBranchLengths [
	" Show branch length of each line in the receiver "

]

{ #category : #accessing }
AIR2DendrogramViz >> withoutLabels [
	" Omit plotting the leaves labels in the receiver "

]
