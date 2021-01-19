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
AIDendrogramLeaf >> plot [

	| scaling height view |
	
	view := RTView new.
	height := self nodeHeight * 20.
	scaling := 1050 asFloat.
	
	self 
		plotAt: (10 @ height / 2) 
		scaling: scaling 
		view: view.
	view open
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> plot4At: aPoint scaling: aFloat view: aCanvas [

	| label |

	label := RTElement new.
	aCanvas add: (RTLabel new 
		text: self element;
		elementOn: self).
	label @ RTDraggable.
	label translateTo: self totalDepth @ (aPoint y).
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramLeaf >> plotAt: aPoint scaling: aFloat view: aCanvas [

	| label |
	
	label := RTElement new.
	aCanvas add: (RTLabel new 
		text: self element;
		elementOn: self).
	label @ RTDraggable.
	label translateTo: aPoint.
]
