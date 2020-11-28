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
			with: [ spec repository: 'github://pharo-ai/MLMetrics:main/src' ].

		"Packages"
		spec 
			package: 'MLViz' with: [ spec requires: #('MLMetrics') ];
			package: 'MLViz-Tests' with: [ spec requires: #('MLViz').
				
		spec 
			group: 'Core' with: #('MLViz');
			group: 'default' with: #('Core') ] ].
		
	"Roassal is natively in Pharo 9"
	spec for: #'pharo8.x' do: [
		spec 
			baseline: 'Roassal2' 
			with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ].
			
		spec
			package: 'MLViz-Roassal2'
			with: [ spec requires: #('MLViz' 'Roassal2') ]			
	 ].

]
