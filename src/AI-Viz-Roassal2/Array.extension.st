Extension { #name : #Array }

{ #category : #'*AI-Viz-Roassal2' }
Array >> withAllSubtrees [

	^ (self collect: #withAllSubtrees) flatten
]
