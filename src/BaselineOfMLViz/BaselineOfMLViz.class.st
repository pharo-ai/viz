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
			baseline: 'MLMetrics' 				with: [ spec repository: 'github://pharo-ai/metrics/src' ];
			baseline: 'Datasets' 					with: [ spec repository: 'github://pharo-ai/Datasets' ];
			baseline: 'ContainersOrderedSet'	with: [ spec repository: 'github://pharo-containers/Containers-OrderedSet/src' ].

		"Packages"
		spec 
			package: 'MLViz' with: [ spec requires: #('AIMetrics' 'Datasets' 'ContainersOrderedSet') ];
			package: 'MLViz-Tests' with: [ spec requires: #('MLViz') ].
			
		self 
			baselineForPharo8: spec;
			baselineForPharo9: spec.
				
		spec 
			group: 'Core' with: #('MLViz' 'MLVizRoassal');
			group: 'default' with: #('Core') ].
		


]

{ #category : #baselines }
BaselineOfMLViz >> baselineForPharo8: spec [

	spec for: #'pharo8.x' do: [
		spec 
			baseline: 'Roassal2' 
			with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ].
			
		spec
			package: 'MLViz-Roassal2'
			with: [ spec requires: #('MLViz' 'Roassal2') ]	.
					
		spec group: 'MLVizRoassal' with: #('MLViz-Roassal2')	 ].		

]

{ #category : #baselines }
BaselineOfMLViz >> baselineForPharo9: spec [

	"Roassal is natively in Pharo 9"
	spec for: #'pharo9.x' do: [
		spec
			package: 'MLViz-Roassal3'
			with: [ spec requires: #('MLViz') ].
					
	spec group: 'MLVizRoassal' with: #('MLViz-Roassal3')	 ].	

]
