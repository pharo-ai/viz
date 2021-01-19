Extension { #name : #AIDendrogram }

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogram >> plotLineIn: view from: startPoint to: endPoint [

	view canvas
		addShape:
			(TRLineShape new
				from: startPoint;
				to: endPoint;
				color: Color black;
				yourself).


]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogram >> totalDepth [

	^ self isRoot
		ifTrue: [ self nodeDepth * self depthFactor + self depthFactor ]
		ifFalse: [ self parent totalDepth ]

]

{ #category : #'*AI-Viz-Roassal2-HierarchicalClustering' }
AIDendrogram >> withAllSubtrees [
	| stream |

	stream := Array new writeStream.
	self inOrderDo: [ : e | stream nextPut: e ].
	^ stream contents
]
