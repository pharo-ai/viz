Extension { #name : #AIDendrogramLeaf }

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramLeaf >> inOrderDo: aBlock [
    " Apply a block to the receiver's element "

	^ aBlock value: self.
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramLeaf >> max: xStart sum: aFloat [

	^ xStart
	

]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramLeaf >> nodeDepth [
	" Answer a <Float> with the receiver's depth "
	
	^ 1
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramLeaf >> nodeHeight [
	" Answer a <Number> with the receiver's height "
	
	^ 1
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramLeaf >> plotAt: aPoint scaling: aFloat view: aCanvas color: aColor [
	" Rrender the receiver's element (commonly a String) wrapped into a label "

	| label |
	label := RSLabel new
		text: self element;
		color: aColor.

	"text is centered so shifting it right by half its width"
	label position: 0 + (label textWidth / 2) @ aPoint y.
	aCanvas add: label.
	^ aPoint
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramLeaf >> thresholdPosition: thresholdScaling [

	^0

]
