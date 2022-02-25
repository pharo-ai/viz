Class {
	#name : #BaselineOfAIViz,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIViz
}

{ #category : #baselines }
BaselineOfAIViz >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'AIMetrics' 						with: [ spec repository: 'github://pharo-ai/metrics/src' ];
			baseline: 'AIDatasets' 						with: [ spec repository: 'github://pharo-ai/Datasets' ];
			baseline: 'ContainersOrderedSet'			with: [ spec repository: 'github://pharo-containers/Containers-OrderedSet/src' ].

		"Packages"
		spec 
			package: 'AI-Viz' 						with: [ spec requires: #('AIMetrics' 'AIDatasets' 'ContainersOrderedSet') ].				
			"package: 'AI-Viz-Tests' 				with: [ spec requires: #('AI-Viz')".
			
		self 
			baselineForPharo8: spec;
			baselineForPharo9: spec.
				
		spec 
			group: 'Core' 							with: #('AI-Viz' 'AIVizRoassal');
			group: 'default' 						with: #('Core') ]


]

{ #category : #baselines }
BaselineOfAIViz >> baselineForPharo8: spec [

	spec for: #'pharo8.x' do: [
		spec 
			baseline: 'AIMetrics' 
			with: [ spec repository: 'github://pharo-ai/metrics/src' ];
			baseline: 'Roassal2' 
			with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ];
			baseline: 'AIHierarchicalClustering'
			with: [ spec repository: 'github://pharo-ai/hierarchical-clustering/src' ].
			
		spec
			package: 'AI-Viz-Roassal2'									with: [ spec requires: #('AI-Viz' 'Roassal2') ];
			package: 'AI-Viz-Roassal2-HierarchicalClustering' 	with: [ spec requires: #('AI-Viz-Roassal2' 'AIMetrics' 'AIDatasets' 'ContainersOrderedSet' 'AIHierarchicalClustering') ].							
						
		spec 
			group: 'AIVizRoassal' 	with: #('AI-Viz-Roassal2');
			group: 'AIVizRoassalHC'	with: #('AI-Viz-Roassal2-HierarchicalClustering')	 ].		

]

{ #category : #baselines }
BaselineOfAIViz >> baselineForPharo9: spec [

	"Roassal is natively in Pharo 9"
	spec for: #(#'pharo9.x' #'pharo10.x') do: [
		spec
			package: 'AI-Viz-Roassal3'
			with: [ spec requires: #('AI-Viz') ].
					
	spec group: 'AIVizRoassal' with: #('AI-Viz-Roassal3')	 ].	

]
