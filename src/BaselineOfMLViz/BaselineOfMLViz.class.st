Class {
	#name : #BaselineOfMLViz,
	#superclass : #BaselineOf,
	#category : #BaselineOfMLViz
}

{ #category : #baselines }
BaselineOfMLViz >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'MLMetrics'
			with: [ spec repository: 'github://pharo-ai/MLMetrics/src' ].
				
		"Packages"
		spec 
			package: 'MLViz' with: [ spec requires: #('MLMetrics') ];
			package: 'MLViz-Tests' with: [ spec requires: #('MLViz') ] ]
]
