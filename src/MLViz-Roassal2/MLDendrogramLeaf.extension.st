Extension { #name : #MLDendrogramLeaf }

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> inOrderDo: aBlock [
    " Apply a block to the receiver's element "

	^ aBlock value: self.
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> max: xStart sum: aFloat [

	^ xStart
	

]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> nodeDepth [
	" Answer a <Float> with the receiver's depth "
	
	^ 0.0
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> nodeHeight [
	" Answer a <Number> with the receiver's height "
	
	^ 1
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> plot [

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

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> plot4At: aPoint scaling: aFloat view: aCanvas [

	| label |

	label := RTElement new.
	aCanvas add: (RTLabel new 
		text: self element;
		elementOn: self).
	label @ RTDraggable.
	label translateTo: self totalDepth @ (aPoint y).
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramLeaf >> plotAt: aPoint scaling: aFloat view: aCanvas [

	| label |
	
	label := RTElement new.
	aCanvas add: (RTLabel new 
		text: self element;
		elementOn: self).
	label @ RTDraggable.
	label translateTo: aPoint.
]
