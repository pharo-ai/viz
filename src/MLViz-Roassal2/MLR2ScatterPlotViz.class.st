Class {
	#name : #MLR2ScatterPlotViz,
	#superclass : #MLRoassal2Viz,
	#instVars : [
		'labelConversionBlock',
		'numberOfTicks',
		'colors',
		'k'
	],
	#category : #'MLViz-Roassal2'
}

{ #category : #examples }
MLR2ScatterPlotViz class >> example01 [ 
	<example>
	
	MLR2ScatterPlotViz 
		plot: Datasets loadIris
		k: 3
]

{ #category : #examples }
MLR2ScatterPlotViz class >> example02 [
	<example>
	
	MLR2ScatterPlotViz 
		plot: Datasets loadIris
]

{ #category : #'instance creation' }
MLR2ScatterPlotViz class >> plot: aDataFrame [

	^ self new
		k: 1;
		initializeWithDataFrame: aDataFrame;
		plot
]

{ #category : #'instance creation' }
MLR2ScatterPlotViz class >> plot: aDataFrame k: predictedGroups [

	^ self new
		k: predictedGroups;
		initializeWithDataFrame: aDataFrame;
		plot
]

{ #category : #accessing }
MLR2ScatterPlotViz >> colorAt: keyName [
	" Answer a <Color> in the receiver's colors at keyName "

	^ self colors at: keyName
]

{ #category : #accessing }
MLR2ScatterPlotViz >> colors [
	" Answer a <Collection> of receiver's k <Color> instances "

	^ colors
		ifNil: [ colors := self defaultColors ]
]

{ #category : #accessing }
MLR2ScatterPlotViz >> colors: aCollection [ 
	" Set the receiver's colors to be aCollection "

	colors := aCollection
]

{ #category : #defaults }
MLR2ScatterPlotViz >> defaultColors [
	" Answer a <Collection> with defaults for the receiver's feature colors "

	^ k = 1 
		ifTrue: [ (self dfClusterNames collect: [ : featureName | featureName -> Color black ]) asDictionary ]
		ifFalse: [
			(self dfClusterNames
				with:  (Color wheel: self dfClusterNames size)
				collect: [ : featureName : colorName | featureName -> colorName ]) asDictionary ].

]

{ #category : #defaults }
MLR2ScatterPlotViz >> defaultLabelConversionBlock [
	" Answer a <BlockClosure> which converts label to appropriate format for displaying into the receiver's canvas "

	^ [ :n | 
			n == n asInteger 
			ifTrue: [ n asInteger ] 
			ifFalse: [ n asFloat ] ]

]

{ #category : #defaults }
MLR2ScatterPlotViz >> defaultNumberOfTicks [
	" Answer a <Number> with defaults for the receiver's number of ticks "

	^ 5
]

{ #category : #accessing }
MLR2ScatterPlotViz >> graphBuilderMetrics [
	" Answer the receiver's metrics "
	
	^ self graphBuilder metrics
]

{ #category : #accessing }
MLR2ScatterPlotViz >> graphObjects: aCollection [
	" Assume aCollection is a collection of Array. Set the builder's objects "

	self graphBuilder objects: (aCollection collect: #asArray)
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeGraphAxis [

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
MLR2ScatterPlotViz >> initializeGraphColors [

	| shape |
	
	shape := self graphBuilder shape.
	shape circle
		size: 3.5;
		color: [ :a | self colorAt: a last ].
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeGraphMetrics [
	" Private - Discard last column from receiver's data frame. Set the grpah builder metrics "

	self dfColumnNames allButLast doWithIndex: [ : colName : index | 
		self graphBuilderMetrics 
			at: colName 
			put: (self numberToSelectorMapAt: index) ].


	
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeGraphShape [

	self graphBuilder lineShape: 
		(RTStyledMultiLine new
			dashedLine;
			width: 0.5; 
			yourself).

	
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeLegendBuilder [
	" Set the receiver's legend. If we are just exploring the points cloud (k = 1) then omit legend "

	self k = 1
		ifTrue: [ ^ self ].
	self legendBuilder 
		view: self graphBuilder view;
		addText: self legendTitle.

	self colors keysDo: [ : key | 
		self legendBuilder 
			addColor: (self colorAt: key) 
			text: key ].

	self legendBuilder build.
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeWithDataFrame: aDataFrame [
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
MLR2ScatterPlotViz >> k [
	^ k
]

{ #category : #accessing }
MLR2ScatterPlotViz >> k: anObject [
	k := anObject
]

{ #category : #accessing }
MLR2ScatterPlotViz >> labelConversionBlock [

	^ labelConversionBlock
		ifNil: [ labelConversionBlock := self defaultLabelConversionBlock  ]

]

{ #category : #initialization }
MLR2ScatterPlotViz >> numberOfTicks [
	" Answer a <Number> with the number of ticks to be displayed "
	
	^ numberOfTicks
		ifNil: [ numberOfTicks := self defaultNumberOfTicks ]
]

{ #category : #private }
MLR2ScatterPlotViz >> numberToSelectorMapAt: aNumber [
	" Private - There should be an easier way to do this "

	^  { 
		1 -> #first .
		2 -> #second .
		3 -> #third .
		4 -> #fourth .
		5 -> #fifth
	 }	asDictionary at: aNumber
]

{ #category : #drawing }
MLR2ScatterPlotViz >> plot [
	" Open a new window with the receiver's rendered into it "

	self graphBuilder open.

]
