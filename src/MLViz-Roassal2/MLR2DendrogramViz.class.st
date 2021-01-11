Class {
	#name : #MLR2DendrogramViz,
	#superclass : #MLRoassal2Viz,
	#instVars : [
		'orientation',
		'leafRotation',
		'leafFontSize'
	],
	#category : #'MLViz-Roassal2'
}

{ #category : #accessing }
MLR2DendrogramViz >> colorThreshold: aNumber [
	" Set the receiver's threshold at which the 
	
	Colors all the descendent links below a cluster node the same color if is the first node below the cut threshold 
	"
]

{ #category : #defaults }
MLR2DendrogramViz >> defaultOrientation [
	" Answer a <Symbol> used to set the default direction of the receiver "

	^ #top
]

{ #category : #accessing }
MLR2DendrogramViz >> leafFontSize [
	^ leafFontSize
]

{ #category : #accessing }
MLR2DendrogramViz >> leafFontSize: aNumber [
	" Set the receiver's leaves labels font size "

	leafFontSize := aNumber
]

{ #category : #accessing }
MLR2DendrogramViz >> leafRotation [
	" Answer a <Number> representing an angle of the receiver's leaf labels rotation "

	^ leafRotation
]

{ #category : #accessing }
MLR2DendrogramViz >> leafRotation: aNumber [
	" Set aNumber representing an angle of the receiver's leaf labels rotation "

	leafRotation := aNumber
]

{ #category : #accessing }
MLR2DendrogramViz >> orientation [
	" Answer a <Symbol> representing the receiver's direction "

	^ orientation
		ifNil: [ orientation := self defaultOrientation ]
]

{ #category : #accessing }
MLR2DendrogramViz >> rotate [
	" Rotate the receiver to the next orientation clock-wise "

]

{ #category : #accessing }
MLR2DendrogramViz >> setBottomOrientation [
	" Set the receiver's direction placing the root at the bottom and nodes going downwards "
	
	orientation := #bottom
]

{ #category : #accessing }
MLR2DendrogramViz >> setLeftOrientation [
	" Set the receiver's direction placing the root at the left and nodes going downwards "
	
	orientation := #left
]

{ #category : #accessing }
MLR2DendrogramViz >> setRightOrientation [
	" Set the receiver's direction placing the root at the right and nodes going downwards "
	
	orientation := #right
]

{ #category : #accessing }
MLR2DendrogramViz >> setTopOrientation [
	" Set the receiver's direction placing the root at the top and nodes going downwards "
	
	orientation := #top
]

{ #category : #accessing }
MLR2DendrogramViz >> withBranchLengths [
	" Show branch length of each line in the receiver "

]

{ #category : #accessing }
MLR2DendrogramViz >> withoutLabels [
	" Omit plotting the leaves labels in the receiver "

]
