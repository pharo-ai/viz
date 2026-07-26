Extension { #name : 'Point' }

{ #category : '*AI-Viz-Roassal3-HierarchicalClustering' }
Point >> dist: aPoint [
	"Answer the Euclidean distance between aPoint and the receiver."

	^ self distanceTo: aPoint 
]
