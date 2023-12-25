Extension { #name : #AIDendrogramNode }

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> inOrderDo: aBlock [
    " Visit the elements of the binary tree in order: left, then root, then right, applying a block to each element "

	self left inOrderDo: aBlock.
	aBlock value: self.
	self right inOrderDo: aBlock.
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> leftHeight [
	" Answer a <Number> with the receiver's left children height "
	
	^ self left nodeHeight
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> nodeDepth [
	" Answer a <Float> with the receiver's depth, the max of each child plus own distance "
	
	^ (self left nodeDepth max: self right nodeDepth) + 1
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> nodeHeight [
	" Answer a <Number> with the receiver's height, the sum of each branch "
	
	^ self left nodeHeight + self right nodeHeight
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> plotAt: aPoint scaling: thresholdHorizontalScaling view: aCanvas color: aColor [
	" Private - Render the receiver's into aView using aPoint as starting point. 
	Assuming an horizontal orientation, this method calculates the distance for 3 lines:
		The vertical line from the receiver to the leaves.
		The horizontal lines to both leaves.
	And then recursively render the leaves "

	| fromPointL toPointL fromPointR toPointR |

	"horizontal line extremitites for left branch"
	fromPointL := aPoint x @ (aPoint y - (self baselineHeight / 2 * self rightHeight)).
	toPointL := (self left thresholdPosition: thresholdHorizontalScaling) @ fromPointL y.

	"horizontal line extremitites for right branch"
	fromPointR := aPoint x @ (aPoint y + (self baselineHeight / 2 * self leftHeight)).
	toPointR := (self right thresholdPosition: thresholdHorizontalScaling) @ fromPointR y.

	self left 
		plotAt: toPointL
		scaling: thresholdHorizontalScaling 
		view: aCanvas
		color: aColor.

	self right
		plotAt: toPointR
		scaling: thresholdHorizontalScaling 
		view: aCanvas
		color: aColor.

	" Render vertical line from this node to the leaves "
	self 
		plotLineIn: aCanvas 
		from: fromPointL 
		to: fromPointR
		color: aColor.

	" Render horizontal line for the left branch "
	self left isLeaf 
		ifTrue: [ toPointL := 0 @ toPointL y ].
	self 
		plotLineIn: aCanvas 
		from: fromPointL
		to: toPointL
		color: aColor.

	" Render horizontal line for the right branch "
	self right isLeaf 
		ifTrue: [ toPointR := 0 @ toPointR y ].
	self plotLineIn: aCanvas 
		from: fromPointR
		to: toPointR
		color: aColor.

]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> plotDendrogram [
	" Open a view of the receiver's.
	Starting point to render the receiver using Roassal. Create a small line which is the root of the receiver's tree. Then recursively process the leaves. "

	| canvas thresholdScaling fromPoint toPoint |

	canvas := RSCanvas new.
	canvas @ RSCanvasController.

	thresholdScaling := self thresholdHorizontalScaling.

	"first horizontal line: root"
	fromPoint := (self thresholdPosition: thresholdScaling) @ (self heightFactor / 2).
	toPoint := (fromPoint x + self baselineLength) @ (fromPoint y).

	self 
		plotLineIn: canvas 
		from:  fromPoint 
		to: toPoint
		color: Color black.

	self 
		plotAt: toPoint 
		scaling: thresholdScaling
		view: canvas
		color: Color black.
	canvas inspect
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> plotLineIn: view from: startPoint to: endPoint color: aColor [
	"Add a line from startPoint to endPoint into view "

	view canvas
		add:
			(RSLine new
				from: startPoint;
				to: endPoint;
				color: aColor;
				width: 2;
				yourself).
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> rightHeight [
	" Answer a <Number> with the receiver's right children height "
	
	^ self right nodeHeight
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogramNode >> thresholdPosition: thresholdScaling [
	"X position depends on threshold of the node
	 -5 to have a minimal space before all leaves (all leaves are at 0)"

	^(self threshold * thresholdScaling) - self minimalLeafLine

]
