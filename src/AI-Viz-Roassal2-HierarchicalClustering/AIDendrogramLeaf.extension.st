Extension { #name : #AIDendrogramLeaf }

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> inOrderDo: aBlock [
    " Apply a block to the receiver's element "

	^ aBlock value: self.
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> max: xStart sum: aFloat [

	^ xStart
	

]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> nodeDepth [
	" Answer a <Float> with the receiver's depth "
	
	^ 0.0
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> nodeHeight [
	" Answer a <Number> with the receiver's height "
	
	^ 1
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> plotAt: aPoint scaling: aFloat view: aCanvas color: aColor [
	" Rrender the receiver's element (commonly a String) wrapped into a label with the receiver as a Roassal element "
	| label |

	label := RTLabel new 
		text: self element;
		elementOn: self.
	aCanvas add: label.
	label @ RTDraggable.
	label translateTo: (aPoint x + self totalDepth) @ aPoint y.
	^ aColor

]
