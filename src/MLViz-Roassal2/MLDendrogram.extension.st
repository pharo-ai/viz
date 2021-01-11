Extension { #name : #MLDendrogram }

{ #category : #'*MLViz-Roassal2' }
MLDendrogram >> plotLineIn: view from: startPoint to: endPoint [

	view canvas
		addShape:
			(TRLineShape new
				from: startPoint;
				to: endPoint;
				color: Color black;
				yourself).


]

{ #category : #'*MLViz-Roassal2' }
MLDendrogram >> totalDepth [

	^ self isRoot
		ifTrue: [ self nodeDepth * self depthFactor + self depthFactor ]
		ifFalse: [ self parent totalDepth ]

]

{ #category : #'*MLViz-Roassal2' }
MLDendrogram >> withAllSubtrees [
	| stream |

	stream := Array new writeStream.
	self inOrderDo: [ : e | stream nextPut: e ].
	^ stream contents
]
