Extension { #name : #Array }

{ #category : #'*MLViz-Roassal2' }
Array >> withAllSubtrees [

	^ (self collect: #withAllSubtrees) flatten
]
