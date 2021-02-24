Extension { #name : #AIDendrogramNode }

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> inOrderDo: aBlock [
    " Visit the elements of the binary tree in order: left, then root, then right, applying a block to each element "

	self left inOrderDo: aBlock.
	aBlock value: self.
	self right inOrderDo: aBlock.
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> leftHeight [
	" Answer a <Number> with the receiver's left children height "
	
	^ self left nodeHeight
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> lineLengthThreshold [

	^ self isRoot 
		ifTrue: [ self max: 10 sum: self totalDepth ]
		ifFalse: [ self parent lineLengthThreshold ]
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> max: xStart sum: aFloat [

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

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> nodeDepth [
	" Answer a <Float> with the receiver's depth, the max of each child plus own distance "
	
	^ (self left nodeDepth max: self right nodeDepth) + self threshold
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> nodeHeight [
	" Answer a <Number> with the receiver's height, the sum of each branch "
	
	^ self left nodeHeight + self right nodeHeight
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> plotAt: aPoint scaling: aFloat view: aView color: aColor [
	" Private - Render the receiver's into aView using aPoint as starting point. 
	Assuming an horizontal orientation, this method calculates the distance for 3 lines:
		The vertical line from the receiver to the leaves.
		The horizontal lines to both leaves.
	And then recursively render the leaves "

	| lHeightFactor rHeightFactor top bottom lineLength fromPoint1 toPoint2 y1 toPoint1 |

	lHeightFactor := self leftHeight * 20.
	rHeightFactor := self rightHeight * 20.
	
	top := aPoint y - (lHeightFactor + (rHeightFactor / 2)).
	bottom := aPoint y + (lHeightFactor + (rHeightFactor / 2)).
	
	lineLength := (aFloat - self nodeDepth)"self threshold * aFloat".

	fromPoint1 := aPoint x @ (top + (lHeightFactor / 2)).
	toPoint1 := (aPoint x + lineLength) @ (top + (lHeightFactor / 2)).

	y1 := aPoint x @ (bottom - (rHeightFactor / 2)).
	toPoint2 := (aPoint x + lineLength) @ (bottom - (rHeightFactor / 2)).

	self left 
		plotAt: toPoint1
		scaling: aFloat 
		view: aView
		color: aColor.
	self right
		plotAt: toPoint2
		scaling: aFloat 
		view: aView
		color: aColor.

	" Render vertical line from this node to the leaves "
	self 
		plotLineIn: aView 
		from: fromPoint1 
		to: y1
		color: aColor.

	" Render horizontal line to the left item "
	self left isLeaf 
		ifTrue: [ toPoint1 := self lineLengthThreshold @ toPoint1 y ].
	self 
		plotLineIn: aView 
		from: fromPoint1
		to: toPoint1
		color: aColor.

	" Render horizontal line to the right item "
	self right isLeaf 
		ifTrue: [ toPoint2 := self lineLengthThreshold @ toPoint2 y ].
	self plotLineIn: aView 
		from: y1
		to: toPoint2
		color: aColor.



]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> plotDendrogram [
	" Open a view of the receiver's.
	Starting point to render the receiver using Roassal. Create a small line which is the root of the receiver's tree. Then recursively process the leaves. "

	| view |

	view := RTView new.
	self 
		plotLineIn: view 
		from:  0 @ (self heightFactor / 2) 
		to: 10 @ (self heightFactor / 2)
		color: Color black.

	self 
		plotAt: 10 @ (self heightFactor / 2) 
		scaling: self totalDepth
		view: view
		color: Color black.
	view inspect
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> plotLineIn: view from: startPoint to: endPoint color: aColor [
	" Add a line from startPoint to endPoint into view "

	view canvas
		addShape:
			(TRLineShape new
				from: startPoint;
				to: endPoint;
				color: aColor;
				width: 2;
				yourself).
]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogramNode >> rightHeight [
	" Answer a <Number> with the receiver's right children height "
	
	^ self right nodeHeight
]
