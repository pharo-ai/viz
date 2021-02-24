Class {
	#name : #AIR2ScatterMatrixViz,
	#superclass : #AIR2ScatterViz,
	#instVars : [
		'labelConversionBlock',
		'numberOfTicks'
	],
	#category : #'AI-Viz-Roassal2'
}

{ #category : #examples }
AIR2ScatterMatrixViz class >> example01 [ 
	<example>
	
	AIR2ScatterMatrixViz 
		plot: AIDatasets loadIris
		k: 3
]

{ #category : #examples }
AIR2ScatterMatrixViz class >> example02 [
	<example>
	
	AIR2ScatterMatrixViz 
		plot: AIDatasets loadIris
]

{ #category : #'instance creation' }
AIR2ScatterMatrixViz class >> plot: aDataFrame [

	^ self new
		k: 1;
		initializeWithDataFrame: aDataFrame;
		plot
]

{ #category : #'instance creation' }
AIR2ScatterMatrixViz class >> plot: aDataFrame k: predictedGroups [

	^ self new
		k: predictedGroups;
		initializeWithDataFrame: aDataFrame;
		plot
]

{ #category : #defaults }
AIR2ScatterMatrixViz >> defaultLabelConversionBlock [
	" Answer a <BlockClosure> which converts label to appropriate format for displaying into the receiver's canvas "

	^ [ :n | 
			n == n asInteger 
			ifTrue: [ n asInteger ] 
			ifFalse: [ n asFloat ] ]

]

{ #category : #defaults }
AIR2ScatterMatrixViz >> defaultNumberOfTicks [
	" Answer a <Number> with defaults for the receiver's number of ticks "

	^ 5
]

{ #category : #accessing }
AIR2ScatterMatrixViz >> graphBuilderMetrics [
	" Answer the receiver's metrics "
	
	^ self graphBuilder metrics
]

{ #category : #accessing }
AIR2ScatterMatrixViz >> graphObjects: aCollection [
	" Assume aCollection is a collection of Array. Set the builder's objects "

	self graphBuilder objects: (aCollection collect: #asArray)
]

{ #category : #initialization }
AIR2ScatterMatrixViz >> initializeGraphAxis [

	self graphBuilder axisX 
		numberOfTicks: self numberOfTicks;
		rotateLabels;
		labelConversion: self labelConversionBlock;
		color: Color black.

	self graphBuilder axisY 
		numberOfTicks: 5;
		labelConversion: self numberOfTicks;
		color: Color black.

]

{ #category : #initialization }
AIR2ScatterMatrixViz >> initializeGraphColors [

	| shape |
	
	shape := self graphBuilder shape.
	shape circle
		size: 3.5;
		color: [ :a | self colorAt: a last ].
]

{ #category : #initialization }
AIR2ScatterMatrixViz >> initializeGraphMetrics [
	" Private - Discard last column from receiver's data frame. Set the grpah builder metrics "

	self dfColumnNames allButLast doWithIndex: [ : colName : index | 
		self graphBuilderMetrics 
			at: colName 
			put: (self numberToSelectorMapAt: index) ].


	
]

{ #category : #initialization }
AIR2ScatterMatrixViz >> initializeGraphShape [

	self graphBuilder lineShape: 
		(RTStyledMultiLine new
			dashedLine;
			width: 0.5; 
			yourself).

	
]

{ #category : #initialization }
AIR2ScatterMatrixViz >> initializeWithDataFrame: aDataFrame [
	" Private - Initialize the receiver's internal state using data points in aDataFrame "

	self graphBuilder: RTScatterplotMatrix new. 
	self dataFrame: aDataFrame.
	self graphObjects: self dataFrame asArrayOfRows.
	self 	
		initializeGraphAxis;
		initializeGraphShape;
		initializeGraphColors;
		initializeGraphMetrics;
		initializeLegendBuilder.
]

{ #category : #accessing }
AIR2ScatterMatrixViz >> labelConversionBlock [

	^ labelConversionBlock
		ifNil: [ labelConversionBlock := self defaultLabelConversionBlock  ]

]

{ #category : #initialization }
AIR2ScatterMatrixViz >> numberOfTicks [
	" Answer a <Number> with the number of ticks to be displayed "
	
	^ numberOfTicks
		ifNil: [ numberOfTicks := self defaultNumberOfTicks ]
]

{ #category : #private }
AIR2ScatterMatrixViz >> numberToSelectorMapAt: aNumber [
	" Private - There should be an easier way to do this "

	^  { 
		1 -> #first .
		2 -> #second .
		3 -> #third .
		4 -> #fourth .
		5 -> #fifth
	 }	asDictionary at: aNumber
]
