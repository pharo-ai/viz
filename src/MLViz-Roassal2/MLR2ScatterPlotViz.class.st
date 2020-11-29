Class {
	#name : #MLR2ScatterPlotViz,
	#superclass : #MLR2ScatterViz,
	#instVars : [
		'featureASelector',
		'featureBSelector',
		'data',
		'colorMap'
	],
	#category : #'MLViz-Roassal2'
}

{ #category : #examples }
MLR2ScatterPlotViz class >> example01 [ 
	<example>
	" The first column is the Sepal Length feature "
	" The second column is the Sepal Width feature "

	MLR2ScatterPlotViz 
		plot: Datasets loadIris
]

{ #category : #examples }
MLR2ScatterPlotViz class >> example02 [
	<example>
	" The first column is the Sepal Length feature "
	" The second column is the Sepal Width feature "

	MLR2ScatterPlotViz new
		k: 3;	
		featureASelector: #second;
		featureBSelector: #third;
		colors: { 
			'virginica' 	-> Color blue .
			'versicolor'	-> Color green .
			'setosa' 		-> Color red } asDictionary;
		initializeWithDataFrame: Datasets loadIris;
		plot.

]

{ #category : #'instance creation' }
MLR2ScatterPlotViz class >> plot: aDataFrame [

	^ self new
		k: 1;
		initializeWithDataFrame: aDataFrame;
		plot
]

{ #category : #accessing }
MLR2ScatterPlotViz >> data [
	^ data
		ifNil: [ data := RTData new ]
]

{ #category : #accessing }
MLR2ScatterPlotViz >> data: anObject [
	data := anObject
]

{ #category : #accessing }
MLR2ScatterPlotViz >> featureASelector [
	^ featureASelector
		ifNil: [ featureASelector := #first ]
]

{ #category : #accessing }
MLR2ScatterPlotViz >> featureASelector: anObject [
	featureASelector := anObject
]

{ #category : #accessing }
MLR2ScatterPlotViz >> featureBSelector [
	^ featureBSelector
		ifNil: [ featureBSelector := #second ]
]

{ #category : #accessing }
MLR2ScatterPlotViz >> featureBSelector: anObject [
	featureBSelector := anObject
]

{ #category : #accessing }
MLR2ScatterPlotViz >> graphObjects: aCollection [
	" Assume aCollection is a collection of Array. Set the builder's objects "

	self data points: (aCollection collect: #asArray)
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeColorMap [
	" Private - Set the receiver's colors of data points using colorMap <Collection> "

	self colors associationsDo: [ : assoc | 
		self data dotShape 
			if: [ :row | row last = assoc key ] 
			fillColor: assoc value.
		self legendBuilder 
			addColor: assoc value 
			text: assoc key ].
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeDataPoints [

	self graphObjects: self dataFrame asArrayOfRows.
	self data x: self featureASelector.
	self data y: self featureBSelector.
	self graphBuilder add: self data.
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeGraphAxis [
	" Private - Setup the axis labels and color "

	self graphBuilder axisY
		title: (self dfColumnNames perform: featureASelector);
		color: Color black.
	self graphBuilder axisX
		title: (self dfColumnNames perform: featureBSelector);
		color: Color black.
]

{ #category : #initialization }
MLR2ScatterPlotViz >> initializeWithDataFrame: aDataFrame [
	" Private - Initialize the receiver's internal state using data points in aDataFrame "

	self graphBuilder: RTGrapher new. 
	self dataFrame: aDataFrame.
	self 	
		initializeLegendBuilder;
		initializeColorMap;
		initializeDataPoints;
		initializeGraphAxis
]
