Extension { #name : #AIDendrogram }

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogram >> baselineHeight [
	"height of one line in the dendrogram plot"

	^20
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogram >> baselineLength [
	"length between two 'levels' in the dendrogram plot
	 Actual horizontal position of a level also depends on its #threshold"

	^30
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogram >> minimalLeafLine [
	"minimal length of a line to a leaf (threshold of the nodes close to 0 for which
	 #thresholdPosition: would return 0)"

	^5
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogram >> nodeDepth [

	self subclassResponsibility
]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogram >> thresholdHorizontalScaling [
	"computes the scale between a DendrogramNode's threshold and its horizontal position in the plot
	 - The total width of the plot is: max numer of levels * #baselineLength
	 - this width is divided by the max threshold (threshold of root) to get the scaling factor
	 - leafs of the dendrogram are all at x=0
	 - horizontal position of a node is its treshold * scaling factor
	 - everything is shifted left of #minimalLeafLine to ensure that nodes with a threshold close
	   to 0 still have a small line"

	^self isRoot
		ifTrue: [ -1 * (self minimalLeafLine + self nodeDepth * self baselineLength / self threshold) ]
		ifFalse: [ self parent thresholdHorizontalScaling ]

]

{ #category : #'*AI-Viz-Roassal3-HierarchicalClustering' }
AIDendrogram >> thresholdPosition: thresholdScaling [

	self subclassResponsibility

]
