Class {
	#name : #MLR2ScatterPlotViz,
	#superclass : #MLRoassal2Viz,
	#instVars : [
		'labelConversionBlock',
		'colorDictionary',
		'numberOfTicks'
	],
	#category : #'MLViz-Roassal2'
}

{ #category : #examples }
MLR2ScatterPlotViz class >> example01 [ 
	<example>
	
	MLR2ScatterPlotViz plot: Datasets loadIris.
]

{ #category : #'instance creation' }
MLR2ScatterPlotViz class >> plot: aDataFrame [

	^ self new
		initializeWithDataFrame: aDataFrame;
		plot
]

{ #category : #accessing }
MLR2ScatterPlotViz >> colorDictionary [

	^ colorDictionary
		ifNil: [ colorDictionary := self defaultColorDictionary ]
]

{ #category : #defaults }
MLR2ScatterPlotViz >> defaultColorDictionary [
	" Answer a <Dictionary> with defaults for the receiver's feature colors "

	^ Dictionary new
		at: 'setosa' put: Color red;
		at: 'versicolor' put: Color green;
		at: 'virginica' put: Color blue; 
		yourself.
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
		color: [ :a | self colorDictionary at: a last ].
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeGraphMetrics [

	self graphBuilder metrics
		at: 'Sepal length' put: #first;
		at: 'Sepal width' put: #second;
		at: 'Petal length' put: #third; 
		at: 'Petal width' put: #fourth.

	
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

	self legendBuilder 
		view: self graphBuilder view;
		addText: self legendTitle.
	
	self colorDictionary keysDo: [ :k | 
		self legendBuilder addColor: (self colorDictionary at: k) text: 'Iris ', k ].
	self legendBuilder build.
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeWithDataFrame: aDataFrame [
	" Private - Initialize the receiver's internal state using data points in aDataFrame "

	self graphBuilder: RTScatterplotMatrix new. 
	self graphObjects: aDataFrame asArrayOfRows.
	self 	
		initializeGraphAxis;
		initializeGraphShape;
		initializeGraphColors;
		initializeGraphMetrics;
		initializeLegendBuilder.
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

{ #category : #drawing }
MLR2ScatterPlotViz >> plot [
	" Open a new window with the receiver's rendered into it "

	self graphBuilder open.

]
