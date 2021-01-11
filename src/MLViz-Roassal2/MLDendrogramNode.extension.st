Extension { #name : #MLDendrogramNode }

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> inOrderDo: aBlock [
    " Visit the elements of the binary tree in order: left, then root, then right, applying a block to each element "

	self left inOrderDo: aBlock.
	aBlock value: self.
	self right inOrderDo: aBlock.
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> lineLengthThreshold [

	^ self isRoot 
		ifTrue: [ self max: 10 sum: self totalDepth ]
		ifFalse: [ self parent lineLengthThreshold ]
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> max: xStart sum: aFloat [

	| lineLength toPoint1 |

	lineLength := aFloat - self nodeDepth "self threshold * aFloat".
	toPoint1 := xStart + lineLength.

	^ (self left 
		max: toPoint1
		sum: aFloat)
		max:
	(self right
		max: toPoint1
		sum: aFloat)
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> nodeDepth [
	" Answer a <Float> with the receiver's depth, the max of each child plus own distance "
	
	^ (self left nodeDepth max: self right nodeDepth) + self threshold
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> nodeHeight [
	" Answer a <Number> with the receiver's height, the sum of each branch "
	
	^ self left nodeHeight + self right nodeHeight
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> plot [

	| scaling depthFactor heightFactor w  view |
	
	view := RTView new.
	heightFactor := self nodeHeight * 20.
	depthFactor := self nodeDepth.
	w := 1200.
	scaling := (w - 150) asFloat / depthFactor.
	
	view canvas addShape: (TRLineShape new
	    from: 0 @ (heightFactor / 2);
	    to: 10 @ (heightFactor / 2);
	    color: Color black;
	    yourself).

	self 
		plotAt: (10 @ (heightFactor / 2))
		scaling: scaling 
		view: view.
	view inspect
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> plot2 [
	" Intento unir RTGrapher con el dendrograma a mano usando RTData "

	| scaling w height grapher view dataSet |
	
	grapher := RTGrapher new.
	grapher extent: 500 @ 100.
	view := grapher view.
	
	height := self nodeHeight * 20.
	depth := self nodeDepth.

	w := 1200.
	scaling := (w - 150) asFloat / depth.
	dataSet := RTData new.
	dataSet points: ((self leaves collect: #element) collect: #x).

	view canvas addShape: (TRLineShape new
	    from: 0 @ (height / 2);
	    to: 10 @ (height / 2);
	    color: Color black;
	    yourself).

	self 
		plotAt: (10 @ (height / 2))
		scaling: scaling 
		view: view.
	grapher add: dataSet.
	grapher build.
	view open.
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> plot4 [
	| view |

	view := RTView new.

	self 
		plotLineIn: view 
		from:  0 @ (self heightFactor / 2) 
		to: 10 @ (self heightFactor / 2).

	self 
		plot4At: 10 @ (self heightFactor / 2) 
		scaling: self totalDepth
		view: view.
	view inspect
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> plot4At: aPoint scaling: aFloat view: aView [

	| lHeightFactor rHeightFactor top bottom lineLength fromPoint1 toPoint2 y1 toPoint1 |

	lHeightFactor := self left nodeHeight * 20.
	rHeightFactor := self right nodeHeight * 20.
	
	top := aPoint y - (lHeightFactor + (rHeightFactor / 2)).
	bottom := aPoint y + (lHeightFactor + (rHeightFactor / 2)).
	
	lineLength := (aFloat - self nodeDepth)"self threshold * aFloat".

	fromPoint1 := (aPoint x @ (top + (lHeightFactor / 2))).
	toPoint1 := (aPoint x + lineLength) @ (top + (lHeightFactor / 2)).

	y1 := (aPoint x @ (bottom - (rHeightFactor / 2))).
	toPoint2 := (aPoint x + lineLength) @ (bottom - (rHeightFactor / 2)).

	" Render vertical line from this node to the leaves "
	self plotLineIn: aView 
		from: fromPoint1 
		to: y1.

	" Render horizontal line to the left item "
	self left isLeaf ifTrue: [ toPoint1 := self lineLengthThreshold @ toPoint1 y. ].
	self plotLineIn: aView 
		from: fromPoint1
		to: toPoint1.

	" Render horizontal line to the right item "
	self right isLeaf ifTrue: [ toPoint2 := self lineLengthThreshold @ toPoint2 y. ].
	self plotLineIn: aView 
		from: y1
		to: toPoint2.

	self left 
		plot4At: toPoint1
		scaling: aFloat 
		view: aView.
	self right
		plot4At: toPoint2
		scaling: aFloat 
		view: aView.
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> plotAt: aPoint scaling: aFloat view: aView [

	| lHeightFactor rHeightFactor top bottom lineLength fromPoint1 toPoint2 y1 toPoint1 |

	lHeightFactor := self left nodeHeight * 20.
	rHeightFactor := self right nodeHeight * 20.
	
	top := aPoint y - (lHeightFactor + (rHeightFactor / 2)).
	bottom := aPoint y + (lHeightFactor + (rHeightFactor / 2)).	
	lineLength := (aFloat - self nodeDepth)"self threshold * aFloat".
	fromPoint1 := (aPoint x @ (top + (lHeightFactor / 2))).
	toPoint1 := (aPoint x + lineLength) @ (top + (lHeightFactor / 2)).

	y1 := (aPoint x @ (bottom - (rHeightFactor / 2))).
	toPoint2 := (aPoint x + lineLength) @ (bottom - (rHeightFactor / 2)).

	" Render vertical line from this node to the leaves "
	self plotLineIn: aView 
		from: fromPoint1 
		to: y1.

	" Render horizontal line to the left item "
	self plotLineIn: aView 
		from: fromPoint1
		to: toPoint1.

	" Render horizontal line to the right item "
	self plotLineIn: aView 
		from: y1
		to: toPoint2.

	self left 
		plotAt: toPoint1
		scaling: aFloat 
		view: aView.
	self right
		plotAt: toPoint2
		scaling: aFloat 
		view: aView.
]

{ #category : #'*MLViz-Roassal2' }
MLDendrogramNode >> plotLeaves [

	| view leaves |
	
	view := RTView new.
	leaves := RTLabel new 
		height: 20;
		elementsOn: (self leaves collect: #element).
	view addAll: leaves.
	RTHorizontalLineLayout new
		gapSize: 30;
		on: view elements.
	view open
]
