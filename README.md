# Description

Machine-Learning Visualization API for Pharo. Provides a higher-level interface for machine learning plots. The idea is to write less code to plot machine learning results, by providing reasonable defaults for commonly used visualizations.

# Installation

```smalltalk
EpMonitor disableDuring: [
	Metacello new
		baseline: 'AIViz';
		repository: 'github://pharo-ai/viz/src';
		load ]
```

# If you want to depend on it

```smalltalk
spec 
   baseline: 'AIViz' 
   with: [ spec repository: 'github://pharo-ai/viz/src' ].
```

# Usage

WiP
