"
This class provides defaults for axis, subplots, for the Roassal visualization engine. It also provides subclasses with a legend builder and legend title accessors.

Internal Representation and Key Implementation Points.

    Instance Variables
	graphBuilder:		<Object>
	legendBuilder:		<RTLegendBuilder>
	legendTitle:			<String>


    Implementation Points
"
Class {
	#name : #MLRoassal2Viz,
	#superclass : #MLViz,
	#instVars : [
		'legendBuilder',
		'graphBuilder',
		'legendTitle'
	],
	#category : #'MLViz-Roassal2'
}

{ #category : #defaults }
MLRoassal2Viz >> defaultLegendTitle [
	" Answer a <String> with the text for the receiver's Legend box "
	
	^ 'Legend'
]

{ #category : #accessing }
MLRoassal2Viz >> graphBuilder [
	^ graphBuilder
]

{ #category : #accessing }
MLRoassal2Viz >> graphBuilder: anObject [
	graphBuilder := anObject
]

{ #category : #accessing }
MLRoassal2Viz >> legendBuilder [
	" Answer a <RTLegendBuilder> to describe receiver's elements "

	^ legendBuilder
		ifNil: [ legendBuilder := RTLegendBuilder new ]
]

{ #category : #accessing }
MLRoassal2Viz >> legendBuilder: anObject [
	legendBuilder := anObject
]

{ #category : #initialization }
MLRoassal2Viz >> legendTitle [
	" Answer a <String> with the receiver's legend title "

	^ legendTitle
		ifNil: [ legendTitle := self defaultLegendTitle ]
]

{ #category : #accessing }
MLRoassal2Viz >> legendTitle: anObject [
	legendTitle := anObject
]
