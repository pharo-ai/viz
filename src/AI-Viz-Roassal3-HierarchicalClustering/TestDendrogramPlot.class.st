Class {
	#name : #TestDendrogramPlot,
	#superclass : #TestCase,
	#instVars : [
		'dendrogram'
	],
	#category : #'AI-Viz-Roassal3-HierarchicalClustering-Tests'
}

{ #category : #running }
TestDendrogramPlot >> setUp [
	| elts engine |
	super setUp.

	elts := {
		AIVectorItem with: #a and: #(1 0).
		AIVectorItem with: #b and: #(1 0).
		AIVectorItem with: #c and: #(2 0).
		AIVectorItem with: #d and: #(3 0).
		AIVectorItem with: #e and: #(4 0).
		AIVectorItem with: #f and: #(5 0).
		AIVectorItem with: #g and: #(6 0).
		AIVectorItem with: #h and: #(7 0).
		AIVectorItem with: #i and: #(8 0).
		AIVectorItem with: #j and: #(9 0).
		AIVectorItem with: #k and: #(0 10).
		AIVectorItem with: #l and: #(0 10).
	}.

	engine := AIClusterEngine with: elts.
	engine hierarchicalClusteringUsing: #averageLinkage.
	dendrogram := engine dendrogram
]
